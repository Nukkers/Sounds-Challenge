//
//  BBCSMPRemoteCommandCenterAdapter.m
//  BBCSMP
//
//  Created by Ryan Johnstone on 07/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPRemoteCommandCenterAdapter.h"
#import <MediaPlayer/MPRemoteCommand.h>
#import <MediaPlayer/MPRemoteCommandCenter.h>

@implementation BBCSMPRemoteCommandCenterAdapter {
    MPRemoteCommandCenter *_remoteCommandCenter;
}

- (instancetype)init
{
    self = [super init];
    if(self) {
        _remoteCommandCenter = [MPRemoteCommandCenter sharedCommandCenter];
    }
    
    return self;
}

- (void)addPlayTarget:(id<NSObject>)target action:(SEL)action
{
    [[_remoteCommandCenter playCommand] addTarget:target action:action];
}

- (void)removePlayTarget:(id<NSObject>)target
{
    [[_remoteCommandCenter playCommand] removeTarget:target];
}

- (void)addPauseTarget:(id<NSObject>)target action:(SEL)action
{
    [[_remoteCommandCenter pauseCommand] addTarget:target action:action];
}

- (void)removePauseTarget:(id<NSObject>)target
{
    [[_remoteCommandCenter pauseCommand] removeTarget:target];
}

- (void)addTogglePlayPauseTarget:(id<NSObject>)target action:(SEL)action
{
    [[_remoteCommandCenter togglePlayPauseCommand] addTarget:target action:action];
}

- (void)removeTogglePlayPauseTarget:(id<NSObject>)target
{
    [[_remoteCommandCenter togglePlayPauseCommand] removeTarget:target];
}

@end
