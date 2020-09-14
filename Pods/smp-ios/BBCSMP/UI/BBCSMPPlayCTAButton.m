//
//  BBCSMPPlayCTAButton.m
//  BBCSMP
//
//  Created by Richard Price01 on 23/03/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPPlayCTAButton.h"
#import "BBCSMPDuration.h"
#import "BBCSMPTimeFormatter.h"
#import "BBCSMPBrand.h"
#import "BBCSMPBrandingIcons.h"
#import "BBCSMPIcon.h"

@interface BBCSMPPlayCTAButton ()

@property (strong, nonatomic) BBCSMPTimeFormatter* durationFormatter;
@property (readonly) BOOL durationVisible;

@end

#pragma mark -

@implementation BBCSMPPlayCTAButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        _iconSize = [self iconSizeForCurrentBounds];
        [super addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)tapped:(__unused id)sender
{
    [_delegate callToActionSceneDidReceiveTap:self];
}

- (void)setFrame:(CGRect)frame
{
    CGRect oldFrame = self.frame;
    [super setFrame:frame];
    if (frame.size.width != oldFrame.size.width || frame.size.height != oldFrame.size.height) {
        self.iconSize = [self iconSizeForCurrentBounds];
    }
}

- (CGFloat)iconSizeForCurrentBounds
{
    CGFloat smallestDimension = MIN(self.bounds.size.width, self.bounds.size.height);
    if (smallestDimension >= 48.0f) {
        return 28.0f;
    } else {
        return 18.0f;
    }
}

- (void)setIconSize:(CGFloat)iconSize
{
    if (_iconSize == iconSize)
        return;
    
    _iconSize = iconSize;
    [self setNeedsDisplay];
}

#pragma mark - State

- (void)showDurationWithDuration:(BBCSMPDuration*)duration
{
    if (_duration == duration)
        return;

    _duration = duration;
    if (_duration && !_durationFormatter) {
        self.durationFormatter = [[BBCSMPTimeFormatter alloc] init];
        _durationFormatter.showLeadingZero = NO;
    }
    [self setNeedsDisplay];
}

- (void)setAvType:(BBCSMPAVType)avType
{
    if (_avType == avType)
        return;

    _avType = avType;
    [self setNeedsDisplay];
}

- (UIAccessibilityTraits)accessibilityTraits
{
    return [super accessibilityTraits] | UIAccessibilityTraitStartsMediaSession;
}

- (BOOL)durationVisible
{
    return (self.duration != nil);
}

#pragma mark - Drawing code

- (id<BBCSMPIcon>)iconDrawer
{
    switch (_avType) {
        case BBCSMPAVTypeAudio: {
            return self.brand.icons.audioPlayIcon;
        }
    case BBCSMPAVTypeVideo:
        default: {
            return self.brand.icons.videoPlayIcon;
        }
    }
}

- (void)drawIcon
{
    [super drawIcon];
    id<BBCSMPIcon> iconDrawer = [self iconDrawer];
    [iconDrawer setColour:[self colour]];
    [iconDrawer drawInFrame:[self iconFrame]];

    if (self.durationVisible) {
        [self drawDuration];
    }
}

-(void)drawDuration {
    NSString *durationString = [self.durationFormatter stringFromDuration:self.duration];
    NSDictionary *durationTextAttributes = @{
                                             NSForegroundColorAttributeName: [UIColor whiteColor],
                                             NSFontAttributeName: [UIFont systemFontOfSize:12.f]
                                             };
    CGSize size = [durationString sizeWithAttributes:durationTextAttributes];
    
    CGRect targetRect = CGRectOffset(self.iconFrame, 0, self.iconFrame.size.height + 4.0f);
    targetRect.origin.x = (self.frame.size.width - size.width) / 2.0f;
    targetRect.size.width = self.bounds.size.width;
    [durationString drawInRect:targetRect withAttributes:durationTextAttributes];
}

- (CGRect)iconFrame
{
    CGFloat buttonSize = self.bounds.size.width;
    
    CGFloat iconWidth = self.iconSize;
    CGFloat iconHeight = (self.iconSize);
    
    CGFloat targetX = (buttonSize - iconWidth) * .5f;
    CGFloat targetY = (buttonSize - iconHeight) * .5f - (self.durationVisible? 8.f : 0.f);
    
    
    return CGRectMake(targetX, targetY, iconWidth, iconHeight);
}

#pragma mark BBCSMPPlayCTAButtonScene

@synthesize delegate = _delegate;

- (void)appear
{
    self.hidden = NO;
}

- (void)disappear
{
    self.hidden = YES;
}

- (void)hideDuration
{
    
}

- (void)showDuration
{
    
}

- (void)setFormattedDurationString:(NSString *)formattedDuration
{
    
}

- (void)setPlayCallToActionAccessibilityLabel:(NSString *)accessibilityLabel
{
    self.accessibilityLabel = accessibilityLabel;
}

- (void)setPlayCallToActionAccessibilityHint:(NSString *)accessibilityHint
{
    self.accessibilityHint = accessibilityHint;
}

@end
