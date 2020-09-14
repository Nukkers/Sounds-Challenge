//
//  BBCSMPOverlayViews.h
//  BBCSMP
//
//  Created by Daniel Ellis on 21/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPOverlayScene.h"
#import "BBCSMPDefines.h"

@class UIView;

@protocol BBCSMPOverlayViewsDelegate <NSObject>

- (void)overlayViewsDidChange;

@end

@interface BBCSMPOverlayViews : NSObject <BBCSMPOverlayScene>
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, weak) id<BBCSMPOverlayViewsDelegate>delegate;

- (instancetype)initWithBelowAllParentView:(UIView*)belowAllParentView
                avoidingControlsParentView:(UIView*)avoidingControlsParentView
                        aboveAllParentView:(UIView*)aboveAllParentView NS_DESIGNATED_INITIALIZER;

- (void)addOverlayView:(UIView*)overlayView inPosition:(BBCSMPOverlayPosition)position;

- (void)removeOverlayView:(UIView*)overlayView;

- (void)setFrame:(CGRect)frame forOverlaysWithPosition:(BBCSMPOverlayPosition)position;

@end
