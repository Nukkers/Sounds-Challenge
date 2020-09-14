//
//  BBCSMPAVSystemSuspension.m
//  SMP
//
//  Created by Matt Mould on 29/11/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "BBCSMPAVSystemSuspension.h"

@interface BBCSMPAVSystemSuspension()
@property (nonatomic, weak) id<BBCSMPSystemSuspensionListener> systemSuspensionListener;
@property(nonatomic, strong) NSNotificationCenter *notificationCenter;
@end

@implementation BBCSMPAVSystemSuspension

- (instancetype)init
{
    self = [super init];
    if (self) {
        _notificationCenter = NSNotificationCenter.defaultCenter;
        [_notificationCenter addObserver:self selector:@selector(interruptedNotification:) name:AVAudioSessionInterruptionNotification object:nil];
    }
    return self;
}

-(void)addSystemSuspensionListener:(id)systemSuspensionListener {
    self.systemSuspensionListener = systemSuspensionListener;
}

- (void)interruptedNotification:(NSNotification*)notification {
    if (@available(iOS 10.3, *)) {
        bool suspended = notification.userInfo[AVAudioSessionInterruptionWasSuspendedKey];
        if (suspended) {
            [self.systemSuspensionListener systemSuspended];
        }
    }
}

@end
