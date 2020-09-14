//
//  BBCSMPScrubberView.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 15/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPScrubberView.h"
#import "BBCSMPScrubberView.h"
#import "BBCSMPTimeFormatter.h"
#import "BBCSMPTooltipView.h"
#import "UIColor+SMPPalette.h"

@interface BBCSMPScrubberView ()

@property (nonatomic, strong) NSNumber* commandedAbsoluteTime;

@property (nonatomic, assign, readonly) BOOL trackAlwaysFollowsThumbWhenScrubbing;

@property (nonatomic, assign, readonly) BOOL isSeekable;
@property (nonatomic, assign, readonly) double minimumValue;
@property (nonatomic, assign, readonly) double maximumValue;
@property (nonatomic, assign, readonly) double trackValue;
@property (nonatomic, assign, readonly) double thumbValue;
@property (nonatomic, assign) BOOL notifying;

@property (nonatomic, strong) BBCSMPBrand* brand;
@property (nonatomic, strong) UIView* trackBackgroundView;
@property (nonatomic, strong) UIView* trackView;
@property (nonatomic, strong) UIImageView* thumbView;
@property (nonatomic, strong) BBCSMPTooltipView* tooltip;
@property (nonatomic, strong) BBCSMPTimeFormatter* timeFormatter;

@end

// We have changed the floats to doubles in this class as it turns out you can't represent some epoch times with floats. This was causing the slider to jump minutes at a time.

@implementation BBCSMPScrubberView

const double BBCSMPScrubberViewNonLinearThreshold = 22.0;
const double BBCSMPScrubberViewAccessibilityStepSize = 30.0;
const NSUInteger BBCSMPScrubberViewNumberOfSteps = 4;
const CGFloat BBCSMPScrubberViewTrackHorizontalInset = 16.0f;
const CGFloat BBCSMPScrubberViewTrackVerticalInset = 20.0f;
const CGFloat BBCSMPScrubberViewThumbWidth = 9.0f;
const CGFloat BBCSMPScrubberViewThumbHeight = 16.0f;

+ (UIImage*)createThumbImage
{
    CGSize thumbImageSize = CGSizeMake(BBCSMPScrubberViewThumbWidth, BBCSMPScrubberViewThumbHeight);
    CGSize thumbSize = CGSizeMake(BBCSMPScrubberViewThumbWidth, BBCSMPScrubberViewThumbHeight);
    UIGraphicsBeginImageContext(thumbImageSize);

    UIBezierPath* thumbPath = [UIBezierPath bezierPathWithRect:CGRectIntegral(CGRectMake(0.5f * (thumbImageSize.width - thumbSize.width), 0.5f * (thumbImageSize.height - thumbSize.height), thumbSize.width, thumbSize.height))];
    [[UIColor SMPWhiteColor] setFill];
    [thumbPath fill];

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 0.5f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextMoveToPoint(ctx, 4.75f, 4.0f);
    CGContextAddLineToPoint(ctx, 4.75f, 12.0f);
    CGContextStrokePath(ctx);

    UIImage* thumbImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbImage;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor clearColor];

        self.timeFormatter = [[BBCSMPTimeFormatter alloc] init];

        self.trackBackgroundView = [[UIView alloc] initWithFrame:[self trackBackgroundRect]];
        _trackBackgroundView.userInteractionEnabled = NO;
        _trackBackgroundView.backgroundColor = [UIColor SMPStormColor];
        [self addSubview:_trackBackgroundView];

        self.trackView = [[UIView alloc] initWithFrame:CGRectMake(BBCSMPScrubberViewTrackHorizontalInset, BBCSMPScrubberViewTrackVerticalInset, 0, self.bounds.size.height - 2 * BBCSMPScrubberViewTrackVerticalInset)];
        _trackView.userInteractionEnabled = NO;
        _trackView.backgroundColor = [UIColor clearColor];
        [self addSubview:_trackView];

        self.thumbView = [[UIImageView alloc] initWithFrame:CGRectMake(BBCSMPScrubberViewTrackHorizontalInset - 0.5 * BBCSMPScrubberViewThumbWidth, 0.5 * (self.bounds.size.height - BBCSMPScrubberViewThumbHeight), BBCSMPScrubberViewThumbWidth, BBCSMPScrubberViewThumbHeight)];
        _thumbView.userInteractionEnabled = NO;
        _thumbView.image = [[self class] createThumbImage];
        [self addSubview:_thumbView];

        self.tooltip = [[BBCSMPTooltipView alloc] initWithFrame:CGRectMake(0, 0 - [BBCSMPTooltipView preferredTooltipSize].height + [BBCSMPTooltipView preferredTooltipPointerSize].height, [BBCSMPTooltipView preferredTooltipSize].width, [BBCSMPTooltipView preferredTooltipSize].height)];
        _tooltip.hidden = YES;
        _tooltip.userInteractionEnabled = NO;
        [self addSubview:_tooltip];
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    _trackView.backgroundColor = self.enabled ? [_brand highlightColor] : [_brand focusedHighlightColor];
}

