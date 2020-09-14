//
//  BBCSMPTitleBar.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 08/07/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPButtonBar.h"
#import "BBCSMPItemPreloadMetadata.h"
#import "BBCSMPTitleSubtitleContainer.h"
#import "BBCSMPTitleBar.h"
#import "BBCSMPCloseButton.h"

@interface BBCSMPTitleBar ()

@property (nonatomic, strong) BBCSMPTitleSubtitleContainer* titleSubtitleContainer;
@property (nonatomic, strong) BBCSMPCloseButton* closeButton;

@end

@implementation BBCSMPTitleBar

@synthesize truncationDelegate = _truncationDelegate;

- (instancetype)initWithFrame:(CGRect)frame
      titleSubtitlesContainer:(BBCSMPTitleSubtitleContainer*)container
 closeButtonMeasurementPolicy:(id<BBCSMPMeasurementPolicy>)closeButtonMeasurementPolicy
{
    if ((self = [super initWithFrame:frame])) {
        _titleSubtitleContainer = container;
        [self addSubview:_titleSubtitleContainer];
        
        _rightButtonBar = [[BBCSMPButtonBar alloc] initWithFrame:CGRectZero];
        _rightButtonBar.alignment = BBCSMPButtonBarAlignmentRight;
        [self addSubview:_rightButtonBar];
        
        _closeButton = [BBCSMPCloseButton closeButton];
        _closeButton.backgroundColor = [UIColor clearColor];
        _closeButton.measurementPolicy = closeButtonMeasurementPolicy;
        [self addSubview:_closeButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat newContainerWidth = self.bounds.size.width - 2 * [self maxButtonBarWidth] - _contentInsets.left - _contentInsets.right;
    [_truncationDelegate checkForTruncationWithNewWidth:newContainerWidth];
}

- (void)setBrand:(BBCSMPBrand*)brand
{
    [_closeButton setBrand:brand];
    [_rightButtonBar setBrand:brand];
}

- (void)addButton:(UIView*)button inPosition:(BBCSMPButtonPosition)position
{
    switch (position) {
        case BBCSMPButtonPositionTitleBarRight: {
            [_rightButtonBar addButton:button];
            [self setNeedsLayout];
            break;
        }
        default: {
            NSAssert(NO, @"This position for buttons is not supported on the title bar");
            break;
        }
    }
}

- (void)removeButton:(UIView*)button
{
    [_rightButtonBar removeButton:button];
}

- (void)setUpLeftAlignedCloseButton
{
    [self setupCloseButtonWithX:_contentInsets.left];
    [self setupRightButtonBarX:self.bounds.size.width - _contentInsets.right - _rightButtonBar.requiredWidth];
}

- (void)setUpRightAlignedCloseButton
{
    [self setupCloseButtonWithX:
     self.bounds.size.width - _contentInsets.right - [_closeButton intrinsicContentSize].width];
    [self setupRightButtonBarX:self.bounds.size.width - _contentInsets.right - _rightButtonBar.requiredWidth - [_closeButton intrinsicContentSize].width];
}

- (void)setupRightButtonBarX:(CGFloat)rightButtonBarX
{
    _rightButtonBar.frame = CGRectMake(rightButtonBarX,
                                         _contentInsets.top,
                                         _rightButtonBar.requiredWidth,
                                         self.bounds.size.height - _contentInsets.top - _contentInsets.bottom);
      
}

- (void)setupCloseButtonWithX:(CGFloat)closeButtonX
{
    _closeButton.frame = CGRectMake(closeButtonX,
                                      _contentInsets.top,
                                      [_closeButton intrinsicContentSize].width,
                                      self.bounds.size.height - _contentInsets.top - _contentInsets.bottom);
}

- (void)setUpTitleNotRestricted
{
    _contentInsets.left = 0;
    _titleSubtitleContainer.frame = CGRectMake(_contentInsets.left + [self maxButtonBarWidth],
                                           _contentInsets.top,
                                           self.bounds.size.width - 2 * [self maxButtonBarWidth] - _contentInsets.left - _contentInsets.right,
                                           (CGRectGetHeight(self.bounds) - _contentInsets.top - _contentInsets.bottom));
}

- (void)setUpTitleRestricted:(BBCSMPTitleBarCloseButtonAlignment)closeButtonAlignment
{
    _contentInsets.left = 8;
    CGFloat titleContainerX = _contentInsets.left;
    
    if (closeButtonAlignment == BBCSMPTitleBarCloseButtonAlignmentLeft) {
        _contentInsets.left = 0;
        titleContainerX = _contentInsets.left + _closeButton.frame.size.width;
    }
    
    _titleSubtitleContainer.frame = CGRectMake(titleContainerX,
                                           _contentInsets.top,
                                           self.bounds.size.width - [self maxButtonBarWidth] - _contentInsets.left - _contentInsets.right,
                                           (CGRectGetHeight(self.bounds) - _contentInsets.top - _contentInsets.bottom));
}

-(CGFloat)maxButtonBarWidth
{
    return _closeButton.intrinsicContentSize.width + _rightButtonBar.requiredWidth;
}

#pragma mark Accessibility

- (BOOL)isAccessibilityElement
{
    return NO;
}

- (void)show
{
    self.hidden = NO;
}

- (void)hide
{
    self.hidden = YES;
}

@end
