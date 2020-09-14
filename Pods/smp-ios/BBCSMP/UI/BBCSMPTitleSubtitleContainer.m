//
//  BBCSMPTitleSubtitleContainer.m
//  BBCSMP
//
//  Created by Timothy James Condon on 14/11/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPTitleSubtitleContainer.h"

@interface BBCSMPTitleSubtitleContainer ()

@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UILabel* subtitleLabel;


@end

@implementation BBCSMPTitleSubtitleContainer

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _titleLabel.isAccessibilityElement = NO;
        [self addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subtitleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
        _subtitleLabel.textColor = [UIColor whiteColor];
        _subtitleLabel.isAccessibilityElement = NO;
        [self addSubview:_subtitleLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, (self.frame.size.height / 2.0f));
    _subtitleLabel.frame = CGRectMake(0, (0 + _titleLabel.frame.size.height), self.frame.size.width, (self.frame.size.height / 2.0f));
}

-(CGFloat)widthForLabel:(UILabel*)label{
    return [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}].width;
}

-(void)show
{
    [self setHidden:NO];
}

-(void)hide
{
    [self setHidden:YES];
}

-(void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

-(void)setSubtitle:(NSString *)subtitle
{
    _subtitleLabel.text = subtitle;
}

#pragma mark BBCSMPTitleBarScene

- (void)setTitleSubtitleAccessibilityLabel:(NSString *)accessibilityLabel
{
    self.accessibilityLabel = accessibilityLabel;
}

- (void)setTitleSubtitleAccessibilityHint:(NSString *)accessibilityHint
{
    self.accessibilityHint = accessibilityHint;
}

- (void)resignAccessibilityInteraction
{
    self.isAccessibilityElement = NO;
}

- (void)becomeAccessible
{
    self.isAccessibilityElement = YES;
}

- (void)setLabelAlignment:(NSTextAlignment)textAlignment
{
    _titleLabel.textAlignment = textAlignment;
    _subtitleLabel.textAlignment = textAlignment;
}

-(CGFloat)largestTitleWidth
{
    return MAX([self widthForLabel:_titleLabel], [self widthForLabel:_subtitleLabel]);
}

@end
