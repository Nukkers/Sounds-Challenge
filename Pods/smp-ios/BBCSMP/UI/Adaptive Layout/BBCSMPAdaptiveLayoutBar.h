//
//  BBCSMPAdaptiveLayoutBar.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 22/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface BBCSMPAdaptiveLayoutBar : UIView

@property (nonatomic, assign) IBInspectable CGFloat interitemSpacing;
@property (nonatomic, assign, getter=isReversed) IBInspectable BOOL reversed;

@end

NS_ASSUME_NONNULL_END
