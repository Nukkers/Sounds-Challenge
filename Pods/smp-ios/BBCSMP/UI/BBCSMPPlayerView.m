//
//  BBCSMPPlayerView.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 13/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPAVStatisticsConsumer.h"
#import "BBCSMPActivityView.h"
#import "BBCSMPArtworkView.h"
#import "BBCSMPBufferingIndicatorView.h"
#import "BBCSMPCloseButton.h"
#import "BBCSMPDecoderLayerView.h"
#import "BBCSMPDefaultErrorMessageView.h"
#import "BBCSMPGuidanceMessageView.h"
#import "BBCSMPOverlayViews.h"
#import "BBCSMPPlaybackControlView.h"
#import "BBCSMPPlayerBuilder.h"
#import "BBCSMPPlayerPresenterFactory.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPPlayerSizeObserver.h"
#import "BBCSMPPlayerView.h"
#import "BBCSMPSubtitleView.h"
#import "BBCSMPTitleBar.h"
#import "BBCSMPTouchPassThroughView.h"
#import "BBCSMPUIDefaultConfiguration.h"
#import "BBCSMPTransportControlsScene.h"
#import "BBCSMPMeasurementPolicies.h"
#import "BBCSMPSafeAreaGuideProviding.h"
#import "BBCSMPGradientView.h"

NSString * BBCSMPUIViewHiddenKeyPath = @"hidden";
void * BBCSMPPlayerViewPlaybackControlsVisibilityChangedContext = &BBCSMPPlayerViewPlaybackControlsVisibilityChangedContext;
void * BBCSMPPlayerViewTitleBarVisibilityChangedContext = &BBCSMPPlayerViewTitleBarVisibilityChangedContext;

@interface BBCSMPPlayerView () <BBCSMPPlaybackControlViewDelegate,
                                BBCSMPVideoRectChangedDelegate,
                                BBCSMPOverlayViewsDelegate>

@property (nonatomic, strong) id<BBCSMPUIConfiguration> configuration;
@property (nonatomic, strong) BBCSMPTitleBar* titleBar;
@property (nonatomic, strong) BBCSMPTitleSubtitleContainer* titleSubtitleContainer;
@property (nonatomic, strong) BBCSMPDecoderLayerView* playerLayerView;
@property (nonatomic, strong) BBCSMPArtworkView* artworkView;
@property (nonatomic, strong) BBCSMPSubtitleView* subtitleView;
@property (nonatomic, strong) BBCSMPPlaybackControlView* playbackControlView;
@property (nonatomic, strong) BBCSMPGuidanceMessageView* guidanceMessageView;
@property (nonatomic, strong) BBCSMPBufferingIndicatorView* bufferingIndicatorView;
@property (nonatomic, assign) BOOL scrubberHidden;
@property (nonatomic, strong) BBCSMPSize* playerSize;
@property (nonatomic, strong) BBCSMPState* state;
@property (nonatomic, strong) id<BBCSMPPlayerPresenterFactory> presenterFactory;
@property (nonatomic, strong) BBCSMPDefaultErrorMessageView* errorView;
@property (nonatomic, strong) BBCSMPActivityView* activityView;
@property (nonatomic, strong) BBCSMPOverlayViews* overlayViews;
@property (nonatomic, strong) BBCSMPTouchPassThroughView* belowAllOverlayParentView;
@property (nonatomic, strong) BBCSMPTouchPassThroughView* avoidingControlsOverlayParentView;
@property (nonatomic, strong) BBCSMPTouchPassThroughView* aboveAllOverlayParentView;
@property (nonatomic, strong) UIView *playbackControlViewBackground;
@property (nonatomic, strong) BBCSMPGradientView *titleBarBackground;

@end

@implementation BBCSMPPlayerView {
    BBCSMPMeasurementPolicies *_measurementPolicies;
    id<BBCSMPSafeAreaGuideProviding> _safeAreaGuideProviding;
}

const CGFloat BBCSMPPlayerViewTitleBarHeight = 64.0f;
const CGFloat BBCSMPPlayerViewPlaybackControlHeight = 96.0f;

