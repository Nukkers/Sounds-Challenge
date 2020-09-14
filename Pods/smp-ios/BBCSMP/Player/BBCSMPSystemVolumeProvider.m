//
//  BBCSMPSystemVolumeProvider.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 23/03/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPSystemVolumeProvider.h"
#import <AVFoundation/AVFoundation.h>

@interface BBCSMPSystemVolumeProvider ()

@property (nonatomic, strong) AVAudioSession* audioSession;

@end

@implementation BBCSMPSystemVolumeProvider

@synthesize delegate;

- (instancetype)init
{
    return [self initWithAudioSession:[AVAudioSession sharedInstance]];
}

- (instancetype)initWithAudioSession:(id)audioSession
{
    if ((self = [super init])) {
        self.audioSession = audioSession;
        [self.audioSession addObserver:self
                            forKeyPath:@"outputVolume"
                               options:NSKeyValueObservingOptionNew
                               context:nil];
    }

    return self;
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary<NSString*, id>*)change context:(void*)context
{
    [self.delegate didUpdateVolume:[self currentVolume]];
}

- (float)currentVolume
{
    return self.audioSession.outputVolume;
}

- (void)dealloc
{
    [self.audioSession removeObserver:self
                           forKeyPath:@"outputVolume"];
}

@end
