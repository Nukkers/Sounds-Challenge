//
//  BBCSMPAVPlayerLayerFactory.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AVPlayerProtocol;
@class AVPlayerLayer;

@protocol BBCSMPAVPlayerLayerFactory <NSObject>
@required

- (AVPlayerLayer *)playerLayerWithPlayer:(id<AVPlayerProtocol>)player;

@end

NS_ASSUME_NONNULL_END