- (void)dealloc
{
    [_titleBar removeObserver:self forKeyPath:BBCSMPUIViewHiddenKeyPath context:&BBCSMPPlayerViewTitleBarVisibilityChangedContext];
    [_playbackControlView removeObserver:self forKeyPath:BBCSMPUIViewHiddenKeyPath context:&BBCSMPPlayerViewPlaybackControlsVisibilityChangedContext];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                       player:(id<BBCSMP>)player
                configuration:(id<BBCSMPUIConfiguration>)configuration
          measurementPolicies:(BBCSMPMeasurementPolicies *)measurementPolicies
safeAreaGuideProvidingFactory:(id<BBCSMPSafeAreaGuideProvidingFactory>)safeAreaGuideProvidingFactory
{
    if ((self = [super initWithFrame:frame])) {
        self.configuration = configuration;
        _measurementPolicies = measurementPolicies;
        _safeAreaGuideProviding = [safeAreaGuideProvidingFactory createSafeAreaGuideProvidingWithView:self];
        [self initialiseUserInterface];
        [self attachPlayer:player];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.configuration = [[BBCSMPUIDefaultConfiguration alloc] init];
    [self initialiseUserInterface];
}

- (void)initialiseUserInterface
{
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor blackColor];

    self.playerLayerView = [[BBCSMPDecoderLayerView alloc] initWithFrame:self.bounds delegate:self];
    _playerLayerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_playerLayerView];

    self.artworkView = [[BBCSMPArtworkView alloc] initWithFrame:self.bounds];
    _artworkView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_artworkView];

    self.subtitleView = [[BBCSMPSubtitleView alloc] initWithFrame:self.bounds];
    [_subtitleView setConfiguration:_configuration];
    _subtitleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_subtitleView];

    _belowAllOverlayParentView = [[BBCSMPTouchPassThroughView alloc] initWithFrame:self.bounds];
    [self addSubview:_belowAllOverlayParentView];

    _avoidingControlsOverlayParentView = [[BBCSMPTouchPassThroughView alloc] initWithFrame:CGRectZero];
    [self addSubview:_avoidingControlsOverlayParentView];

    self.titleSubtitleContainer = [[BBCSMPTitleSubtitleContainer alloc] initWithFrame:CGRectZero];
    
    _titleBarBackground = [[BBCSMPGradientView alloc] initWithFrame:CGRectZero];
    UIColor *startColor = _titleBarBackground.startColor;
    UIColor *endColor = _titleBarBackground.endColor;
    _titleBarBackground.endColor = startColor;
    _titleBarBackground.startColor = endColor;
    [self addSubview:_titleBarBackground];

    self.titleBar = [[BBCSMPTitleBar alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, BBCSMPPlayerViewTitleBarHeight) titleSubtitlesContainer:self.titleSubtitleContainer closeButtonMeasurementPolicy:_measurementPolicies.closeButtonIconMeasurementPolicy];
    _titleBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _titleBar.hidden = ![_configuration titleBarEnabled];
    [self addSubview:_titleBar];
    
    [_titleBar addObserver:self
                forKeyPath:BBCSMPUIViewHiddenKeyPath
                   options:NSKeyValueObservingOptionNew
                   context:&BBCSMPPlayerViewTitleBarVisibilityChangedContext];
    
    _playbackControlViewBackground = [[BBCSMPGradientView alloc] initWithFrame:CGRectZero];
    [self addSubview:_playbackControlViewBackground];

    self.playbackControlView = [[BBCSMPPlaybackControlView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - BBCSMPPlayerViewPlaybackControlHeight, self.bounds.size.width, BBCSMPPlayerViewPlaybackControlHeight) configuration:_configuration measurementPolicies:_measurementPolicies];
    _playbackControlView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _playbackControlView.delegate = self;
    [self addSubview:_playbackControlView];
    
    [_playbackControlView addObserver:self
                           forKeyPath:BBCSMPUIViewHiddenKeyPath
                              options:NSKeyValueObservingOptionNew
                              context:&BBCSMPPlayerViewPlaybackControlsVisibilityChangedContext];

    self.guidanceMessageView = [[BBCSMPGuidanceMessageView alloc] initWithFrame:CGRectZero];
    _guidanceMessageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_guidanceMessageView];

    self.bufferingIndicatorView = [[BBCSMPBufferingIndicatorView alloc] initWithFrame:self.bounds];
    _bufferingIndicatorView.hidden = YES;
    _bufferingIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:_bufferingIndicatorView];

    _aboveAllOverlayParentView = [[BBCSMPTouchPassThroughView alloc] initWithFrame:CGRectZero];
    [self addSubview:_aboveAllOverlayParentView];

    _overlayViews = [[BBCSMPOverlayViews alloc] initWithBelowAllParentView:_belowAllOverlayParentView avoidingControlsParentView:_avoidingControlsOverlayParentView aboveAllParentView:_aboveAllOverlayParentView];
    _overlayViews.delegate = self;

    _errorView = [[BBCSMPDefaultErrorMessageView alloc] initWithFrame:self.bounds];
    _errorView.hidden = YES;
    [self addSubview:_errorView];
    [self bringSubviewToFront:_errorView];

    _activityView = [[BBCSMPActivityView alloc] initWithFrame:self.bounds];
    _activityView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _activityView.backgroundColor = [UIColor clearColor];
    [self insertSubview:_activityView aboveSubview:_subtitleView];

    self.brand = [BBCSMPBrand new];

    [self updateSubtitleFrame];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == BBCSMPPlayerViewPlaybackControlsVisibilityChangedContext) {
        _playbackControlViewBackground.hidden = _playbackControlView.isHidden;
    }
    
    if (context == BBCSMPPlayerViewTitleBarVisibilityChangedContext) {
        _titleBarBackground.hidden = _titleBar.isHidden;
    }
}

