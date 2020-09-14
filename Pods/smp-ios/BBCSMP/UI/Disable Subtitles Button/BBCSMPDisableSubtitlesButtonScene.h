//
//  BBCSMPDisableSubtitlesButtonScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 28/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPDisableSubtitlesButtonScene;

@protocol BBCSMPDisableSubtitlesButtonSceneDelegate <NSObject>
@required

- (void)disableSubtitlesButtonSceneDidReceiveTap:(id<BBCSMPDisableSubtitlesButtonScene>)disableSubtitlesScene;

@end

@protocol BBCSMPDisableSubtitlesButtonScene <NSObject>
@required

@property (nonatomic, weak, nullable) id<BBCSMPDisableSubtitlesButtonSceneDelegate> disableSubtitlesDelegate;

- (void)showDisableSubtitlesButton;
- (void)hideDisableSubtitlesButton;

@end

NS_ASSUME_NONNULL_END
