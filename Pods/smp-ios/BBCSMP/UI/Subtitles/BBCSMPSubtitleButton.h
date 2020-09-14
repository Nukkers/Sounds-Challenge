//
//  BBCSMPSubtitleButton.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 19/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPSubtitleButton : BBCSMPButton

+ (instancetype)subtitleButton;

@property (nonatomic, strong) id<BBCSMPIcon> subtitlesIcon;

@end

NS_ASSUME_NONNULL_END
