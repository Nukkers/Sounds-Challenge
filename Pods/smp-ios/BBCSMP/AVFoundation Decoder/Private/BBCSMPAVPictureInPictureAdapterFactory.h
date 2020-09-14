//
//  BBCSMPAVPlayerPictureInPictureAdapterFactory.h
//  BBCSMP
//
//  Created by Timothy James Condon on 31/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AVPlayerLayer;
@protocol BBCSMPPictureInPictureAdapter;

@interface BBCSMPAVPictureInPictureAdapterFactory : NSObject

+ (id<BBCSMPPictureInPictureAdapter>)createPictureInPictureAdapterWithPlayerLayer:(AVPlayerLayer*)playerLayer;

@end
