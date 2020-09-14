//
//  BBCSMPAVAudioSessionAdapter.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 15/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAudioSession.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AVAudioSessionProtocol;

@interface BBCSMPAVAudioSessionAdapter : NSObject <BBCSMPAudioSession>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithAudioSession:(id<AVAudioSessionProtocol>)audioSession
                  notificationCenter:(NSNotificationCenter*)notificationCenter
                      operationQueue:(NSOperationQueue*)operationQueue NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
