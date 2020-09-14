//
//  BBCSMPFullscreenScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 16/05/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPFullscreenScene;
@protocol BBCSMPIcon;

@protocol BBCSMPFullscreenSceneDelegate <NSObject>
@required

- (void)fullscreenSceneDidTapToggleFullscreenButton:(id<BBCSMPFullscreenScene>)fullscreenScene;

@end

@protocol BBCSMPFullscreenScene <NSObject>
@required

@property (nonatomic, weak, nullable) id<BBCSMPFullscreenSceneDelegate> fullscreenDelegate;

- (void)showFullScreenButton;
- (void)hideFullScreenButton;
- (void)renderFullscreenButtonIcon:(id<BBCSMPIcon>)icon;
- (void)setFullscreenButtonAccessibilityLabel:(NSString *)accessibilityLabel;
- (void)setFullscreenButtonAccessibilityHint:(NSString *)accessibilityHint;

@end

NS_ASSUME_NONNULL_END