- (void)setFrame:(CGRect)frame
{
    CGRect oldFrame = self.frame;
    [super setFrame:frame];
    if (self.frame.size.width != oldFrame.size.width) {
        [self updateTrackFrame];
        [self updateThumbPosition];
    }
}

#pragma mark - Public property setters

- (void)setTime:(BBCSMPTime*)time
{
    if (_time == time || _notifying)
        return;
    
    _time = time;
    if (_time && !self.tracking) {
        _commandedAbsoluteTime = nil;
    }
    [self updateTrackFrame];
    [self updateThumbPosition];
}

- (void)setDuration:(BBCSMPDuration*)duration
{
    if (_duration == duration)
        return;

    _duration = duration;
    [self updateTrackFrame];
    [self updateThumbPosition];
}

- (void)setSeekableRange:(BBCSMPTimeRange*)seekableRange
{
    if (_seekableRange == seekableRange)
        return;

    _seekableRange = seekableRange;
    [self updateTrackFrame];
    [self updateThumbPosition];
}

#pragma mark - Private property setters

- (void)setCommandedAbsoluteTime:(NSNumber*)commandedAbsoluteTime
{
    if (_commandedAbsoluteTime == commandedAbsoluteTime)
        return;
    
    if (commandedAbsoluteTime.doubleValue < self.minimumValue) {
        _commandedAbsoluteTime = [NSNumber numberWithDouble:self.minimumValue];
    }
    else if (commandedAbsoluteTime.doubleValue > self.maximumValue) {
        _commandedAbsoluteTime = [NSNumber numberWithDouble:self.maximumValue];
    }
    else {
        _commandedAbsoluteTime = commandedAbsoluteTime;
    }
    
    [self updateTooltipText];
    [self updateThumbPosition];
    if (self.trackAlwaysFollowsThumbWhenScrubbing) {
        [self updateTrackFrame];
    }
}

#pragma mark - BBCSMPBrandable implementation

- (void)setBrand:(BBCSMPBrand*)brand
{
    if (_brand == brand)
        return;

    _brand = brand;
    _trackView.backgroundColor = self.enabled ? [_brand highlightColor] : [_brand focusedHighlightColor];
}

#pragma mark - Thumb and track positioning

- (CGRect)trackBackgroundRect
{
    return CGRectInset(self.bounds, BBCSMPScrubberViewTrackHorizontalInset, BBCSMPScrubberViewTrackVerticalInset);
}

- (double)valueForOffset:(CGFloat)xPositionInView
{
    return [self calcWithPositionInView:xPositionInView minValue:self.minimumValue maxValue:self.maximumValue trackBackgroundRect:[self trackBackgroundRect]];
}

- (double)calcWithPositionInView:(CGFloat)positionInView minValue:(double)minValue maxValue:(double)maxValue trackBackgroundRect:(CGRect)trackBackgroundRect
{
    double scrubbableTimeLength = maxValue - minValue;
    
    double maxSeekablePosition = trackBackgroundRect.size.width;
    
    double positionOffsetInTrackView = positionInView - trackBackgroundRect.origin.x;
    
    double actualSeekablePositionNotLessThanZero = fmax(0, positionOffsetInTrackView);
    
    double actualSeekablePositionNotGreaterThanEnd = fmin(maxSeekablePosition, actualSeekablePositionNotLessThanZero);
    
    double fractionOffsetInTrack = actualSeekablePositionNotGreaterThanEnd / maxSeekablePosition;
    
    double secondsFromStartOfStream = scrubbableTimeLength * fractionOffsetInTrack;
    
    return minValue + secondsFromStartOfStream;
}

