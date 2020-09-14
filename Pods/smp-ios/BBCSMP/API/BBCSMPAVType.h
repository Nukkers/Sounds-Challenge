//
//  BBCSMPAVType.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 24/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BBCSMPAVType) {
    BBCSMPAVTypeVideo = 0,
    BBCSMPAVTypeAudio
};

extern NSString* NSStringFromBBCSMPAVType(BBCSMPAVType avType);
