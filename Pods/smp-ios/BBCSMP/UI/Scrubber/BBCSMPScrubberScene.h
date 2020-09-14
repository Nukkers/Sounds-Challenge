//
//  BBCSMPScrubberScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 31/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPScrubberScene;

@protocol BBCSMPScrubberSceneDelegate <NSObject>
@required

- (void)scrubberScene:(id<BBCSMPScrubberScene>)scrubberScene didScrubToPosition:(NSNumber *)position;
- (void)scrubberSceneDidBeginScrubbing:(id<BBCSMPScrubberScene>)scrubberScene;
- (void)scrubberSceneDidFinishScrubbing:(id<BBCSMPScrubberScene>)scrubberScene;
- (void)scrubberSceneDidReceiveAccessibilityIncrement:(id<BBCSMPScrubberScene>)scrubberScene;
- (void)scrubberSceneDidReceiveAccessibilityDecrement:(id<BBCSMPScrubberScene>)scrubberScene;

@end

@protocol BBCSMPScrubberScene <NSObject>
@required

@property (nonatomic, weak, nullable) id<BBCSMPScrubberSceneDelegate> scrubberDelegate;

- (void)showScrubber;
- (void)hideScrubber;
- (void)setScrubberAccessibilityLabel:(NSString *)accessibilityLabel;
- (void)setScrubberAccessibilityHint:(NSString *)accessibilityHint;
- (void)setScrubberAccessibilityValue:(NSString *)accessibilityValue;

@end

NS_ASSUME_NONNULL_END
