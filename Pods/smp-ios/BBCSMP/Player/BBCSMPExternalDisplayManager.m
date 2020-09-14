//
//  BBCSMPExternalDisplayManager.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 19/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPExternalDisplayManager.h"
#import "BBCSMPSubtitleObserver.h"
#import "BBCSMPSubtitleView.h"
#import <UIKit/UIKit.h>

@interface BBCSMPExternalDisplayManager ()

@property (nonatomic, assign) BOOL externalDisplayConnected;
@property (nonatomic, strong) UIWindow* externalDisplayWindow;
@property (nonatomic, strong) BBCSMPSubtitleView* externalDisplaySubtitleView;

@end

@implementation BBCSMPExternalDisplayManager

- (instancetype)init
{
    if ((self = [super init])) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenDidChange:) name:UIScreenDidConnectNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenDidChange:) name:UIScreenDidDisconnectNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)screenDidChange:(NSNotification*)aNotification
{
    [self setupMovieView];
}

- (BOOL)checkfor1080p:(UIScreen*)aScreen
{
    BOOL available = NO;
    for (UIScreenMode* mode in aScreen.availableModes) {
        available = (mode.size.height == 1080);
        if (available)
            break;
    }
    return available;
}

- (BOOL)checkfor720p:(UIScreen*)aScreen
{
    BOOL available = NO;
    for (UIScreenMode* mode in aScreen.availableModes) {
        available = (mode.size.height == 720);
        if (available)
            break;
    }
    return available;
}

- (BOOL)checkforVGA:(UIScreen*)aScreen
{
    BOOL available640x480 = NO;
    BOOL available1024x768 = NO;

    for (UIScreenMode* mode in aScreen.availableModes) {
        if (mode.size.width == 640 && mode.size.height == 480)
            available640x480 = YES;

        if (available640x480 && mode.size.width == 1024 && mode.size.height == 768)
            available1024x768 = YES;
    }

    return (available640x480 && available1024x768);
}

- (BOOL)canSetOverscanCompenstation:(UIScreen*)aScreen
{
    return [aScreen respondsToSelector:@selector(setOverscanCompensation:)];
}

- (void)restoreKeyWindow
{
    if (self.externalDisplayWindow != nil) {
        // TODO: Figure out how to unregister subtitle observer from player's subtitle manager
        [self.externalDisplaySubtitleView removeFromSuperview];
        self.externalDisplaySubtitleView = nil;

        self.externalDisplayConnected = NO;
        [self.externalDisplayWindow resignKeyWindow];
        self.externalDisplayWindow.screen = [UIScreen mainScreen];
        self.externalDisplayWindow = nil;

        // TODO: Figure out how to do this on app delegate via player delegate
        // [((AppDelegate_Shared*)[[UIApplication sharedApplication] delegate]).window makeKeyWindow];
    }
}

- (CGRect)setScreenMode:(UIScreen*)aScreen
{
    UIScreenMode* selectedScreenMode = [aScreen.availableModes objectAtIndex:0];

    BOOL FullHDMode = [self checkfor1080p:aScreen];
    BOOL HDMode = [self checkfor720p:aScreen];
    BOOL VGAMode = [self checkforVGA:aScreen];

    NSInteger maxHeight = 480;

    // iPad 2 - Full HD Mode available but can only output as 720
    if (FullHDMode) {
        maxHeight = 720;

        if ([self canSetOverscanCompenstation:aScreen]) {
            [aScreen setOverscanCompensation:UIScreenOverscanCompensationNone];
        }
    }

    // iPad 1 - HD Mode Only
    else if (HDMode) {
        maxHeight = 720; // Use 640 x 480 to prevent borders on an iPad 2 and Picture outside border on an iPad 1

        if ([self canSetOverscanCompenstation:aScreen]) {
            [aScreen setOverscanCompensation:UIScreenOverscanCompensationNone];
        }
    }

    // VGA Mode
    else if (VGAMode) {
        maxHeight = 768;
    }

    for (UIScreenMode* mode in aScreen.availableModes) {
        if (mode.size.height <= maxHeight) {
            if (mode.size.width > selectedScreenMode.size.width && mode.size.height > selectedScreenMode.size.height) {
                selectedScreenMode = mode;
            }
        }
    }

    [aScreen setCurrentMode:selectedScreenMode];

    CGRect tvb = [aScreen bounds];

    CGFloat width = tvb.size.width;
    CGFloat height = tvb.size.height;
    CGFloat x, y;

    x = y = 0;

    return CGRectMake(x, y, width, height);
}

- (void)setupMovieView
{
    NSArray* screens = [UIScreen screens];

    CALayer* playViewLayer = nil;
    CGRect playerBounds = CGRectZero;

    if ([screens count] > 1) {
        self.externalDisplayConnected = YES;

        UIScreen* screen = [screens lastObject];
        CGRect windowFrame = [self setScreenMode:screen];

        self.externalDisplayWindow = [[UIWindow alloc] initWithFrame:windowFrame];
        self.externalDisplayWindow.backgroundColor = [UIColor blackColor];
        self.externalDisplayWindow.screen = screen;
        [self.externalDisplayWindow makeKeyAndVisible];

        playViewLayer = self.externalDisplayWindow.layer;
        playerBounds = self.externalDisplayWindow.frame;

        //        self.programmeImageView.hidden = NO;
    } else {
        self.externalDisplayConnected = NO;

        [self restoreKeyWindow];
        //        playViewLayer = self.moviePlayerView.layer;
        //        playerBounds = self.moviePlayerView.bounds;

        //        self.programmeImageView.hidden = YES;
    }

    //    [playViewLayer addSublayer:self.playLayer];

    //    self.playLayer.frame = playerBounds;
    //    self.playLayer.videoGravity = AVLayerVideoGravityResizeAspect;

    if (self.externalDisplayConnected) {
        self.externalDisplaySubtitleView = [[BBCSMPSubtitleView alloc] initWithFrame:CGRectMake(0, playerBounds.size.height - 150, playerBounds.size.width, 150)];
        self.externalDisplaySubtitleView.backgroundColor = [UIColor clearColor];
        //        self.externalDisplaySubtitleView.hidden = !self.isDisplayingSubtitles;
        [self.externalDisplayWindow addSubview:self.externalDisplaySubtitleView];
        //        self.activeSubtitleView = self.tvoutSubtitleView;
    }

    //    [self configureExpandIconWithScreenBounds:playerBounds];
}

- (CGRect)playerBounds
{
    CGRect playerBounds = CGRectZero;

    if (self.externalDisplayConnected) {
        playerBounds = self.externalDisplayWindow.frame;
    } else {
        //        playerBounds = self.moviePlayerView.bounds;
    }
    return playerBounds;
}

@end
