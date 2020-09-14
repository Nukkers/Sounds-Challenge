//
//  BBCSMPProtocol.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 11/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPControllable.h"
#import "BBCSMPPlayerObservable.h"
#import "BBCSMPPlayerState.h"
#import "BBCSMPUI.h"

@protocol BBCSMP <BBCSMPControllable, BBCSMPPlayerState, BBCSMPPlayerObservable, BBCSMPUI>

- (void)loadPlayerItemMetadata;

@end
