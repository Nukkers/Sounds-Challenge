//
//  BBCSMPEnableSubtitlesButtonScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 28/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPEnableSubtitlesButtonScene;

@protocol BBCSMPEnableSubtitlesButtonSceneDelegate <NSObject>
@required

- (void)enableSubtitlesButtonSceneDidReceiveTap:(id<BBCSMPEnableSubtitlesButtonScene>)enableSubtitlesScene;

@end

@protocol BBCSMPEnableSubtitlesButtonScene <NSObject>
@required

@property (nonatomic, weak, nullable) id<BBCSMPEnableSubtitlesButtonSceneDelegate> enableSubtitlesDelegate;

- (void)showEnableSubtitlesButton;
- (void)hideEnableSubtitlesButton;

@end

NS_ASSUME_NONNULL_END
