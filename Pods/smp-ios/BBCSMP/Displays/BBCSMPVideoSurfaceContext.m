//
//  BBCSMPVideoSurfaceContext.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 13/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPVideoSurfaceContext.h"

@interface BBCSMPVideoSurfaceContext ()

@property (nonatomic, strong, readwrite) CALayer<BBCSMPDecoderLayer>* playerLayer;
@property (nonatomic, weak, readwrite) id<BBCSMPPlayerObservable> observable;

@end

@implementation BBCSMPVideoSurfaceContext

- (instancetype)initWithPlayerLayer:(CALayer<BBCSMPDecoderLayer>*)playerLayer observable:(id<BBCSMPPlayerObservable>)observable
{
    self = [super init];
    if (self) {
        _playerLayer = playerLayer;
        _observable = observable;
    }

    return self;
}

@end
