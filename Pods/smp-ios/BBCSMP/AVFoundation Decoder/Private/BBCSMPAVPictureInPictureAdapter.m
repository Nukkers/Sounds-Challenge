//
//  BBCSMPAVPlayerPictureInPictureAdapter.m
//  BBCSMP
//
//  Created by Al Priest on 04/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAVPictureInPictureAdapter.h"
#import "BBCSMPAVPlayerPictureInPictureAdapterDelegate.h"
#import "BBCSMPPictureInPictureController.h"
#import <AVKit/AVKit.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"

@interface BBCSMPAVPictureInPictureAdapter () <AVPictureInPictureControllerDelegate>
@end

#pragma mark -

@implementation BBCSMPAVPictureInPictureAdapter {
    __weak AVPlayerLayer* _playerLayer;
    AVPictureInPictureController* _pictureInPictureController;
}

@synthesize delegate;

- (instancetype)initWithPlayerLayer:(AVPlayerLayer*)playerLayer
{
    if (self = [super init]) {
        _playerLayer = playerLayer;
        _pictureInPictureController = [[AVPictureInPictureController alloc] initWithPlayerLayer:_playerLayer];
        _pictureInPictureController.delegate = self;
    }

    return self;
}

- (BOOL)supportsPictureInPicture
{
    return NSClassFromString(@"AVPictureInPictureController") && [AVPictureInPictureController isPictureInPictureSupported];
}

- (void)stopPictureInPicture
{
    [_pictureInPictureController stopPictureInPicture];
}

- (void)startPictureInPicture
{
    [_pictureInPictureController startPictureInPicture];
}

- (BOOL)isPictureInPictureActive
{
    return _pictureInPictureController.isPictureInPictureActive;
}

- (void)pictureInPictureControllerDidStopPictureInPicture:(AVPictureInPictureController*)pictureInPictureController
{
    [self.delegate pictureInPictureAdapterDidStopPictureInPicture];
}

- (void)pictureInPictureControllerWillStartPictureInPicture:(AVPictureInPictureController*)pictureInPictureController
{
    [self.delegate pictureInPictureAdapterWillStartPictureInPicture];
}

@end

#pragma clang diagnostic pop
