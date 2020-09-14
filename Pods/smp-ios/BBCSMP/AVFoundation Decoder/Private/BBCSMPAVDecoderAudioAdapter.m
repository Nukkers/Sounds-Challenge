//
//  BBCSMPAVDecoderAudioAdapter.m
//  BBCSMP
//
//  Created by Thomas Sherwood on 29/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "AVAudioSessionProtocol.h"
#import "BBCSMPAVComponentFactory.h"
#import "BBCSMPAVDecoderAudioAdapter.h"
#import <AVFoundation/AVFoundation.h>

@implementation BBCSMPAVDecoderAudioAdapter {
    id<AVAudioSessionProtocol> _audioSession;
}

#pragma mark Initializer

- (instancetype)initWithComponentFactory:(id<BBCSMPAVComponentFactory>)componentFactory
{
    self = [super init];
    if (self) {
        _audioSession = [componentFactory audioSession];
    }

    return self;
}

#pragma mark Public

- (void)prepareSessionForPlayback
{
    NSError *setCategoryError, *activationErr;
    [_audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
    [_audioSession setActive:YES error:&activationErr];
    if (@available(iOS 11.0, *)) {
        [_audioSession setCategory:AVAudioSessionCategoryPlayback mode:AVAudioSessionModeDefault routeSharingPolicy:AVAudioSessionRouteSharingPolicyLongForm options:0x0 error:&setCategoryError];
    }
}

@end
