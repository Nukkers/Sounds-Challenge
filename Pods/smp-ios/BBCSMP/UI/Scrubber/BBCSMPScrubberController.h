//
//  BBCSMPScrubberController.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/12/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPScrubberScene.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPScrubberInteractionObserver <NSObject>
@required

- (void)scrubberDidBeginScrubbing;
- (void)scrubberDidFinishScrubbing;
- (void)scrubberDidScrubToPosition:(NSNumber *)position;
- (void)scrubberDidReceiveAccessibilityIncrement;
- (void)scrubberDidReceiveAccessibilityDecrement;

@end

#pragma mark -

@interface BBCSMPScrubberController : NSObject <BBCSMPScrubberSceneDelegate>

- (void)addObserver:(id<BBCSMPScrubberInteractionObserver>)observer;

@end

NS_ASSUME_NONNULL_END
