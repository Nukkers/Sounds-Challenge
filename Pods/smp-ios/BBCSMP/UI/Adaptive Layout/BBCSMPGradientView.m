//
//  BBCSMPGradientView.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPGradientView.h"

@implementation BBCSMPGradientView

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self setUp];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setUp];
    }
    
    return self;
}

- (void)setUp
{
    _startColor = [UIColor clearColor];
    _endColor = [UIColor blackColor];
    [self updateGradient];
}

- (CAGradientLayer *)gradientLayer
{
    return (CAGradientLayer *)self.layer;
}

- (void)setStartColor:(UIColor *)startColor
{
    _startColor = startColor;
    [self updateGradient];
}

- (void)setEndColor:(UIColor *)endColor
{
    _endColor = endColor;
    [self updateGradient];
}

- (void)updateGradient
{
    CGColorRef startColor = [_startColor CGColor];
    CGColorRef endColor = [_endColor CGColor];
    NSArray *colors = @[(__bridge id)startColor, (__bridge id)endColor];
    self.gradientLayer.colors = colors;
}

@end
