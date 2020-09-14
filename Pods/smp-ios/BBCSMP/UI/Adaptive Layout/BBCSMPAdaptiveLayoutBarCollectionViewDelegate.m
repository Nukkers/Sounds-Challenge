//
//  BBCSMPAdaptiveLayoutBarCollectionViewDelegate.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 22/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPAdaptiveLayoutBarCollectionViewDelegate.h"
#import "BBCSMPAdaptiveLayoutBarCollectionViewDataSource.h"

@implementation BBCSMPAdaptiveLayoutBarCollectionViewDelegate {
    BBCSMPAdaptiveLayoutBarCollectionViewDataSource *_dataSource;
}

#pragma mark Initialization

- (instancetype)initWithDataSource:(BBCSMPAdaptiveLayoutBarCollectionViewDataSource *)dataSource
{
    self = [super init];
    if(self) {
        _dataSource = dataSource;
    }
    
    return self;
}

#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view = [_dataSource customViewAtIndexPath:indexPath];
    CGSize intrinsicContentSize = view.intrinsicContentSize;
    CGFloat length = CGRectGetHeight(collectionView.bounds);
    CGFloat width = MAX(length, intrinsicContentSize.width);
    
    return CGSizeMake(width, length);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return _interitemSpacing;
}

@end