- (void)setBrand:(BBCSMPBrand*)brand
{
    if (_brand == brand)
        return;

    _brand = brand;
    [_titleBar setBrand:brand];
    [_playbackControlView setBrand:brand];
    [_bufferingIndicatorView setBrand:brand];
    [_errorView setBrand:brand];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect safeAreaFrame = _safeAreaGuideProviding.safeAreaGuideFrame;
    [self layoutTitleBarWithinSafeArea:safeAreaFrame];
    [self layoutPlaybackControlsWithinSafeArea:safeAreaFrame];

    [_belowAllOverlayParentView setFrame:self.bounds];
    [_avoidingControlsOverlayParentView setFrame:self.bounds];
    [_aboveAllOverlayParentView setFrame:self.bounds];

    for (BBCSMPOverlayPosition position = BBCSMPOverlayPositionAboveAll; position < BBCSMPOverlayPositionMax; position++) {
        CGRect frame = [self overlayViewFrameForPosition:position];
        [_overlayViews setFrame:frame forOverlaysWithPosition:position];
    }

    [self updateSubtitleFrame];
}

- (CGRect)maxPlaybackControlsFrameUsingSafeArea:(CGRect)safeArea
{
    CGFloat maxWidth = (CGRectGetHeight(self.frame) / 9) * 16;
    CGFloat maxFrameLeft = (CGRectGetWidth(self.frame) - maxWidth) / 2;
    CGFloat maxFrameWidth = maxWidth;
    
    CGFloat safeAreaLeft = CGRectGetMinX(safeArea);
    CGFloat safeAreaWidth = CGRectGetWidth(safeArea);
    
    if (safeAreaLeft > maxFrameLeft)
    {
        maxFrameLeft = safeAreaLeft;
        maxFrameWidth = safeAreaWidth;
    }

    return CGRectMake(maxFrameLeft, CGRectGetMinY(safeArea), maxFrameWidth, CGRectGetHeight(safeArea));
}

- (void)layoutTitleBarWithinSafeArea:(CGRect)safeArea
{
    UIEdgeInsets titleBarInsets = _safeAreaGuideProviding.titleBarContentInsets;
    _titleBar.contentInsets = titleBarInsets;
    
    CGRect titleBarFrame = [self maxPlaybackControlsFrameUsingSafeArea:safeArea];
    titleBarFrame.size.height = BBCSMPPlayerViewTitleBarHeight;
    
    _titleBar.frame = titleBarFrame;
    
    CGSize titleBarBackgroundSize = { .width = CGRectGetWidth(self.bounds),
                                      .height = CGRectGetMaxY(titleBarFrame) - titleBarInsets.bottom };
    CGRect titleBarBackgroundFrame = { .origin = CGPointZero, .size = titleBarBackgroundSize };
    _titleBarBackground.frame = titleBarBackgroundFrame;
}