- (double)offsetFromTrackStartForValue:(double)value
{
    CGRect trackBackgroundRect = [self trackBackgroundRect];
    double trackWidth = trackBackgroundRect.size.width;
    return fmin(trackBackgroundRect.size.width, fmax(0, ((value - self.minimumValue) / (self.maximumValue - self.minimumValue)) * trackWidth));
}

- (void)updateTrackFrame
{
    CGRect trackRect = [self trackBackgroundRect];
    _trackBackgroundView.frame = trackRect;
    trackRect.size.width = [self offsetFromTrackStartForValue:self.trackAlwaysFollowsThumbWhenScrubbing ? self.thumbValue : self.trackValue];
    _trackView.frame = trackRect;
}

- (void)updateTooltipText
{
    NSString* tooltipText = @"";
    if (_commandedAbsoluteTime) {
        switch (_time.type) {
        case BBCSMPTimeAbsolute: {
            tooltipText = [_timeFormatter stringFromTime:[BBCSMPTime absoluteTimeWithIntervalSince1970:_commandedAbsoluteTime.doubleValue]];
            break;
        }
        case BBCSMPTimeRelative: {
            tooltipText = [_timeFormatter stringFromTimeInterval:_commandedAbsoluteTime.doubleValue];
            break;
        }
        }
    }
    [_tooltip setText:tooltipText];
}

- (void)updateThumbPosition
{
    CGRect trackBackgroundRect = [self trackBackgroundRect];
    _thumbView.center = CGPointMake(trackBackgroundRect.origin.x + [self offsetFromTrackStartForValue:self.thumbValue], 0.5 * self.bounds.size.height);
    CGFloat offsetFromLeftEdge = _thumbView.center.x;
    CGFloat offsetFromRightEdge = _thumbView.center.x - self.bounds.size.width;
    BOOL closestToLeftEdge = fabs(offsetFromLeftEdge) < fabs(offsetFromRightEdge);
    CGFloat offsetFromClosestEdge = closestToLeftEdge ? offsetFromLeftEdge : offsetFromRightEdge;
    CGFloat minimumTooltipDistanceFromEdge = (_tooltip.frame.size.width * 0.5 + 2.0f) * (closestToLeftEdge ? 1.0f : -1.0f);
    CGFloat pointerOffset = 0;
    if (fabs(offsetFromClosestEdge) < fabs(minimumTooltipDistanceFromEdge)) {
        pointerOffset = offsetFromClosestEdge - minimumTooltipDistanceFromEdge;
    }
    _tooltip.center = CGPointMake(_thumbView.center.x - pointerOffset, _tooltip.center.y);
    _tooltip.horizontalOffsetFromPointer = pointerOffset;
}

- (BOOL)trackAlwaysFollowsThumbWhenScrubbing
{
    return YES;
}

- (BOOL)isSeekable
{
    return _seekableRange.durationMeetsMinimumLiveRewindRequirement;
}

- (double)trackValue
{
    switch (_time.type) {
    case BBCSMPTimeAbsolute: {
        return self.isSeekable ? _time.seconds : 0;
    }
    case BBCSMPTimeRelative: {
        return _time.seconds;
    }
    }
}

- (double)thumbValue
{
    double thumbValue = _commandedAbsoluteTime ? _commandedAbsoluteTime.doubleValue : self.trackValue;
    return thumbValue;
}

- (double)minimumValue
{
    switch (_time.type) {
    case BBCSMPTimeAbsolute: {
        return self.isSeekable ? _seekableRange.start : 0;
    }
    case BBCSMPTimeRelative: {
        return 0;
    }
    }
}

- (double)maximumValue
{
    switch (_time.type) {
    case BBCSMPTimeAbsolute: {
        return self.isSeekable ? _seekableRange.end : 0;
    }
    case BBCSMPTimeRelative: {
        return _duration ? _duration.seconds : 0;
    }
    }
}

#pragma mark - Touch tracking

