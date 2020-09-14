//
//  BBCSMPVideoSurfaceSceneController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPVideoSurfaceSceneController.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPVideoSurfaceSceneController {
    UIView *_layerContainer;
    CALayer * _Nullable _videoLayer;
}

#pragma mark Deallocation

- (void)dealloc
{
    [_layerContainer.layer removeObserver:self forKeyPath:NSStringFromSelector(@selector(bounds))];
}

#pragma mark Initialization

- (instancetype)initWithLayerContainer:(UIView *)layerContainer
{
    self = [super init];
    if(self) {
        _layerContainer = layerContainer;
        layerContainer.backgroundColor = [UIColor blackColor];
        [layerContainer.layer addObserver:self
                               forKeyPath:NSStringFromSelector(@selector(bounds))
                                  options:NSKeyValueObservingOptionNew
                                  context:NULL];
    }
    
    return self;
}

#pragma mark Overrides

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    _videoLayer.bounds = _layerContainer.bounds;
}

#pragma mark BBCSMPVideoSurfaceScene

- (void)showVideoLayer:(CALayer *)videoLayer
{
    _videoLayer = videoLayer;
    [_layerContainer.layer addSublayer:videoLayer];
    
    videoLayer.anchorPoint = CGPointZero;
    videoLayer.bounds = _layerContainer.bounds;
}

- (void)appear
{
    _layerContainer.hidden = NO;
}

- (void)disappear
{
    _layerContainer.hidden = YES;
}

@end
