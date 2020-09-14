//
//  BBCSMPTitleBar.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 08/07/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPBrandable.h"
#import "BBCSMPButtonPosition.h"
#import "BBCSMPTitleBarScene.h"
#import "BBCSMPTitleSubtitleContainer.h"
#import <UIKit/UIKit.h>

@class BBCSMPButtonBar;
@class BBCSMPCloseButton;
@protocol BBCSMPMeasurementPolicy;
@protocol BBCSMPUIConfiguration;

@interface BBCSMPTitleBar : UIView <BBCSMPTitleBarScene, BBCSMPBrandable>

@property (nonatomic, assign) UIEdgeInsets contentInsets;
@property (nonatomic, strong) BBCSMPButtonBar* rightButtonBar;
@property (nonatomic, strong, readonly) BBCSMPCloseButton *closeButton;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame
      titleSubtitlesContainer:(BBCSMPTitleSubtitleContainer*)container
 closeButtonMeasurementPolicy:(id<BBCSMPMeasurementPolicy>)closeButtonMeasurementPolicy NS_DESIGNATED_INITIALIZER;
- (void)addButton:(UIView*)button inPosition:(BBCSMPButtonPosition)position;
- (void)removeButton:(UIView*)button;

@end
