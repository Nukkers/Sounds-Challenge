//
//  BBCSMPDefaultErrorMessageView.m
//  BBCSMP
//
//  Created by Samuel Taylor on 20/01/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAlertIconView.h"
#import "BBCSMPButton.h"
#import "BBCSMPDefaultErrorMessageView.h"
#import "UIColor+SMPPalette.h"

@interface BBCSMPDefaultErrorMessageView ()

@property (nonatomic, strong) UIView* shadingView;
@property (nonatomic, strong) UILabel* messageView;
@property (nonatomic, strong) BBCSMPButton* dismissButton;
@property (nonatomic, strong) BBCSMPButton* retryButton;
@property (nonatomic, strong) UIView* alertImage;
@property (nonatomic, copy) ErrorMessageViewDismissAction dismissButtonAction;
@property (nonatomic, copy) RetryAction retryButtonAction;
@property (nonatomic, strong) UIView* groupingView;

@end

@implementation BBCSMPDefaultErrorMessageView

static NSString* const BBCSMPDefaultErrorPresenterDismissButtonTitle = @"Dismiss";
static NSString* const BBCSMPDefaultErrorPresenterRetryButtonTitle = @"Try again";
static CGFloat const hitAreaPaddingForButton = 5.0;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }

    return self;
}

- (void)setBrand:(BBCSMPBrand*)brand
{
    [self.dismissButton setBrand:brand];
    [self.retryButton setBrand:brand];
}

- (void)setup
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.translatesAutoresizingMaskIntoConstraints = NO;

    UIView* shadingView = [[UIView alloc] initWithFrame:CGRectZero];
    self.shadingView = shadingView;
    self.shadingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [shadingView setBackgroundColor:[UIColor SMPStormColor]];
    [shadingView setAlpha:0.85];
    [self addSubview:shadingView];

    self.groupingView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.groupingView];

    self.alertImage = [[BBCSMPAlertIconView alloc] initWithFrame:CGRectZero];
    [self.alertImage setBackgroundColor:[UIColor clearColor]];
    [self.groupingView addSubview:_alertImage];

    self.messageView = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.messageView setTextAlignment:NSTextAlignmentCenter];
    [self.messageView setNumberOfLines:0];
    [self.messageView setTextColor:[UIColor SMPWhiteColor]];
    [self.groupingView addSubview:_messageView];

    self.dismissButton = [[BBCSMPButton alloc] initWithFrame:CGRectZero];
    [self.dismissButton setTitleColor:[UIColor SMPWhiteColor] forState:UIControlStateNormal];
    [self.dismissButton setTitle:BBCSMPDefaultErrorPresenterDismissButtonTitle forState:UIControlStateNormal];
    [self.dismissButton addTarget:self action:@selector(dismissPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.dismissButton setHitTestEdgeInsets:UIEdgeInsetsMake(-hitAreaPaddingForButton, -hitAreaPaddingForButton, hitAreaPaddingForButton, hitAreaPaddingForButton)];
    [self.groupingView addSubview:_dismissButton];

    self.retryButton = [[BBCSMPButton alloc] initWithFrame:CGRectZero];
    [self.retryButton setTitleColor:[UIColor SMPWhiteColor] forState:UIControlStateNormal];
    [self.retryButton setTitle:BBCSMPDefaultErrorPresenterRetryButtonTitle forState:UIControlStateNormal];
    [self.retryButton addTarget:self action:@selector(retryPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.retryButton setHitTestEdgeInsets:UIEdgeInsetsMake(-hitAreaPaddingForButton, -hitAreaPaddingForButton, hitAreaPaddingForButton, hitAreaPaddingForButton)];
    [self.groupingView addSubview:_retryButton];

    NSDictionary<NSString*, UIView*>* views = @{ @"Container" : self,
        @"Shade" : _shadingView,
        @"Group" : _groupingView,
        @"Icon" : _alertImage,
        @"Message" : _messageView,
        @"Dismiss" : _dismissButton,
        @"Retry" : _retryButton };
    [views enumerateKeysAndObjectsUsingBlock:^(NSString* _Nonnull key, UIView* _Nonnull obj, BOOL* _Nonnull stop) {
        obj.translatesAutoresizingMaskIntoConstraints = [key isEqualToString:@"Container"];
    }];

    NSDictionary<NSString*, NSNumber*>* metrics = @{ @"ContainerWidth" : @245.0,
        @"AlertWidth" : @25.0,
        @"AlertHeight" : @22.0,
        @"AlertBottomMargin" : @16.0,
        @"ButtonHeight" : @34.0 };
    NSMutableArray<NSLayoutConstraint*>* constraints = [NSMutableArray new];

    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[Shade]|" options:0 metrics:metrics views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[Shade]|" options:0 metrics:metrics views:views]];

    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[Icon]-AlertBottomMargin-[Message]-[Dismiss]|" options:0 metrics:metrics views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[Dismiss(==Retry)]-[Retry]|" options:0 metrics:metrics views:views]];

    [constraints addObject:[NSLayoutConstraint constraintWithItem:views[@"Group"]
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0
                                                         constant:[metrics[@"ContainerWidth"] floatValue]]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:views[@"Group"]
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:views[@"Container"]
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0
                                                         constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:views[@"Group"]
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:views[@"Container"]
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0
                                                         constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:views[@"Group"]
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0
                                                         constant:[metrics[@"ContainerWidth"] floatValue]]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:views[@"Group"]
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationLessThanOrEqual
                                                           toItem:views[@"Container"]
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:1.0
                                                         constant:0.0]];

    [constraints addObject:[NSLayoutConstraint constraintWithItem:views[@"Retry"]
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:views[@"Dismiss"]
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0
                                                         constant:0.0]];

    [constraints addObject:[NSLayoutConstraint constraintWithItem:views[@"Icon"]
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:views[@"Group"]
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0
                                                         constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:views[@"Icon"]
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0
                                                         constant:[metrics[@"AlertWidth"] floatValue]]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:views[@"Icon"]
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0
                                                         constant:[metrics[@"AlertHeight"] floatValue]]];

    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[Message]|" options:0 metrics:metrics views:views]];

    [self addConstraints:constraints];
}

#pragma mark Target Action

- (void)dismissPressed:(id)sender
{
    if (_dismissButtonAction) {
        self.dismissButtonAction();
    }

    [_errorMessageDelegate errorMessageSceneDidTapDismissButton:self];
}

- (void)retryPressed:(id)sender
{
    if (_retryButtonAction) {
        self.retryButtonAction();
    }

    [_errorMessageDelegate errorMessageSceneDidTapRetryButton:self];
}

#pragma mark BBCSMPErrorMessageScene

- (void)show
{
    self.hidden = NO;
}

- (void)hide
{
    self.hidden = YES;
}

- (void)presentErrorDescription:(NSString*)description
{
    self.messageView.text = description;
}

@end