- (void)layoutPlaybackControlsWithinSafeArea:(CGRect)safeArea
{
    CGFloat playbackControlViewVerticalPosition = CGRectGetMaxY(safeArea) - BBCSMPPlayerViewPlaybackControlHeight;
    
    if (!_guidanceMessageView.hidden) {
        CGFloat guidanceMessageViewHeight = [self.guidanceMessageView viewHeightForWidth:CGRectGetWidth(self.bounds)];
        self.guidanceMessageView.frame = CGRectMake(0, 
                                                    CGRectGetHeight(self.bounds) - guidanceMessageViewHeight,
                                                    CGRectGetWidth(self.bounds),
                                                    guidanceMessageViewHeight);
        playbackControlViewVerticalPosition -= guidanceMessageViewHeight;
    }
    
    CGRect playbackControlViewFrame = [self maxPlaybackControlsFrameUsingSafeArea:safeArea];
    playbackControlViewFrame.origin.y = playbackControlViewVerticalPosition;
    playbackControlViewFrame.size.height = BBCSMPPlayerViewPlaybackControlHeight;
    
    _playbackControlView.frame = playbackControlViewFrame;
    
    CGRect playbackControlViewBackgroundFrame = playbackControlViewFrame;
    playbackControlViewBackgroundFrame.origin.x = 0.0;
    playbackControlViewBackgroundFrame.size.width = CGRectGetWidth(self.bounds);
    playbackControlViewBackgroundFrame.size.height = CGRectGetHeight(self.bounds) - CGRectGetMinY(playbackControlViewFrame);
    _playbackControlViewBackground.frame = playbackControlViewBackgroundFrame;
}

- (CGRect)overlayViewFrameForPosition:(BBCSMPOverlayPosition)position
{
    switch (position) {
        case BBCSMPOverlayPositionAboveAll:
        case BBCSMPOverlayPositionBelowAll:
            return self.bounds;
        case BBCSMPOverlayPositionAvoidingControls:
            return CGRectMake(0, [_configuration titleBarEnabled] ? BBCSMPPlayerViewTitleBarHeight : 0, self.bounds.size.width, self.bounds.size.height - ([_configuration titleBarEnabled] ? BBCSMPPlayerViewTitleBarHeight : 0) - (_scrubberHidden ? BBCSMPPlayerViewPlaybackControlHeight * 0.5 : BBCSMPPlayerViewPlaybackControlHeight));
        default:
            return CGRectZero;
    }
}

- (void)attachPlayer:(id<BBCSMP>)player
{
    [player loadPlayerItemMetadata];
    _playbackControlView.player = player;
    [player addObserver:_subtitleView]; // TODO Test this line.
}

- (void)videoRectUpdated:(CGRect)videoRect
{
    _videoRect = videoRect;
    [self updateSubtitleFrame];
}

#pragma mark - Accessibility support

- (BOOL)isAccessibilityElement
{
    return self.playbackControlView.alpha == 0;
}

- (NSString*)accessibilityLabel
{
    return @"Player";
}

- (NSString*)accessibilityHint
{
    return @"Double tap to display play controls";
}

#pragma mark - Playback-control-view delegate

- (void)scrubberVisibilityUpdated:(BOOL)scrubberHidden
{
    self.scrubberHidden = scrubberHidden;
    [self setNeedsLayout];
}

#pragma mark - Player-controller delegate

- (void)updateSubtitleFrame
{
    CGRect frame = _videoRect;
    BOOL videoRectIsSmallerThanScreenMinusTransportControlsHeight = ([_playerLayerView frame].size.height - _videoRect.size.height) < BBCSMPPlayerViewPlaybackControlHeight;
    if (!_playbackControlView.hidden && videoRectIsSmallerThanScreenMinusTransportControlsHeight) {
        frame.origin.y += BBCSMPPlayerViewTitleBarHeight;
        frame.size.height -= BBCSMPPlayerViewTitleBarHeight;
        frame.size.height -= BBCSMPPlayerViewPlaybackControlHeight;
    }
    [_subtitleView setFrame:frame];
}

#pragma mark BBCSMPView

@synthesize context;
@synthesize videoRect = _videoRect;

- (void)setVideoRect:(CGRect)videoRect
{
    _videoRect = videoRect;
    [self setNeedsLayout];
}

- (id<BBCSMPPlayerScenes>)scenes
{
    return self;
}

- (void)addOverlayView:(UIView*)overlayView inPosition:(BBCSMPOverlayPosition)position
{
    [_overlayViews addOverlayView:overlayView inPosition:position];
}

