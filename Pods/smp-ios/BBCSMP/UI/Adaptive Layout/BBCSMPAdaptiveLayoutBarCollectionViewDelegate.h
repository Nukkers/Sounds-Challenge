//
//  BBCSMPAdaptiveLayoutBarCollectionViewDelegate.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 22/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPAdaptiveLayoutBarCollectionViewDataSource;

@interface BBCSMPAdaptiveLayoutBarCollectionViewDelegate : NSObject <UICollectionViewDelegateFlowLayout>
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, assign) CGFloat interitemSpacing;

- (instancetype)initWithDataSource:(BBCSMPAdaptiveLayoutBarCollectionViewDataSource *)dataSource NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
