//
//  BBCSMPPauseButtonScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 28/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPPauseButtonScene;
@protocol BBCSMPIcon;

@protocol BBCSMPPauseButtonSceneDelegate <NSObject>
@required

- (void)pauseButtonSceneDidReceiveTap:(id<BBCSMPPauseButtonScene>)pauseButtonScene;

@end

@protocol BBCSMPPauseButtonScene <NSObject>
@required

@property (nonatomic, weak, nullable) id<BBCSMPPauseButtonSceneDelegate> pauseButtonDelegate;

- (void)showPauseButton;
- (void)hidePauseButton;
- (void)setPauseButtonIcon:(id<BBCSMPIcon>)icon;
- (void)setPauseButtonAccessibilityLabel:(NSString *)accessibilityLabel;
- (void)setPauseButtonAccessibilityHint:(NSString *)accessibilityHint;

@end

NS_ASSUME_NONNULL_END
