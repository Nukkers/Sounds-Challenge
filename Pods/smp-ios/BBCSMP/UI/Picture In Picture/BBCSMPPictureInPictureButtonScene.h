//
//  BBCSMPPictureInPictureButtonScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 23/12/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPPictureInPictureButtonScene;

@protocol BBCSMPPictureInPictureButtonSceneDelegate <NSObject>
@required

- (void)pictureInPictureSceneDidTapToggle:(id<BBCSMPPictureInPictureButtonScene>)pictureInPictureButtonScene NS_SWIFT_NAME(pictureInPictureSceneDidTapToggle(_:));

@end


@protocol BBCSMPIcon;

@protocol BBCSMPPictureInPictureButtonScene <NSObject>
@required

@property (nonatomic, weak, nullable) id<BBCSMPPictureInPictureButtonSceneDelegate> pictureInPictureSceneDelegate;

- (void)showPictureInPictureButton;
- (void)hidePictureInPictureButton;
- (void)setPictureInPictureButtonAccessibilityLabel:(NSString *)accessibilityLabel;
- (void)setPictureInPictureButtonAccessibilityHint:(NSString *)accessibilityHint;
- (void)renderIcon:(id<BBCSMPIcon>)icon;

@end

NS_ASSUME_NONNULL_END
