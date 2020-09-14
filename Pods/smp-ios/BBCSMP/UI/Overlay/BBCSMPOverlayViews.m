//
//  BBCSMPOverlayViews.m
//  BBCSMP
//
//  Created by Daniel Ellis on 21/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPOverlayViews.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPOverlayViews {
    NSDictionary<NSNumber*, UIView*>* _overlayParentViews;
    NSDictionary<NSNumber*, NSMutableArray*>* _overlayViews;
}

- (instancetype)initWithBelowAllParentView:(UIView*)belowAllParentView
                avoidingControlsParentView:(UIView*)avoidingControlsParentView
                        aboveAllParentView:(UIView*)aboveAllParentView
{
    self = [super init];
    
    if (self) {
        _overlayParentViews = @{ [NSNumber numberWithUnsignedInteger:BBCSMPOverlayPositionAboveAll] : aboveAllParentView,
                                 [NSNumber numberWithUnsignedInteger:BBCSMPOverlayPositionAvoidingControls] : avoidingControlsParentView,
                                 [NSNumber numberWithUnsignedInteger:BBCSMPOverlayPositionBelowAll] : belowAllParentView };
        _overlayViews = @{ [NSNumber numberWithUnsignedInteger:BBCSMPOverlayPositionAboveAll] : [NSMutableArray array],
                           [NSNumber numberWithUnsignedInteger:BBCSMPOverlayPositionAvoidingControls] : [NSMutableArray array],
                           [NSNumber numberWithUnsignedInteger:BBCSMPOverlayPositionBelowAll] : [NSMutableArray array] };

    }
    
    return self;
}

- (void)addOverlayView:(UIView*)overlayView inPosition:(BBCSMPOverlayPosition)position
{
    [_overlayParentViews[[NSNumber numberWithUnsignedInteger:position]] addSubview:overlayView];
    
    NSMutableArray* overlayViews = [self overlayViewsForPosition:position];
    if (overlayViews) {
        [overlayViews addObject:overlayView];
    }
    
    [self notifyDelegateOfOverlayChange];
}

- (void)removeOverlayView:(UIView*)overlayView
{
    [overlayView removeFromSuperview];
    for (NSMutableArray<UIView*>* overlayViews in [_overlayViews allValues]) {
        [overlayViews removeObject:overlayView];
    }
    
    [self notifyDelegateOfOverlayChange];
}

- (void)notifyDelegateOfOverlayChange {
    if ([self.delegate respondsToSelector:@selector(overlayViewsDidChange)]) {
        [self.delegate overlayViewsDidChange];
    }
}

- (void)setFrame:(CGRect)frame forOverlaysWithPosition:(BBCSMPOverlayPosition)position
{
    NSMutableArray* overlayViews = [self overlayViewsForPosition:position];
    
    for (UIView* overlayView in overlayViews) {
        [overlayView setFrame:frame];
    }
}

#pragma mark - BBCSMPOverlayScene

- (void)show
{
    for (id key in _overlayParentViews) {
        _overlayParentViews[key].hidden = NO;
    }

}

- (void)hide
{
    for (id key in _overlayParentViews) {
        _overlayParentViews[key].hidden = YES;
    }

}

#pragma mark - Private
- (NSMutableArray<UIView*>*)overlayViewsForPosition:(BBCSMPOverlayPosition)position
{
    return [_overlayViews objectForKey:[NSNumber numberWithUnsignedInteger:position]];
}

@end
