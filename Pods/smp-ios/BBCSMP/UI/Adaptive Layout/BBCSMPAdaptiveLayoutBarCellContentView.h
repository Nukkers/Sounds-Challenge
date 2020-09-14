//
//  BBCSMPAdaptiveLayoutBarCellContentView.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 28/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPAdaptiveLayoutBarCellContentView;

@protocol BBCSMPAdaptiveLayoutBarCellContentViewDelegate <NSObject>
@required

- (void)contentView:(BBCSMPAdaptiveLayoutBarCellContentView *)contentView
  willRemoveSubview:(UIView *)subview;

@end

@interface BBCSMPAdaptiveLayoutBarCellContentView : UIView

@property (nonatomic, weak, nullable) id<BBCSMPAdaptiveLayoutBarCellContentViewDelegate> contentViewDelegate;

@end

NS_ASSUME_NONNULL_END
