//
//  BBCSMPContentPlaceholderScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 30/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UIImage;
@protocol BBCSMPContentPlaceholderScene;

@protocol BBCSMPContentPlaceholderSceneDelegate <NSObject>
@required

- (void)contentPlaceholderSceneSizeDidChange:(id<BBCSMPContentPlaceholderScene>)contentPlaceholderScene;

@end

@protocol BBCSMPContentPlaceholderScene <NSObject>
@required

@property (nonatomic, weak, nullable) id<BBCSMPContentPlaceholderSceneDelegate> delegate;
@property (nonatomic, readonly) CGSize placeholderSize;

- (void)appear;
- (void)disappear;
- (void)showPlaceholderImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
