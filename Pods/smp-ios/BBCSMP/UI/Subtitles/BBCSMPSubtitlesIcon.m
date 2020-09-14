//
//  BBCSMPSubtitlesIcon.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 11/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPSubtitlesIcon.h"
#import "BBCSMPBrand.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPSubtitlesIcon

#pragma mark BBCSMPIcon

@synthesize colour = _iconColour;

- (void)drawInFrame:(CGRect)frame
{
    [_iconColour setFill];
    UIBezierPath* path = [UIBezierPath bezierPathWithRect:frame];
    [path fill];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    CGContextSetBlendMode(context, kCGBlendModeDestinationOut);
    NSMutableParagraphStyle* style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    UIFont* font = [UIFont boldSystemFontOfSize:14.0f];
    [@"S" drawInRect:CGRectInset(frame, 6.0f, 3.0f)
        withAttributes:@{ NSParagraphStyleAttributeName : style, NSFontAttributeName : font }];

    CGContextRestoreGState(context);
}

@end
