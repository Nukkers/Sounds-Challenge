//
//  BBCSMPTransportControlView.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 15/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPButton.h"
#import "BBCSMPButtonBar.h"
#import "BBCSMPFullscreenScene.h"
#import "BBCSMPTimeLabel.h"
#import "BBCSMPTransportControlView.h"
#import "BBCSMPVolumeView.h"
#import "BBCSMPIcon.h"
#import "BBCSMPIconButton.h"
#import "BBCSMPMeasurementPolicies.h"

@interface BBCSMPTransportControlView () <BBCSMPButtonBarDelegate>

@property (nonatomic, strong) BBCSMPButtonBar* leftButtonBar;
@property (nonatomic, strong) BBCSMPButtonBar* rightButtonBar;
@property (nonatomic, strong) BBCSMPAirplayButton* airplayButton;
@property (nonatomic, strong) BBCSMPSubtitleButton* subtitleButton;
@property (nonatomic, strong) BBCSMPFullscreenButton* fullscreenButton;
@property (nonatomic, strong) BBCSMPPictureInPictureButton* pictureInPictureButton;
@property (nonatomic, strong) BBCSMPTimeLabel* timeLabel;
@property (nonatomic, strong) BBCSMPVolumeView* volumeSliderView;

@end

@implementation BBCSMPTransportControlView

