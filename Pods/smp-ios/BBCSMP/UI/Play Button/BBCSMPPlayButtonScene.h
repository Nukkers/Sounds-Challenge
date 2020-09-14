//
//  BBCSMPPlayButtonScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 28/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPPlayButtonScene;
@protocol BBCSMPIcon;
@class UIColor;

@protocol BBCSMPPlayButtonSceneDelegate <NSObject>
@required

- (void)playButtonSceneDidReceiveTap:(id<BBCSMPPlayButtonScene>)playButtonScene;

@end

@protocol BBCSMPPlayButtonScene <NSObject>
@required

@property (nonatomic, weak, nullable) id<BBCSMPPlayButtonSceneDelegate> playButtonDelegate;

- (void)showPlayButton;
- (void)hidePlayButton;
- (void)setPlayButtonIcon:(id<BBCSMPIcon>)icon;
- (void)setPlayButtonHighlightColor:(UIColor *)highlightColor;
- (void)setPlayButtonAccessibilityLabel:(NSString *)accessibilityLabel;
- (void)setPlaybuttonAccessibilityHint:(NSString *)accessibilityHint;

@end

NS_ASSUME_NONNULL_END
