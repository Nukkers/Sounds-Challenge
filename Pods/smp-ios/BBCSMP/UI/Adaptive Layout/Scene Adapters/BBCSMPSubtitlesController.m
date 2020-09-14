//
//  BBCSMPSubtitlesController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPSubtitlesController.h"
#import "BBCSMPSubtitleView.h"

@implementation BBCSMPSubtitlesController {
    BBCSMPSubtitleView *_subtitlesView;
}

#pragma mark Initialization

- (instancetype)initWithSubtitlesView:(BBCSMPSubtitleView *)subtitlesView
{
    self = [super init];
    if(self) {
        _subtitlesView = subtitlesView;
    }
    
    return self;
}

#pragma mark BBCSMPSubtitleScene

- (void)showSubtitles
{
    _subtitlesView.hidden = NO;
}

- (void)hideSubtitles
{
    _subtitlesView.hidden = YES;
}

- (void)styleDictionaryUpdated:(NSDictionary *)styleDictionary baseStyleKey:(NSString *)baseStyleKey
{
    [_subtitlesView styleDictionaryUpdated:styleDictionary baseStyleKey:baseStyleKey];
}

- (void)subtitlesUpdated:(NSArray<BBCSMPSubtitle *> *)subtitles
{
    [_subtitlesView subtitlesUpdated:subtitles];
}

@end
