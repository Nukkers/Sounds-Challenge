//
//  BBCSMPTooltipView.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 22/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBCSMPTooltipView : UIView

@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) UIColor* calloutColor;
@property (nonatomic, strong) UIColor* textColor;
@property (nonatomic, assign) CGFloat horizontalOffsetFromPointer;
@property (nonatomic, assign) CGSize tooltipPointerSize;

// TODO: Move this kind of information to some central BBCSMPUIMetrics class?
+ (CGSize)preferredTooltipSize;
+ (CGSize)preferredTooltipPointerSize;

@end
