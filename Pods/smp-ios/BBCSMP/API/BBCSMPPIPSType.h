//
//  BBCSMPPIPSType.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 24/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BBCSMPPIPSType) {
    BBCSMPPIPSTypeEpisode = 0
};

extern NSString* NSStringFromBBCSMPPIPSType(BBCSMPPIPSType pipsType);