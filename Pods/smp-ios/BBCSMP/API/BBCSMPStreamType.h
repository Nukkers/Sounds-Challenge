//
//  BBCSMPStreamType.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 14/07/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

typedef NS_ENUM(NSUInteger, BBCSMPStreamType) {
    BBCSMPStreamTypeVOD,
    BBCSMPStreamTypeSimulcast,
    BBCSMPStreamTypeUnknown
};

extern NSString* NSStringFromBBCSMPStreamType(BBCSMPStreamType streamType);