- (BOOL)beginTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    BOOL result = [super beginTrackingWithTouch:touch withEvent:event];
    _tooltip.hidden = NO;
    self.commandedAbsoluteTime = [NSNumber numberWithDouble:[self valueForOffset:[touch locationInView:self].x]];

    [_delegate startedScrubbing];
    [_scrubberDelegate scrubberSceneDidBeginScrubbing:self];

    return result;
}

- (BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event;
{
    if (self.tracking) {
        // Get the difference between current and previous touch location
        CGFloat xDelta = [touch locationInView:self].x - [touch previousLocationInView:self].x;
        CGRect trackRect = [self trackBackgroundRect];
        double yDistance = fabs([touch locationInView:self].y);
        double variableScrubbingSliderStepSize = ((9.0 * (double)self.bounds.size.width / 16.0) - BBCSMPScrubberViewNonLinearThreshold) / ((double)BBCSMPScrubberViewNumberOfSteps);
        double multiplier = 1.0 / pow(2, ceil((yDistance - variableScrubbingSliderStepSize) / variableScrubbingSliderStepSize));
        double linearValue = [self valueForOffset:[touch locationInView:self].x];
        double nonLinearValue = self.thumbValue + (self.maximumValue - self.minimumValue) * multiplier * (xDelta / (double)trackRect.size.width);
        if (yDistance < BBCSMPScrubberViewNonLinearThreshold) {
            // If we're near the track then just make the thumb follow the user's finger
            self.commandedAbsoluteTime = [NSNumber numberWithDouble:linearValue];
        }
        else if (yDistance < variableScrubbingSliderStepSize) {
            // If we're in the zone between the track and far from the track then interpolate between the two values so the thumb catches up with the user's finger the closer to the track they get
            self.commandedAbsoluteTime = [NSNumber numberWithDouble:nonLinearValue + (linearValue - nonLinearValue) * (1.0 - (yDistance - BBCSMPScrubberViewNonLinearThreshold) / (variableScrubbingSliderStepSize - BBCSMPScrubberViewNonLinearThreshold))];
        }
        else {
            // If we're far from the track then use the value with the multiplier applied so the user can use variable scrubbing
            self.commandedAbsoluteTime = [NSNumber numberWithDouble:nonLinearValue];
        }
    }
    return YES;
}

- (void)endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    [self emitScrubbedTime];
    [_scrubberDelegate scrubberSceneDidFinishScrubbing:self];
}

- (void)cancelTrackingWithEvent:(UIEvent*)event
{
    _tooltip.hidden = YES;
    [_delegate endedScrubbing];
    [_scrubberDelegate scrubberSceneDidFinishScrubbing:self];
}

#pragma mark - Accessibility support

- (BOOL)isAccessibilityElement
{
    return YES;
}

- (UIAccessibilityTraits)accessibilityTraits
{
    return [super accessibilityTraits] | UIAccessibilityTraitAdjustable;
}

- (void)accessibilityIncrement
{
    [_scrubberDelegate scrubberSceneDidReceiveAccessibilityIncrement:self];
}

- (void)accessibilityDecrement
{
    [_scrubberDelegate scrubberSceneDidReceiveAccessibilityDecrement:self];
}

#pragma mark Private

- (void)emitScrubbedTime
{
    _notifying = YES;
    _tooltip.hidden = YES;
    [_delegate scrubberScrubbedTo:_commandedAbsoluteTime.doubleValue];
    
    // TODO: The below line is untested, as writing a decent test for this class is a pain.
    // This control should emit the value that's being scrubbed to, with the extra logic moved into a presenter.
    [_scrubberDelegate scrubberScene:self didScrubToPosition:_commandedAbsoluteTime];
    
    [_delegate endedScrubbing];
    _notifying = NO;
}

#pragma mark BBCSMPScrubberScene

@synthesize scrubberDelegate = _scrubberDelegate;

- (void)showScrubber
{
    
}

- (void)hideScrubber
{
    
}

- (void)setScrubberAccessibilityLabel:(NSString *)accessibilityLabel
{
    self.accessibilityLabel = accessibilityLabel;
}

- (void)setScrubberAccessibilityHint:(NSString *)accessibilityHint
{
    self.accessibilityHint = accessibilityHint;
}

- (void)setScrubberAccessibilityValue:(NSString *)accessibilityValue
{
    self.accessibilityValue = accessibilityValue;
}

@end
