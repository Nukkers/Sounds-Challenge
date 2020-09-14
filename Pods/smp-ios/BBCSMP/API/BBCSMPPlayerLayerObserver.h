//
//  BBCSMPPlayerLayerObserver.h
//  BBCMediaPlayer
//
//  Created by Stuart Sharpe on 16/09/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPObserver.h"

@class AVPlayerLayer;

@protocol BBCSMPPlayerLayerObserver <BBCSMPObserver>

- (void)playerLayerUpdated:(AVPlayerLayer*)playerLayer;

@end
