//
//  BBCSMPAirplayButton.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 15/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPAirplayButton.h"
#import "UIColor+SMPPalette.h"
#import <MediaPlayer/MPVolumeView.h>

@interface BBCSMPAirplayButton ()

@property (nonatomic, strong) MPVolumeView* volumeView;
@property (nonatomic, strong, readonly) UIButton* airplayButton;

@end

@implementation BBCSMPAirplayButton

static const NSString* AirplayButtonHighlightContext = @"AirplayButtonHighlightContext";

+ (instancetype)airplayButton
{
    return [[[self class] alloc] initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        self.volumeView = [[MPVolumeView alloc] initWithFrame:CGRectZero];
        _volumeView.showsVolumeSlider = NO;
        [self addSubview:_volumeView];
        [self.airplayButton setShowsTouchWhenHighlighted:NO];
        [self.airplayButton setTintColor:[UIColor whiteColor]];
        [self.airplayButton addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:&AirplayButtonHighlightContext];
    }
    return self;
}

- (BOOL)isAccessibilityElement
{
    return YES;
}

- (NSString*)accessibilityIdentifier
{
    return @"smp_airplay_button";
}

- (NSString*)accessibilityLabel
{
    return @"Airplay";
}

- (NSString*)accessibilityHint
{
    return @"Select Airplay device";
}

- (void)dealloc
{
    [self.airplayButton removeObserver:self forKeyPath:@"highlighted"];
}

- (void)setBrand:(BBCSMPBrand*)brand
{
    [super setBrand:brand];
    [_volumeView setTintColor:[brand highlightColor]];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(self.enabled ? size.width : 0, size.height);
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    if (context == &AirplayButtonHighlightContext) {
        [self setHighlighted:self.airplayButton.highlighted];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_volumeView sizeToFit];
    _volumeView.frame = CGRectMake(0.5 * (self.bounds.size.width - _volumeView.frame.size.width), 0.5 * (self.bounds.size.height - _volumeView.frame.size.height), _volumeView.frame.size.width, _volumeView.frame.size.height);
}

#if TARGET_OS_SIMULATOR
- (void)drawIcon
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    NSMutableParagraphStyle* style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    UIFont* font = [UIFont boldSystemFontOfSize:14.0f];
    
    [@"AIR PLAY" drawInRect:self.frame withAttributes:@{ NSParagraphStyleAttributeName : style,
                                                        NSFontAttributeName : font,
                                                        NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    CGContextRestoreGState(context);
}
#endif

- (UIButton*)airplayButton
{
    for (UIView* view in _volumeView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* airplayButton = (UIButton*)view;
            return airplayButton;
        }
    }
    return nil;
}

@end
