//
//  BBCHTTPDeviceInformation.h
//  BBCHTTPClient
//
//  Created by Timothy James Condon on 03/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(DeviceInformation)
@interface BBCHTTPDeviceInformation: NSObject

@property (class, nonatomic, readonly) NSString *deviceSystemName;
@property (class, nonatomic, readonly) NSString *deviceSystemVersion;

@end

NS_ASSUME_NONNULL_END
