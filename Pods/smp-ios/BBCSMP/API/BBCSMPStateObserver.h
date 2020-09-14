//
//  BBCSMPStateObserver.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 15/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPObserver.h"
#import "BBCSMPDefines.h"

@class BBCSMPState;

BBC_SMP_DEPRECATED("Please use the swift class StateObserver to observe player state")
@protocol BBCSMPStateObserver <BBCSMPObserver>

- (void)stateChanged:(nonnull BBCSMPState*)state;

@end
