//
//  BBCSMPStopButtonScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 28/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPStopButtonScene;
@protocol BBCSMPIcon;

@protocol BBCSMPStopButtonSceneDelegate <NSObject>
@required

- (void)stopButtonDidReceiveTap:(id<BBCSMPStopButtonScene>)stopButton;

@end

@protocol BBCSMPStopButtonScene <NSObject>
@required

@property (nonatomic, weak, nullable) id<BBCSMPStopButtonSceneDelegate> stopButtonDelegate;

- (void)showStopButton;
- (void)hideStopButton;
- (void)setStopButtonIcon:(id<BBCSMPIcon>)icon;
- (void)setStopButtonAccessibilityLabel:(NSString *)accessibilityLabel;
- (void)setStopButtonAccessibilityHint:(NSString *)accessibilityHint;

@end

NS_ASSUME_NONNULL_END
