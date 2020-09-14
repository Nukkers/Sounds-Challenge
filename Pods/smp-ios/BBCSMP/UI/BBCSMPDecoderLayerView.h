//
//  BBCSMPDecoderLayerView.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 15/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPDecoderLayer.h"
#import "BBCSMPVideoRectChangedDelegate.h"
#import "BBCSMPVideoSurfaceScene.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPVideoRectChangedDelegate;

@interface BBCSMPDecoderLayerView : UIView <BBCSMPVideoSurfaceScene>

- (instancetype)initWithFrame:(CGRect)frame delegate:(nullable id<BBCSMPVideoRectChangedDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
