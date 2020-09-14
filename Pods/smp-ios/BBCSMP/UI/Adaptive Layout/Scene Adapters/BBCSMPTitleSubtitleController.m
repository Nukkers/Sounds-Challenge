//
//  BBCSMPTitleSubtitleController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPTitleSubtitleController.h"
#import <UIKit/UILabel.h>

@implementation BBCSMPTitleSubtitleController {
    UILabel *_titleLabel;
    UILabel *_subtitleLabel;
}

#pragma mark Initialization

- (instancetype)initWithTitleLabel:(UILabel *)titleLabel
                     subtitleLabel:(UILabel *)subtitleLabel
{
    self = [super init];
    if(self) {
        _titleLabel = titleLabel;
        _subtitleLabel = subtitleLabel;
    }
    
    return self;
}

#pragma mark BBCSMPTitleSubtitleScene

- (void)setTitle:(NSString*)title
{
    _titleLabel.text = title;
}

- (void)setSubtitle:(NSString *)subtitle
{
    _subtitleLabel.text = subtitle;
}

- (void)show
{
    
}

- (void)hide
{
    
}

- (void)setTitleSubtitleAccessibilityLabel:(NSString *)accessibilityLabel
{
    
}

- (void)setTitleSubtitleAccessibilityHint:(NSString *)accessibilityHint
{
    
}

- (void)resignAccessibilityInteraction
{
    
}

- (void)becomeAccessible
{
    
}

@end
