//
//  BBCSMPTimeLabel.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 09/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPTimeLabel.h"
#import "UIColor+SMPPalette.h"

@implementation BBCSMPTimeLabel

#pragma mark Initialization

- (instancetype)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }

    return self;
}

- (void)setUp
{
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
    self.hidden = YES;
    self.textAlignment = NSTextAlignmentRight;
    self.font = [UIFont systemFontOfSize:13.0f];
    self.isAccessibilityElement = NO;
}

#pragma mark BBCSMPTimeLabelScene

- (void)setRelativeTimeStringWithPlayheadPosition:(NSString *)playheadPosition duration:(NSString *)duration
{
    NSString *text = [NSString stringWithFormat:@"%@ / %@", playheadPosition, duration];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
    NSUInteger positionUpperBoundIndex = playheadPosition.length;
    [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, positionUpperBoundIndex)];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor SMPStoneColor] range:NSMakeRange(positionUpperBoundIndex, text.length - positionUpperBoundIndex)];
    
    self.attributedText = attributedText;
}

- (void)setAbsoluteTimeString:(NSString *)absoluteTimeString
{
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:absoluteTimeString attributes:attributes];
    
    self.attributedText = attributedText;
}

- (void)showTime
{
    self.hidden = NO;
}

- (void)hideTime
{
    self.hidden = YES;
}

@end
