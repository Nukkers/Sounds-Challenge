//
//  BBCSMPAdaptiveLayoutBarCollectionViewDataSource.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 22/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPAdaptiveLayoutBarCollectionViewDataSource.h"
#import "BBCSMPAdaptiveLayoutBarCell.h"

@interface BBCSMPAdaptiveLayoutBarCollectionViewDataSource () <BBCSMPAdaptiveLayoutBarCellDelegate>
@end

#pragma mark -

@implementation BBCSMPAdaptiveLayoutBarCollectionViewDataSource {
    NSMutableArray<UIView *> *_subviews;
    NSPredicate *_viewVisiblePredicate;
    UIView *_viewToIgnoreRemovalForDueToExchangingContainer;
}

#pragma mark Deallocation

- (void)dealloc
{
    for(UIView *subview in _subviews) {
        [self removeObservationFromSubview:subview];
    }
}

#pragma mark Overrides

- (instancetype)init
{
    self = [super init];
    if(self) {
        _subviews = [NSMutableArray array];
        _visibleSubviews = [NSMutableArray array];
        _viewVisiblePredicate = [NSPredicate predicateWithFormat:@"hidden == NO"];
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    [self updateVisibleSubviews];
    [_collectionView reloadData];
    [_collectionView.superview invalidateIntrinsicContentSize];
}

#pragma mark Public

- (void)setReversed:(BOOL)reversed
{
    if(_reversed == reversed) {
        return;
    }
    
    _reversed = reversed;
    _subviews = [[[_subviews reverseObjectEnumerator] allObjects] mutableCopy];
    [self updateVisibleSubviews];
}

- (NSIndexPath *)insertCustomViewIntoDataSource:(UIView *)view
{
    NSUInteger insertedPosition;
    if(_reversed) {
        insertedPosition = 0;
        [_subviews insertObject:view atIndex:0];
    }
    else {
        insertedPosition = _subviews.count - 1;
        [_subviews addObject:view];
    }
    
    [view addObserver:self
           forKeyPath:@"hidden"
              options:NSKeyValueObservingOptionNew
              context:nil];
    [self updateVisibleSubviews];
    
    return [NSIndexPath indexPathForItem:insertedPosition inSection:0];
}

- (UIView *)customViewAtIndexPath:(NSIndexPath *)indexPath
{
    return _visibleSubviews[indexPath.item];
}

#pragma mark Private

- (void)updateVisibleSubviews
{
    _visibleSubviews = [_subviews filteredArrayUsingPredicate:_viewVisiblePredicate];
}

- (void)removeObservationFromSubview:(UIView *)subview
{
    [subview removeObserver:self forKeyPath:@"hidden"];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return _visibleSubviews.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view = [self customViewAtIndexPath:indexPath];
    _viewToIgnoreRemovalForDueToExchangingContainer = view;
    
    BBCSMPAdaptiveLayoutBarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BBCSMPAdaptiveLayoutBarCellIdentifier forIndexPath:indexPath];
    
    cell.customView = view;
    cell.layoutBarCellDelegate = self;
    
    _viewToIgnoreRemovalForDueToExchangingContainer = nil;
    
    return cell;
}

#pragma mark BBCSMPAdaptiveLayoutBarCellDelegate

- (void)layoutBarCell:(BBCSMPAdaptiveLayoutBarCell *)layoutBarCell willRemoveSubview:(UIView *)subview
{
    if(![_viewToIgnoreRemovalForDueToExchangingContainer isEqual:subview]) {
        [_subviews removeObject:subview];
        [self removeObservationFromSubview:subview];
        [self updateVisibleSubviews];
        
        [_collectionView reloadData];
    }
}

@end
