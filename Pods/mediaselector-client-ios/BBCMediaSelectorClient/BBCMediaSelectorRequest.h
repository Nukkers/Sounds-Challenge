//
//  BBCMediaSelectorRequest.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 04/02/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

@import Foundation;
#import "MediaSelectorDefines.h"
#import "BBCMediaSelectorSecureConnectionPreference.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCMediaSelectorRequestParameter;

NS_SWIFT_NAME(MediaSelectorRequest)
@interface BBCMediaSelectorRequest : NSObject
MEDIA_SELECTOR_INIT_UNAVAILABLE

@property (nonatomic, readonly, getter=isSecure) BOOL secure;
@property (nonatomic, readonly) BOOL hasMediaSet;
@property (nonatomic, copy, readonly) NSArray<BBCMediaSelectorRequestParameter *> *parameters;
@property (nonatomic, readonly) BBCMediaSelectorSecureConnectionPreference secureConnectionPreference;

- (instancetype)initWithVPID:(NSString *)vpid NS_DESIGNATED_INITIALIZER NS_SWIFT_NAME(init(vpid:));
- (instancetype)initWithRequest:(BBCMediaSelectorRequest *)request;

- (instancetype)withMediaSet:(NSString *)mediaSet NS_SWIFT_NAME(with(mediaSet:));
- (instancetype)withProtocol:(NSString *)protocol NS_SWIFT_NAME(with(protocol:));
- (instancetype)withTransferFormats:(NSArray<NSString *> *)transferFormats NS_SWIFT_NAME(with(transferFormats:));
- (instancetype)withSAMLToken:(NSString *)samlToken NS_SWIFT_NAME(with(samlToken:));
- (instancetype)withCeiling:(NSString *)ceiling NS_SWIFT_NAME(with(ceiling:));
- (instancetype)withSecureConnectionPreference:(BBCMediaSelectorSecureConnectionPreference)secureConnectionPreference NS_SWIFT_NAME(with(secureConnectionPreference:));

- (BOOL)isValid:(NSError * __autoreleasing *)error NS_REFINED_FOR_SWIFT;

@end

NS_ASSUME_NONNULL_END
