//
//  BBCSMPPlayerSizeObserver.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 25/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPObserver.h"

@class BBCSMPSize;

@protocol BBCSMPPlayerSizeObserver <BBCSMPObserver>

- (void)playerSizeChanged:(BBCSMPSize*)playerSize;

@end
