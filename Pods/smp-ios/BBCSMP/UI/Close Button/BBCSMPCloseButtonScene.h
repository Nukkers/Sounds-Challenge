//
//  BBCSMPCloseButtonScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 23/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPCloseButtonScene;
@protocol BBCSMPIcon;

@protocol BBCSMPCloseButtonSceneDelegate <NSObject>
@required

- (void)closeButtonSceneDidTapClose:(id<BBCSMPCloseButtonScene>)closeButtonScene;

@end

@protocol BBCSMPCloseButtonScene <NSObject>
@required

@property (nonatomic, weak, nullable) id<BBCSMPCloseButtonSceneDelegate> closeButtonDelegate;

- (void)hide;
- (void)show;
- (void)setCloseButtonIcon:(id<BBCSMPIcon>)icon;
- (void)setCloseButtonAccessibilityLabel:(NSString *)accessibilityLabel;
- (void)setCloseButtonAccessibilityHint:(NSString *)accessibilityHint;

@end

NS_ASSUME_NONNULL_END
