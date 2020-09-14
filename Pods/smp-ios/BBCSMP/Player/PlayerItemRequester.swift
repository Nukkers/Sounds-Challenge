//
//  PlayerItemRequester.swift
//  SMP
//
//  Created by Matt Mould on 21/08/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation

@objc(BBCSMPPlayerItemRequester)
public class PlayerItemRequester: NSObject {
    private var pendingItemRequestToken: String?

    private func isAwaitedResponse(responseToken: String?) -> Bool {
        guard let unwrappedPendingItemRequestToken = self.pendingItemRequestToken else {return false}
        return unwrappedPendingItemRequestToken == responseToken
    }

    private func wrapSuccessCallback(_ success: @escaping (BBCSMPItem?) -> Void) -> (BBCSMPItem?) -> Void {
        let requestToken = NSUUID.init().uuidString
        self.pendingItemRequestToken = requestToken

        return {[weak self] (item: BBCSMPItem?) -> Void in
        guard let unwrappedSelf = self else {return}
            if unwrappedSelf.isAwaitedResponse(responseToken: requestToken) {success(item)}
        }
    }

    @objc
    public func requestItem(itemProvider: BBCSMPItemProvider,
                            success: @escaping (BBCSMPItem?) -> Void,
                            failure: @escaping (Error?) -> Void) {
        itemProvider.requestPlayerItem(success: wrapSuccessCallback(success),
                                       failure: {(error: Error?) -> Void in failure(error)})
    }

    @objc
    public func requestFailoverItem(itemProvider: BBCSMPItemProvider,
                                    success: @escaping (BBCSMPItem?) -> Void,
                                    failure: @escaping (Error?) -> Void) {
        itemProvider.requestFailoverPlayerItem(success: wrapSuccessCallback(success),
                                               failure: {(error: Error?) -> Void in failure(error)})
    }

    @objc
    public func cancelPendingRequest() {
        pendingItemRequestToken = nil
    }
}
