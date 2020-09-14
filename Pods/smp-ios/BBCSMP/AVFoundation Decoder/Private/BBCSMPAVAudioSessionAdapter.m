//
//  BBCSMPAVAudioSessionAdapter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 15/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "AVAudioSessionProtocol.h"
#import "BBCSMPAVAudioSessionAdapter.h"
#import <AVFoundation/AVFoundation.h>

@implementation BBCSMPAVAudioSessionAdapter {
    id<AVAudioSessionProtocol> _audioSession;
    NSNotificationCenter* _notificationCenter;
    NSOperationQueue* _queue;
    NSSet<NSString*>* _internalAudioRoutes;
}

@synthesize delegate = _delegate;

- (void)dealloc
{
    [_notificationCenter removeObserver:self];
}

- (instancetype)initWithAudioSession:(id<AVAudioSessionProtocol>)audioSession
                  notificationCenter:(NSNotificationCenter*)notificationCenter
                      operationQueue:(NSOperationQueue*)operationQueue
{
    self = [super init];
    if (self) {
        _audioSession = audioSession;
        _notificationCenter = notificationCenter;
        _queue = operationQueue;
        [notificationCenter addObserver:self
                               selector:@selector(audioRouteDidChange:)
                                   name:AVAudioSessionRouteChangeNotification
                                 object:audioSession];

        NSArray* internalRoutes = @[ AVAudioSessionPortBuiltInSpeaker, AVAudioSessionPortBluetoothA2DP, AVAudioSessionPortLineOut, AVAudioSessionPortHeadphones ];
        _internalAudioRoutes = [NSSet setWithArray:internalRoutes];
    }

    return self;
}

- (void)audioRouteDidChange:(NSNotification*)notification
{
    // According to https://developer.apple.com/reference/avfoundation/avaudiosessionroutechangenotification the notification AVAudioSessionRouteChangeNotification should be posted on the main thread. This is not the case.
    __weak typeof(self) weakSelf = self;
    [_queue addOperationWithBlock:^{
        [weakSelf.delegate audioSessionRoutingDidChange:self];
    }];
}

- (BOOL)audioRoutedToExternalDevice
{
    return ![_internalAudioRoutes member:[self currentPort]];
}

- (NSString*)currentPort
{
    AVAudioSessionPortDescription* portDescription = [[[_audioSession currentRoute] outputs] firstObject];
    return [portDescription portType];
}

@end
