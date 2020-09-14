//
//  BBCSMPTimeLabelScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 26/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPTimeLabelScene <NSObject>
@required

- (void)setRelativeTimeStringWithPlayheadPosition:(NSString *)playheadPosition duration:(NSString *)duration;
- (void)setAbsoluteTimeString:(NSString *)absoluteTimeString;
- (void)showTime;
- (void)hideTime;

@end

NS_ASSUME_NONNULL_END
