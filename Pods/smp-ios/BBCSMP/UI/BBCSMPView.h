//
//  BBCSMPView.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 18/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPButtonPosition.h"
#import "BBCSMPOverlayPosition.h"
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@class UIView;
@protocol BBCSMPPlayerScenes;
@protocol BBCSMPPlayerViewControlVisibilityObserver;

@protocol BBCSMPView <NSObject>
@required

@property (nonatomic, assign) CGRect videoRect;
@property (nonatomic, nullable, strong) id context;
@property (nonatomic, readonly) id<BBCSMPPlayerScenes> scenes;

- (void)addButton:(UIView*)button inPosition:(BBCSMPButtonPosition)position;
- (void)removeButton:(UIView*)button;

- (void)addOverlayView:(UIView*)overlayView inPosition:(BBCSMPOverlayPosition)position;
- (void)removeOverlayView:(UIView*)overlayView;

@end

NS_ASSUME_NONNULL_END
