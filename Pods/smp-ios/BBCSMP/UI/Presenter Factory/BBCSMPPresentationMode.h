//
//  BBCSMPPresentationMode.h
//  BBCSMP
//
//  Created by Thomas Sherwood on 22/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#ifndef BBC_SMP_PRESENTATION_MODE
#define BBC_SMP_PRESENTATION_MODE

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BBCSMPPresentationMode) {
    BBCSMPPresentationModeEmbedded,
    BBCSMPPresentationModeFullscreen,
    BBCSMPPresentationModeFullscreenFromEmbedded
};

#endif
