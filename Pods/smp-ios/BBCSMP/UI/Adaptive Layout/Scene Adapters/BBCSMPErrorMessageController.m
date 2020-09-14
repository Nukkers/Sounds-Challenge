//
//  BBCSMPErrorMessageController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPErrorMessageController.h"
#import <UIKit/UIButton.h>
#import <UIKit/UILabel.h>
#import <UIKit/UIView.h>

@implementation BBCSMPErrorMessageController {
    UIView *_errorMessageContainer;
    UILabel *_errorDescriptionLabel;
}

#pragma mark Initialization

- (instancetype)initWithErrorMessageContainer:(UIView *)errorMessageContainer
                        errorDescriptionLabel:(UILabel *)errorDescriptionLabel
                           dismissErrorButton:(UIButton *)dismissErrorButton
                               tryAgainButton:(UIButton *)tryAgainButton
{
    self = [super init];
    if(self) {
        _errorMessageContainer = errorMessageContainer;
        _errorDescriptionLabel = errorDescriptionLabel;
        
        [dismissErrorButton addTarget:self
                               action:@selector(dismissErrorButtonTapped)
                     forControlEvents:UIControlEventTouchUpInside];
        
        [tryAgainButton addTarget:self
                           action:@selector(tryAgainButtonTapped)
                 forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

#pragma mark Private

- (void)dismissErrorButtonTapped
{
    [_errorMessageDelegate errorMessageSceneDidTapDismissButton:self];
}

- (void)tryAgainButtonTapped
{
    [_errorMessageDelegate errorMessageSceneDidTapRetryButton:self];
}

#pragma mark BBCSMPErrorMessageScene

@synthesize errorMessageDelegate = _errorMessageDelegate;

- (void)show
{
    _errorMessageContainer.hidden = NO;
}

- (void)hide
{
    _errorMessageContainer.hidden = YES;
}

- (void)presentErrorDescription:(NSString*)description
{
    _errorDescriptionLabel.text = description;
}

@end
