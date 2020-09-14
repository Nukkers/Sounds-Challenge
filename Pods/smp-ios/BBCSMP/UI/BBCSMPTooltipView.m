//
//  BBCSMPTooltipView.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 22/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPTooltipView.h"
#import "UIColor+SMPPalette.h"

@implementation BBCSMPTooltipView

+ (CGSize)preferredTooltipSize
{
    return CGSizeMake(56.0f, 28.0f);
}

+ (CGSize)preferredTooltipPointerSize
{
    return CGSizeMake(11.0f, 6.0f);
}

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
    self.clipsToBounds = NO;
    self.backgroundColor = [UIColor clearColor];
    self.calloutColor = [UIColor SMPWhiteColor];
    self.textColor = [UIColor SMPBarlesqueBlackColor];
    self.tooltipPointerSize = [[self class] preferredTooltipPointerSize];
    self.horizontalOffsetFromPointer = 0;
}

- (void)setText:(NSString*)text
{
    if (_text == text)
        return;

    _text = text;
    [self setNeedsDisplay];
}

- (void)setTextColor:(UIColor*)textColor
{
    if (_textColor == textColor)
        return;

    _textColor = textColor;
    [self setNeedsDisplay];
}

- (void)setHorizontalOffsetFromPointer:(CGFloat)horizontalOffsetFromPointer
{
    if (_horizontalOffsetFromPointer == horizontalOffsetFromPointer)
        return;

    _horizontalOffsetFromPointer = horizontalOffsetFromPointer;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    CGContextClearRect(UIGraphicsGetCurrentContext(), self.bounds);

    UIBezierPath* calloutPath = [UIBezierPath bezierPath];
    [calloutPath moveToPoint:CGPointMake(0, 0)];
    [calloutPath addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
    [calloutPath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height - _tooltipPointerSize.height)];
    [calloutPath addLineToPoint:CGPointMake(0.5 * (self.bounds.size.width + _tooltipPointerSize.width) + _horizontalOffsetFromPointer, self.bounds.size.height - _tooltipPointerSize.height)];
    [calloutPath addLineToPoint:CGPointMake(0.5 * self.bounds.size.width + _horizontalOffsetFromPointer, self.bounds.size.height)];
    [calloutPath addLineToPoint:CGPointMake(0.5 * (self.bounds.size.width - _tooltipPointerSize.width) + _horizontalOffsetFromPointer, self.bounds.size.height - _tooltipPointerSize.height)];
    [calloutPath addLineToPoint:CGPointMake(0, self.bounds.size.height - _tooltipPointerSize.height)];
    [calloutPath closePath];
    [_calloutColor setFill];
    [calloutPath fill];

    NSMutableParagraphStyle* style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    [_text drawInRect:CGRectMake(0, 3.0f, self.bounds.size.width, self.bounds.size.height - _tooltipPointerSize.height) withAttributes:@{ NSParagraphStyleAttributeName : style, NSFontAttributeName : [UIFont systemFontOfSize:12.0f], NSForegroundColorAttributeName : _textColor }];
}

@end
