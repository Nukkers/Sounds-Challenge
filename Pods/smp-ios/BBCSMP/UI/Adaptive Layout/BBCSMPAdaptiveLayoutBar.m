//
//  BBCSMPAdaptiveLayoutBar.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 22/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPAdaptiveLayoutBar.h"
#import "BBCSMPAdaptiveLayoutBarCell.h"
#import "BBCSMPAdaptiveLayoutBarCollectionViewDataSource.h"
#import "BBCSMPAdaptiveLayoutBarCollectionViewDelegate.h"

@implementation BBCSMPAdaptiveLayoutBar {
    BOOL _viewHiearchyReady;
    UICollectionView *_collectionView;
    UICollectionViewFlowLayout *_collectionViewLayout;
    BBCSMPAdaptiveLayoutBarCollectionViewDataSource *_dataSource;
    BBCSMPAdaptiveLayoutBarCollectionViewDelegate *_layoutDelegate;
}

#pragma mark Initialization

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self prepareViewHiearchyIfNeeded];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self prepareViewHiearchyIfNeeded];
    }
    
    return self;
}

- (void)prepareViewHiearchyIfNeeded
{
    if(_viewHiearchyReady) {
        return;
    }

    _dataSource = [[BBCSMPAdaptiveLayoutBarCollectionViewDataSource alloc] init];
    _layoutDelegate = [[BBCSMPAdaptiveLayoutBarCollectionViewDelegate alloc] initWithDataSource:_dataSource];
    
    _collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_collectionViewLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.dataSource = _dataSource;
    _collectionView.delegate = _layoutDelegate;
    [super addSubview:_collectionView];
    
    [_collectionView registerClass:[BBCSMPAdaptiveLayoutBarCell class]
        forCellWithReuseIdentifier:BBCSMPAdaptiveLayoutBarCellIdentifier];
    
    _dataSource.collectionView = _collectionView;
    _viewHiearchyReady = YES;
}

#pragma mark UIAccessibilityContainer

- (NSInteger)accessibilityElementCount
{
    return _dataSource.visibleSubviews.count;
}

- (id)accessibilityElementAtIndex:(NSInteger)index
{
    NSArray *subviews = _dataSource.visibleSubviews;
    id accessibilityElement;
    if(index < subviews.count) {
        accessibilityElement = subviews[index];
    }

    return accessibilityElement;
}

- (NSInteger)indexOfAccessibilityElement:(id)element
{
    return [_dataSource.visibleSubviews indexOfObject:element];
}

- (NSArray *)accessibilityElements
{
    return _dataSource.visibleSubviews;
}

#pragma mark Overrides

- (CGSize)intrinsicContentSize
{
    return _collectionViewLayout.collectionViewContentSize;
}

- (void)addSubview:(UIView *)view
{
    [self prepareViewHiearchyIfNeeded];
    
    if(![self wouldBeInsertingOurOwnContainerIntoOurViewHiearchy:view]) {
        [_dataSource insertCustomViewIntoDataSource:view];
        [_collectionView reloadData];
    }
}

#pragma mark Public

- (CGFloat)interitemSpacing
{
    return _layoutDelegate.interitemSpacing;
}

- (void)setInteritemSpacing:(CGFloat)interitemSpacing
{
    _layoutDelegate.interitemSpacing = interitemSpacing;
}

- (BOOL)isReversed
{
    return _dataSource.isReversed;
}

- (void)setReversed:(BOOL)reversed
{
    _dataSource.reversed = reversed;
    [_collectionView reloadData];
}

#pragma mark Private

- (BOOL)wouldBeInsertingOurOwnContainerIntoOurViewHiearchy:(UIView *)view
{
    return view == _collectionView;
}

@end
