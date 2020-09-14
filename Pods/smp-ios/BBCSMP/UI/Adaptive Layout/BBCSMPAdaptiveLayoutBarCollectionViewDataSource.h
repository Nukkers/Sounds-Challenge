//
//  BBCSMPAdaptiveLayoutBarCollectionViewDataSource.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 22/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPAdaptiveLayoutBarCollectionViewDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, assign, getter=isReversed) BOOL reversed;
@property (nonatomic, weak, nullable) UICollectionView *collectionView;
@property (nonatomic, strong, readonly) NSArray<UIView *> *visibleSubviews;

- (NSIndexPath *)insertCustomViewIntoDataSource:(UIView *)view;
- (UIView *)customViewAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
