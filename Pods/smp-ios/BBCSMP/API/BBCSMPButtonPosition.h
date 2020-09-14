//
//  BBCSMPButtonPosition.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 08/07/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

typedef NS_ENUM(NSUInteger, BBCSMPButtonPosition) {
    BBCSMPButtonPositionTransportControls = 0,
    BBCSMPButtonPositionTitleBarLeft BBC_SMP_DEPRECATED("This position is now reserved for the back button, use the transport controls position instead"),
    BBCSMPButtonPositionTitleBarRight,
    BBCSMPButtonPositionMax
};
