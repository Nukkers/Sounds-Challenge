//
//  BBCMediaSelectorSecureConnectionPreference.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 30/09/2016.
//  Copyright © 2016 Michael Emmens. All rights reserved.
//

@import Foundation;

typedef NS_ENUM(NSInteger, BBCMediaSelectorSecureConnectionPreference) {
    BBCMediaSelectorSecureConnectionPreferSecure = 0,
    BBCMediaSelectorSecureConnectionEnforceSecure,
    BBCMediaSelectorSecureConnectionEnforceNonSecure,
    BBCMediaSelectorSecureConnectionUseServerResponse
} NS_SWIFT_NAME(MediaSelectorSecureConnectionPreference);
