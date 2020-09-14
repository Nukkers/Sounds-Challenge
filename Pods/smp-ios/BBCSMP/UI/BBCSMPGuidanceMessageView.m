//
//  BBCSMPGuidanceMessageView.m
//  BBCSMP
//
//  Created by Gregory Spiers on 18/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPGuidanceMessageView.h"

@interface BBCSMPGuidanceMessageView ()
@property (nonatomic, strong) UILabel* messageLabel;
@end

@implementation BBCSMPGuidanceMessageView

static CGFloat const topPadding = 8.0;
static CGFloat const bottomPadding = 8.0;
static CGFloat const rightPadding = 8.0;
static CGFloat const leftMessagePadding = 30.0;

#pragma mark View lifecycle
- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat messageLabelWidth = self.bounds.size.width - leftMessagePadding - rightPadding;
    CGSize messageLabelSize = [self messageLabelSizeFittingWidth:messageLabelWidth];
    self.messageLabel.frame = CGRectMake(leftMessagePadding, topPadding, messageLabelSize.width, messageLabelSize.height);
}

#pragma mark Public methods
- (CGFloat)viewHeightForWidth:(CGFloat)width;
{
    if (!_messageLabel.text) {
        return 0.0;
    }

    CGFloat messageLabelWidth = width - leftMessagePadding - rightPadding;
    CGSize messageLabelSize = [self messageLabelSizeFittingWidth:messageLabelWidth];

    CGFloat neededHeight = messageLabelSize.height + topPadding + bottomPadding;

    return neededHeight;
}

#pragma mark Property Overrides
- (CGSize)messageLabelSizeFittingWidth:(CGFloat)messageLabelWidth
{
    // NOTE: This method returns fractional sizes (in the size component of the returned CGRect); to use a returned size to size views, you must raise its value to the nearest higher integer using the ceil function.
    CGSize labelSize = [self.messageLabel sizeThatFits:CGSizeMake(messageLabelWidth, CGFLOAT_MAX)];
    return CGSizeMake(ceil(labelSize.width), ceil(labelSize.height));
}

- (void)setGuidanceMessage:(NSString*)guidanceMessage
{
    _guidanceMessage = guidanceMessage;
    self.messageLabel.text = guidanceMessage;
    [self setNeedsLayout];
}

#pragma mark Private methods
- (void)commonInit
{
    self.backgroundColor = [UIColor colorWithRed:175.0 / 255.0 green:55.0 / 255.0 blue:42.0 / 255.0 alpha:1.0];

    // This view is accessible so that the accessiblity frame surrounds the entire view rather than just the label.
    self.isAccessibilityElement = YES;

    UILabel* gSpotLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, topPadding, 15, 15)];
    gSpotLabel.backgroundColor = [UIColor whiteColor];
    gSpotLabel.text = @"G";
    gSpotLabel.textColor = [UIColor blackColor];
    gSpotLabel.textAlignment = NSTextAlignmentCenter;
    gSpotLabel.font = [UIFont boldSystemFontOfSize:12.0];
    gSpotLabel.layer.cornerRadius = gSpotLabel.frame.size.height / 2.0;
    gSpotLabel.clipsToBounds = YES;
    gSpotLabel.isAccessibilityElement = NO;
    [self addSubview:gSpotLabel];

    _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _messageLabel.textColor = [UIColor whiteColor];
    _messageLabel.numberOfLines = 0;
    _messageLabel.font = [UIFont boldSystemFontOfSize:12.0];
    _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    gSpotLabel.isAccessibilityElement = NO;
    [self addSubview:_messageLabel];
}

#pragma mark BBCSMPGuidanceMessageScene

- (void)hide
{
    self.hidden = YES;
}

- (void)show
{
    self.hidden = NO;
}

- (void)presentGuidanceMessage:(NSString*)guidanceMessage
{
    _messageLabel.text = guidanceMessage;
}

- (void)setGuidanceMessageAccessibilityLabel:(NSString *)accessibilityLabel
{
    self.accessibilityLabel = accessibilityLabel;
}

- (void)setGuidanceMessageAccessibilityHint:(NSString *)accessibilityHint
{
    self.accessibilityHint = accessibilityHint;
}

@end
