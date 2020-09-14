//
//  BBCSMPAdaptiveLayoutBarCell.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 22/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString * const BBCSMPAdaptiveLayoutBarCellIdentifier;

@class BBCSMPAdaptiveLayoutBarCell;

@protocol BBCSMPAdaptiveLayoutBarCellDelegate <NSObject>
@required

- (void)layoutBarCell:(BBCSMPAdaptiveLayoutBarCell *)layoutBarCell
    willRemoveSubview:(UIView *)subview;

@end

@interface BBCSMPAdaptiveLayoutBarCell : UICollectionViewCell

@property (nonatomic, weak, nullable) id<BBCSMPAdaptiveLayoutBarCellDelegate> layoutBarCellDelegate;
@property (nonatomic, strong, nullable) UIView *customView;

@end

NS_ASSUME_NONNULL_END
