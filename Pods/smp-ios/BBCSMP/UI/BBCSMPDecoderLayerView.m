//
//  BBCSMPLayerView.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 15/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPDecoderLayerView.h"
#import "BBCSMPSubtitleView.h"
#import "BBCSMPVideoRectChangedDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface BBCSMPDecoderLayerView ()

@property (nonatomic, weak) CALayer* decoderLayer;
@property (nonatomic, copy) NSString* currentVideoGravity;
@property (nonatomic, weak) id<BBCSMPVideoRectChangedDelegate> delegate;

@end

#pragma mark -

@implementation BBCSMPDecoderLayerView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<BBCSMPVideoRectChangedDelegate>)delegate
{
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor blackColor];
        self.hidden = YES;
        _currentVideoGravity = AVLayerVideoGravityResizeAspect;
        self.delegate = delegate;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _decoderLayer.frame = self.layer.bounds;
}
    
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _decoderLayer.frame = self.frame;
}
    
#pragma mark BBCSMPVideoSurfaceScene
    
- (void)showVideoLayer:(CALayer *)videoLayer
{
    [self.layer addSublayer:videoLayer];
    videoLayer.frame = self.frame;
    _decoderLayer = videoLayer;
}
    
- (void)appear
{
    self.hidden = NO;
}
    
- (void)disappear
{
    self.hidden = YES;
}

@end
