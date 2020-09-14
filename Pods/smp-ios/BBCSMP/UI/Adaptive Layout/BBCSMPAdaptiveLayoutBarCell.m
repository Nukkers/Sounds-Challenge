//
//  BBCSMPAdaptiveLayoutBarCell.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 22/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPAdaptiveLayoutBarCell.h"
#import "BBCSMPAdaptiveLayoutBarCellContentView.h"

NSString * const BBCSMPAdaptiveLayoutBarCellIdentifier = @"ButtonCell";

@interface BBCSMPAdaptiveLayoutBarCell () <BBCSMPAdaptiveLayoutBarCellContentViewDelegate>
@end

#pragma mark -

@implementation BBCSMPAdaptiveLayoutBarCell {
    BBCSMPAdaptiveLayoutBarCellContentView *_containerWrapperView;
    UIView *_customView;
    BOOL _isPreparingForReuse;
}

#pragma mark Overrides

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self setUp];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setUp];
    }
    
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    _isPreparingForReuse = YES;
    
    if([_customView isDescendantOfView:_containerWrapperView]) {
        [_customView removeFromSuperview];
    }
    
    _isPreparingForReuse = NO;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    _containerWrapperView.frame = self.frame;
    _customView.frame = self.frame;
}

#pragma mark Public

- (void)setCustomView:(UIView *)customView
{
    _customView = customView;
    
    [_containerWrapperView addSubview:customView];
    _customView.frame = self.frame;
}

#pragma mark BBCSMPAdaptiveLayoutBarCellContentViewDelegate

- (void)contentView:(BBCSMPAdaptiveLayoutBarCellContentView *)contentView
  willRemoveSubview:(UIView *)subview;
{
    if(!_isPreparingForReuse) {
        [_layoutBarCellDelegate layoutBarCell:self willRemoveSubview:subview];
    }
}

#pragma mark Private

- (void)setUp
{
    _containerWrapperView = [[BBCSMPAdaptiveLayoutBarCellContentView alloc] initWithFrame:self.bounds];
    _containerWrapperView.backgroundColor = [UIColor clearColor];
    _containerWrapperView.contentViewDelegate = self;
    
    [self.contentView addSubview:_containerWrapperView];
}

@end
