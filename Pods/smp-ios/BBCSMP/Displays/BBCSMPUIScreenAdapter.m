//
//  BBCSMPUIScreenAdapter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 12/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPPlayerObservable.h"
#import "BBCSMPSubtitleView.h"
#import "BBCSMPUIScreenAdapter.h"
#import "BBCSMPVideoSurfaceContext.h"
#import <UIKit/UIKit.h>

@interface BBCSMPUIScreenAdapter ()

@property (nonatomic, strong, readwrite) UIWindow* window;
@property (nonatomic, weak) CALayer<BBCSMPDecoderLayer>* playerLayer;
@property (nonatomic, strong) UIView* playerLayerViewWrapper;
@property (nonatomic, strong) BBCSMPSubtitleView* subtitleView;
@property (nonatomic, weak) id<BBCSMPPlayerObservable> observable;

@end

#pragma mark -

@implementation BBCSMPUIScreenAdapter

- (instancetype)initWithScreen:(UIScreen*)screen
{
    self = [super init];
    if (self) {
        _window = [[UIWindow alloc] initWithFrame:[screen bounds]];
        [_window setScreen:screen];

        _playerLayerViewWrapper = [[UIView alloc] initWithFrame:CGRectZero];
        _playerLayerViewWrapper.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_window addSubview:_playerLayerViewWrapper];

        _subtitleView = [[BBCSMPSubtitleView alloc] initWithFrame:CGRectZero];
        _subtitleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_window addSubview:_subtitleView];
        
        [self applyDeprecatedOverscanCompensationOntoScreen:screen];
    }

    return self;
}

- (void)applyDeprecatedOverscanCompensationOntoScreen:(UIScreen *)screen
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
    screen.overscanCompensation = UIScreenOverscanCompensationInsetApplicationFrame;
#pragma clang diagnostic pop
}

- (void)attachWithContext:(BBCSMPVideoSurfaceContext*)screenContext
{
    [_playerLayerViewWrapper.layer addSublayer:screenContext.playerLayer];
    screenContext.playerLayer.frame = _window.screen.bounds;
    _subtitleView.frame = _window.screen.bounds;
    _window.hidden = NO;
    _playerLayer = screenContext.playerLayer;

    _observable = screenContext.observable;
    [_observable addObserver:_subtitleView];
}

- (void)detach
{
    [_playerLayer removeFromSuperlayer];
    [_observable removeObserver:_subtitleView];
}

- (BBCSMPVideoSurfacePriority)priority
{
    return 1;
}

- (BOOL)shouldPlayInBackground
{
    return YES;
}

- (BOOL)shouldPauseWhenDetached
{
    return YES;
}

@end
