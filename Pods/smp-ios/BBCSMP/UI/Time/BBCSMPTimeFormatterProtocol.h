//
//  BBCSMPTimeFormatterProtocol.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 26/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBCSMPTime;
@class BBCSMPDuration;

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPTimeFormatterProtocol <NSObject>
@required

- (NSString*)stringFromTime:(BBCSMPTime*)time;
- (NSString*)stringFromDuration:(BBCSMPDuration*)duration;

@end

NS_ASSUME_NONNULL_END
