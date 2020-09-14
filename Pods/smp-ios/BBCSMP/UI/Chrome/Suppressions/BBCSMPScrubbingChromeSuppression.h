//
//  BBCSMPScrubbingChromeSuppression.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 08/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPScrubberController;
@protocol BBCSMPChromeSupression;

@interface BBCSMPScrubbingChromeSuppression : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithChromeSuppression:(id<BBCSMPChromeSupression>)chromeSuppression
                       scrubberController:(BBCSMPScrubberController*)scrubberController NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