- (void)removeOverlayView:(UIView*)overlayView
{
    [_overlayViews removeOverlayView:overlayView];
}

- (void)addButton:(UIView*)button inPosition:(BBCSMPButtonPosition)position
{
    switch (position) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        case BBCSMPButtonPositionTitleBarLeft:
#pragma clang diagnostic pop
        case BBCSMPButtonPositionTransportControls: {
            [_playbackControlView addButton:button];
            break;
        }
        case BBCSMPButtonPositionTitleBarRight: {
            [_titleBar addButton:button inPosition:position];
            break;
        }
        default: {
            NSAssert(NO, @"Invalid button position");
            break;
        }
    }
}

- (void)removeButton:(UIView*)button
{
    [_playbackControlView removeButton:button];
    [_titleBar removeButton:button];
}

#pragma mark BBCSMPScenes

- (id<BBCSMPActivityScene>)activityScene
{
    return _activityView;
}

- (id<BBCSMPPlaybackControlsScene>)playbackControlsScene
{
    return _playbackControlView;
}

- (id<BBCSMPTransportControlsScene>)transportControlsScene
{
    return self.playbackControlView.transportControlsScene;
}

- (id<BBCSMPScrubberScene>)scrubberScene
{
    return _playbackControlView.scrubberScene;
}

- (id<BBCSMPTitleBarScene>)titleBarScene
{
    return _titleBar;
}

- (id<BBCSMPTitleSubtitleScene>)titleSubtitleScene
{
    return _titleSubtitleContainer;
}

- (id<BBCSMPLiveIndicatorScene>)liveIndicatorScene
{
    return self.playbackControlView.liveIndicatorScene;
}

- (id<BBCSMPVolumeScene>)volumeScene
{
    return self.playbackControlView.volumeScene;
}

- (id<BBCSMPFullscreenScene>)fullscreenButtonScene
{
    return self.playbackControlView.fullscreenButtonScene;
}

- (id<BBCSMPCloseButtonScene>)closeButtonScene
{
    return _titleBar.closeButton;
}

- (id<BBCSMPErrorMessageScene>)errorMessageScene
{
    return _errorView;
}

- (id<BBCSMPGuidanceMessageScene>)guidanceMessageScene
{
    return _guidanceMessageView;
}

- (id<BBCSMPOverlayScene>)overlayScene
{
    return _overlayViews;
}

- (id<BBCSMPPlayCTAButtonScene>)playCTAButtonScene
{
    return self.playbackControlView.playCTAButtonScene;
}

- (id<BBCSMPBufferingIndicatorScene>)bufferingIndicatorScene
{
    return _bufferingIndicatorView;
}

- (id<BBCSMPPictureInPictureButtonScene>)pictureInPictureButtonScene
{
    return _playbackControlView.pictureInPictureButtonScene;
}

- (id<BBCSMPSubtitlesButtonScene>)subtitlesButtonScene
{
    return _playbackControlView.subtitlesButtonScene;
}

- (id<BBCSMPTimeLabelScene>)timeLabelScene
{
    return _playbackControlView.timeLabelScene;
}

- (id<BBCSMPSubtitleScene>)subtitlesScene
{
    return _subtitleView;
}

- (id<BBCSMPVideoSurfaceScene>)videoSurfaceScene
{
    return _playerLayerView;
}

- (id<BBCSMPContentPlaceholderScene>)contentPlaceholderScene
{
    return _artworkView;
}

- (id<BBCSMPAirplayButtonScene>)airplayButtonScene
{
    return _playbackControlView.airplayButtonScene;
}

- (id<BBCSMPPlayButtonScene>)playButtonScene
{
    return _playbackControlView.transportControlView;
}

- (id<BBCSMPPauseButtonScene>)pauseButtonScene
{
    return _playbackControlView.transportControlView;
}

- (id<BBCSMPStopButtonScene>)stopButtonScene
{
    return _playbackControlView.transportControlView;
}

- (id<BBCSMPDisableSubtitlesButtonScene>)disableSubtitlesScene
{
    return _playbackControlView.subtitlesButtonScene;
}

- (id<BBCSMPEnableSubtitlesButtonScene>)enableSubtitlesScene
{
    return _playbackControlView.subtitlesButtonScene;
}

#pragma mark BBCSMPOverlayViewsDelegate

- (void)overlayViewsDidChange
{
    [self setNeedsLayout];
}

@end
