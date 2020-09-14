//
//  BBCSMPButton.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 19/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPButton.h"
#import "UIColor+SMPPalette.h"

@interface BBCSMPButton ()

@property (nonatomic, strong) BBCSMPBrand* brand;

@end

@implementation BBCSMPButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder*)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.opaque = NO;
    self.clearsContextBeforeDrawing = YES;
    self.backgroundColor = [UIColor clearColor];
    self.hitTestEdgeInsets = UIEdgeInsetsZero;
}

- (void)setBrand:(BBCSMPBrand*)brand
{
    if (_brand == brand)
        return;

    _brand = brand;
    [self setNeedsDisplay];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return size;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    if (UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }

    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);

    return CGRectContainsPoint(hitFrame, point);
}

#pragma mark - State

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

#pragma mark - Drawing code

- (UIColor*)iconBackgroundColor
{
    return self.highlighted ? [_brand highlightColor] : self.backgroundColor;
}

- (UIColor*)colour
{
    if (self.enabled) {
        if (self.highlighted) {
            return _brand.selectedForegroundColor;
        } else {
            return _brand.foregroundColor;
        }
    } else {
        return [UIColor SMPStoneColor];
    }
}

- (UIColor*)selectionColor
{
    return self.highlighted ? [_brand focusedHighlightColor] : [_brand highlightColor];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [[self iconBackgroundColor] setFill];
    [[UIBezierPath bezierPathWithRect:self.bounds] fill];
    [self drawIcon];
    if (self.selected) {
        [self.selectionColor setFill];
        [[UIBezierPath bezierPathWithRect:CGRectMake(2.0f, self.bounds.size.height - 6.0f, self.bounds.size.width - 4.0f, 4.0f)] fill];
    }
}

- (void)drawIcon
{
}

#pragma mark - BBCSMPAccessibilityFocussable implementation

- (BOOL)hasAccessibilityFocus
{
    return [self accessibilityElementIsFocused];
}

@end