- (instancetype)initWithFrame:(CGRect)frame
          measurementPolicies:(BBCSMPMeasurementPolicies *)measurementPolicies
{
    if ((self = [super initWithFrame:frame])) {
        _timeLabel = [[BBCSMPTimeLabel alloc] initWithFrame:CGRectZero];
        [self addSubview:_timeLabel];

        _liveIndicator = [[BBCSMPLiveIndicator alloc] initWithFrame:CGRectZero];
        _liveIndicator.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        _liveIndicator.hidden = YES;
        _liveIndicator.userInteractionEnabled = NO;
        [self addSubview:_liveIndicator];

        self.airplayButton = [BBCSMPAirplayButton airplayButton];

        self.subtitleButton = [BBCSMPSubtitleButton subtitleButton];
        [_subtitleButton addTarget:self
                            action:@selector(subtitleButtonTapped:)
                  forControlEvents:UIControlEventTouchUpInside];

        self.fullscreenButton = [[BBCSMPFullscreenButton alloc] initWithFrame:CGRectZero];
        _fullscreenButton.measurementPolicy = measurementPolicies.fullscreenIconMeasurementPolicy;
        [_fullscreenButton addTarget:self action:@selector(fullscreenButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

        _pictureInPictureButton = [[BBCSMPPictureInPictureButton alloc] initWithFrame:CGRectZero];
        [_pictureInPictureButton addTarget:self action:@selector(pictureInPictureButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

        self.rightButtonBar = [[BBCSMPButtonBar alloc] initWithFrame:CGRectZero];
        _rightButtonBar.delegate = self;
        [self addSubview:_rightButtonBar];
        [_rightButtonBar addButton:_airplayButton];
        [_rightButtonBar addButton:_subtitleButton];
        [_rightButtonBar addButton:_pictureInPictureButton];
        [_rightButtonBar addButton:_fullscreenButton];

        self.leftButtonBar = [[BBCSMPButtonBar alloc] initWithFrame:CGRectZero];
        _leftButtonBar.delegate = self;
        [self addSubview:_leftButtonBar];

        self.volumeSliderView = [[BBCSMPVolumeView alloc] initWithDelegate:self];
        [self addSubview:_volumeSliderView];
        
        _playButton = [[BBCSMPIconButton alloc] initWithFrame:CGRectZero];
        _playButton.hidden = YES;
        _playButton.measurementPolicy = measurementPolicies.playIconMeasurementPolicy;
        [_playButton addTarget:self action:@selector(playButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [_leftButtonBar addButton:_playButton];
        
        _pauseButton = [[BBCSMPIconButton alloc] initWithFrame:CGRectZero];
        _pauseButton.hidden = YES;
        _pauseButton.measurementPolicy = measurementPolicies.pauseIconMeasurementPolicy;
        [_pauseButton addTarget:self action:@selector(pauseButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [_leftButtonBar addButton:_pauseButton];
        
        _stopButton = [[BBCSMPIconButton alloc] initWithFrame:CGRectZero];
        _stopButton.hidden = YES;
        _stopButton.measurementPolicy = measurementPolicies.stopIconMeasurementPolicy;
        [_stopButton addTarget:self action:@selector(stopButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [_leftButtonBar addButton:_stopButton];
    }
    return self;
}

- (void)playButtonTapped
{
    [_playButtonDelegate playButtonSceneDidReceiveTap:self];
}

- (void)pauseButtonTapped
{
    [_pauseButtonDelegate pauseButtonSceneDidReceiveTap:self];
}

- (void)stopButtonTapped
{
    [_stopButtonDelegate stopButtonDidReceiveTap:self];
}

- (void)setBrand:(BBCSMPBrand*)brand
{
    [_leftButtonBar setBrand:brand];
    [_rightButtonBar setBrand:brand];
    [_volumeSliderView setBrand:brand];
}

- (void)addButton:(UIView*)button
{
    [_rightButtonBar addButton:button];
}

- (void)removeButton:(UIView*)button
{
    [_rightButtonBar removeButton:button];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [self propogateCurrentHeightToSubview:_leftButtonBar];
    [self propogateCurrentHeightToSubview:_rightButtonBar];
    
    CGFloat edgeBuffer = 8.0f;
    CGFloat buttonWidth = CGRectGetHeight(self.bounds);
    _leftButtonBar.buttonWidth = buttonWidth;
    _rightButtonBar.buttonWidth = buttonWidth;

    _leftButtonBar.frame = CGRectMake(0, 0, _leftButtonBar.requiredWidth, self.bounds.size.height);

    _rightButtonBar.frame = CGRectMake(self.bounds.size.width - _rightButtonBar.requiredWidth, 0, _rightButtonBar.requiredWidth, self.bounds.size.height);

    _volumeSliderView.frame = CGRectMake(_leftButtonBar.frame.size.width + _leftButtonBar.frame.origin.x + edgeBuffer, (self.bounds.size.height - _volumeSliderView.bounds.size.height) / 2.0f, self.bounds.size.width / 6.0f, _volumeSliderView.bounds.size.height);

    CGSize timeLabelSize = [_timeLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(self.frame))];
    timeLabelSize.width += edgeBuffer;
    CGPoint timeLabelOrigin = CGPointMake(CGRectGetMinX(_rightButtonBar.frame) - edgeBuffer - timeLabelSize.width, (CGRectGetHeight(self.frame) / 2.0) - (timeLabelSize.height / 2.0));
    CGRect timeLabelFrame = {.origin = timeLabelOrigin, .size = timeLabelSize };
    _timeLabel.frame = timeLabelFrame;

    CGSize liveIndicatorSize = [_liveIndicator intrinsicContentSize];
    CGPoint liveIndicatorOrigin = CGPointMake(CGRectGetMinX(_timeLabel.frame) - liveIndicatorSize.width, (CGRectGetHeight(self.frame) / 2.0) - (liveIndicatorSize.height / 2.0));
    CGRect liveIndicatorFrame = {.origin = liveIndicatorOrigin, .size = liveIndicatorSize };
    _liveIndicator.frame = liveIndicatorFrame;
    if(CGRectGetMaxX(_volumeSliderView.frame) >= liveIndicatorFrame.origin.x) {
        [_spaceDelegate spaceRestricted];
    } else {
        [_spaceDelegate spaceAvailable];
    }
    
}

- (void)propogateCurrentHeightToSubview:(UIView *)subview
{
    CGRect frame = [subview frame];
    frame.size.height = CGRectGetHeight([self bounds]);
    [subview setFrame:frame];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    [_transportControlsDelegate userInteractionStarted];
    [_interactivityDelegate transportControlsSceneInteractionsDidBegin:self];
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    [_transportControlsDelegate userInteractionEnded];
    [_interactivityDelegate transportControlsSceneInteractionsDidFinish:self];
}

- (void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event
{
    [_transportControlsDelegate userInteractionEnded];
    [_interactivityDelegate transportControlsSceneInteractionsDidFinish:self];
}

#pragma mark - Button delegate methods

- (void)subtitleButtonTapped:(id)sender
{
    [_transportControlsDelegate subtitleButtonTapped];
    
    if(_subtitleButton.isSelected) {
        [_disableSubtitlesDelegate disableSubtitlesButtonSceneDidReceiveTap:self];
    }
    else {
        [_enableSubtitlesDelegate enableSubtitlesButtonSceneDidReceiveTap:self];
    }
}

- (void)fullscreenButtonTapped:(id)sender
{
    [_transportControlsDelegate fullscreenButtonTapped];
    [_fullscreenDelegate fullscreenSceneDidTapToggleFullscreenButton:self];
}

- (void)pictureInPictureButtonTapped:(id)sender
{
    [_transportControlsDelegate pictureInPictureButtonTapped];
    [_pictureInPictureSceneDelegate pictureInPictureSceneDidTapToggle:self];
}

#pragma mark - Button-bar delegate

- (void)buttonTouchStarted
{
    [_transportControlsDelegate userInteractionStarted];
    [_interactivityDelegate transportControlsSceneInteractionsDidBegin:self];
}

- (void)buttonTouchEnded
{
    [_transportControlsDelegate userInteractionEnded];
    [_interactivityDelegate transportControlsSceneInteractionsDidFinish:self];
}

#pragma mark BBCSMPTransportControlsScene

@synthesize interactivityDelegate = _interactivityDelegate;
@synthesize playButtonDelegate = _playButtonDelegate;
@synthesize pauseButtonDelegate = _pauseButtonDelegate;
@synthesize stopButtonDelegate = _stopButtonDelegate;
@synthesize spaceDelegate = _spaceDelegate;

- (void)show
{
    self.hidden = NO;
}

- (void)hide
{
    self.hidden = YES;
}

- (void)showPlayButton
{
    _playButton.hidden = NO;
    
    [self setNeedsLayout];
}

- (void)showStopButton
{
    _stopButton.hidden = NO;
    
    [self setNeedsLayout];
}

- (void)showPauseButton
{
    _pauseButton.hidden = NO;
    
    [self setNeedsLayout];
}

- (void)hidePlayButton
{
    _playButton.hidden = YES;
    
    [_leftButtonBar setNeedsLayout];
    [self setNeedsLayout];
}

- (void)hidePauseButton
{
    _pauseButton.hidden = YES;
    [_leftButtonBar setNeedsLayout];
    [self setNeedsLayout];
}

- (void)hideStopButton
{
    _stopButton.hidden = YES;
}

- (void)setPlayButtonAccessibilityLabel:(NSString *)accessibilityLabel
{
    _playButton.accessibilityLabel = accessibilityLabel;
}

- (void)setPlayButtonHighlightColor:(UIColor *)highlightColor
{
    _playButton.highlightedStateColor = highlightColor;
}

- (void)setPlaybuttonAccessibilityHint:(NSString *)accessibilityHint
{
    _playButton.accessibilityHint = accessibilityHint;
}

- (void)setPauseButtonAccessibilityLabel:(NSString *)accessibilityLabel
{
    _pauseButton.accessibilityLabel = accessibilityLabel;
}

- (void)setPauseButtonAccessibilityHint:(NSString *)accessibilityHint
{
    _pauseButton.accessibilityHint = accessibilityHint;
}

- (void)setStopButtonAccessibilityLabel:(NSString *)accessibilityLabel
{
    _stopButton.accessibilityLabel = accessibilityLabel;
}

- (void)setStopButtonAccessibilityHint:(NSString *)accessibilityHint
{
    _stopButton.accessibilityHint = accessibilityHint;
}

- (void)setPlayButtonIcon:(id<BBCSMPIcon>)icon
{
    _playButton.icon = icon;
}

- (void)setPauseButtonIcon:(id<BBCSMPIcon>)icon
{
    _pauseButton.icon = icon;
}

- (void)setStopButtonIcon:(id<BBCSMPIcon>)icon
{
    _stopButton.icon = icon;
}

#pragma mark BBCSMPSubtitlesButtonScene

@synthesize subtitlesButtonDelegate = _subtitlesButtonDelegate;
@synthesize enableSubtitlesDelegate = _enableSubtitlesDelegate;
@synthesize disableSubtitlesDelegate = _disableSubtitlesDelegate;

- (void)showEnableSubtitlesButton
{
    _subtitleButton.hidden = NO;
    [self setNeedsLayout];
}

- (void)hideEnableSubtitlesButton
{
    _subtitleButton.hidden = YES;
    [self setNeedsLayout];
}

- (void)showDisableSubtitlesButton
{
    _subtitleButton.selected = YES;
    _subtitleButton.hidden = NO;
    [self setNeedsLayout];
}

- (void)hideDisableSubtitlesButton
{
    _subtitleButton.selected = NO;
    _subtitleButton.hidden = YES;
    [self setNeedsLayout];
}

#pragma mark BBCSMPAirplayButtonScene

- (void)showAirplayButton
{
    _airplayButton.hidden = NO;
    [self setNeedsLayout];
}

- (void)hideAirplayButton
{
    _airplayButton.hidden = YES;
    [self setNeedsLayout];
}

#pragma mark BBCSMPPictureInPictureButtonScene

@synthesize pictureInPictureSceneDelegate = _pictureInPictureSceneDelegate;

- (void)showPictureInPictureButton
{
    _pictureInPictureButton.hidden = NO;
    [self setNeedsLayout];
}

- (void)hidePictureInPictureButton
{
    _pictureInPictureButton.hidden = YES;
    [self setNeedsLayout];
}

- (void)setPictureInPictureButtonAccessibilityLabel:(NSString *)accessibilityLabel
{
    _pictureInPictureButton.accessibilityLabel = accessibilityLabel;
}

- (void)setPictureInPictureButtonAccessibilityHint:(NSString *)accessibilityHint
{
    _pictureInPictureButton.accessibilityHint = accessibilityHint;
}

- (void)renderIcon:(id<BBCSMPIcon>)icon
{
    [_pictureInPictureButton renderIcon:icon];
}

#pragma mark BBCSMPFullscreenScene

@synthesize fullscreenDelegate = _fullscreenDelegate;

- (void)showFullScreenButton
{
    self.fullscreenButton.hidden = NO;
    [self setNeedsLayout];
}

- (void)hideFullScreenButton
{
    self.fullscreenButton.hidden = YES;
    [self setNeedsLayout];
}

- (void)renderFullscreenButtonIcon:(id<BBCSMPIcon>)icon
{
    [_fullscreenButton setIcon:icon];
}

- (void)setFullscreenButtonAccessibilityLabel:(NSString *)accessibilityLabel
{
    self.fullscreenButton.accessibilityLabel = accessibilityLabel;
}

- (void)setFullscreenButtonAccessibilityHint:(NSString *)accessibilityHint
{
    self.fullscreenButton.accessibilityHint = accessibilityHint;
}

@end
