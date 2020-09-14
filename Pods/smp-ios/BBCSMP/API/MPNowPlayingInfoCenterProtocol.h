//
//  MPNowPlayingInfoCenterProtocol.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 28/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MPNowPlayingInfoCenterProtocol <NSObject>
@required

@property (copy, nullable) NSDictionary<NSString *, id> *nowPlayingInfo;

@end
