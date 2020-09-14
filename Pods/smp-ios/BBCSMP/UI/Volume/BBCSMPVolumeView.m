//
//  BBCSMPVolumeView.m
//  BBCSMP
//
//  Created by Timothy James Condon on 04/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPBrand.h"
#import "BBCSMPVolumeView.h"
#import <QuartzCore/QuartzCore.h>

@interface BBCSMPVolumeView ()

@property (nonatomic, weak) id<BBCSMPTransportControlsScene> delegate;

@end

@implementation BBCSMPVolumeView

- (instancetype)initWithDelegate: (id<BBCSMPTransportControlsScene>)delegate
{
    self = [super init];
    if (self) {
        [self setVolumeThumbImage:[self makeCircleImageWithRadius:10.0f] forState:UIControlStateNormal];
        [self sizeToFit];
        self.showsRouteButton = NO;
        self.delegate = delegate;
        
        [self addUnTestedGestureRecogniserToStopTransportControlsFromFadingOut];
        
    }
    return self;
}

- (void)addUnTestedGestureRecogniserToStopTransportControlsFromFadingOut
{
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(volumeAdjusted:)];
    recognizer.allowableMovement = CGFLOAT_MAX;
    recognizer.minimumPressDuration = 0;
    recognizer.cancelsTouchesInView = NO;
    [self addGestureRecognizer:recognizer];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)volumeAdjusted:(UIGestureRecognizer *)recognizer
{
    NSLog(@"Received event");
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [[self.delegate interactivityDelegate] transportControlsSceneInteractionsDidBegin:self.delegate];
        return;
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        [[self.delegate interactivityDelegate] transportControlsSceneInteractionsDidFinish:self.delegate];
        return;
    }
}

- (UIImage*)makeCircleImageWithRadius:(CGFloat)radius
{
    CGFloat diameter = radius * 2;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(diameter, diameter), NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetRGBFillColor(context, 1.0f, 1.0f, 1.0f, 1.0f);
    CGContextFillEllipseInRect(context, CGRectMake(0, 0, diameter, diameter));

    UIImage* circleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return circleImage;
}

- (void)setBrand:(BBCSMPBrand*)brand
{
    self.tintColor = [brand highlightColor];
}

- (CGRect)volumeSliderRectForBounds:(CGRect)bounds
{
    return bounds;
}

#pragma mark BBCSMPVolumeScene

- (void)showVolumeSlider
{
    self.hidden = NO;
}

- (void)hideVolumeSlider
{
    self.hidden = YES;
}


// This is being used for the new adaptive UI
- (void)updateVolume:(float)volume{ }

@end
