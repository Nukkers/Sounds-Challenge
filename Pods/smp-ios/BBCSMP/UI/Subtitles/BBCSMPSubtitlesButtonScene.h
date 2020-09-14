//
//  BBCSMPSubtitlesButtonScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 03/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPEnableSubtitlesButtonScene.h"
#import "BBCSMPDisableSubtitlesButtonScene.h"

@protocol BBCSMPSubtitlesButtonScene;

@protocol BBCSMPSubtitlesButtonSceneDelegate <NSObject>
@required

- (void)subtitlesButtonSceneDidTapEnableSubtitlesButton:(nonnull id<BBCSMPSubtitlesButtonScene>)subtitlesButtonScene;
- (void)subtitlesButtonSceneDidTapDisableSubtitlesButton:(nonnull id<BBCSMPSubtitlesButtonScene>)subtitlesButtonScene;

// TODO: Remove
- (void)subtitlesButtonSceneDidTapToggleSubtitles:(nonnull id<BBCSMPSubtitlesButtonScene>)subtitlesButtonScene;

@end

@protocol BBCSMPSubtitlesButtonScene <BBCSMPEnableSubtitlesButtonScene,
                                      BBCSMPDisableSubtitlesButtonScene>
@required

@property (nonatomic, weak, nullable) id<BBCSMPSubtitlesButtonSceneDelegate> subtitlesButtonDelegate;

@end
