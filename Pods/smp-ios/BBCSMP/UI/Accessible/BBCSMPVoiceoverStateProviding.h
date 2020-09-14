//
//  BBCSMPVoiceoverStateProviding.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 07/02/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPVoiceoverStateProviding <NSObject>
@required

@property (nonatomic, readonly, getter=isVoiceoverRunning) BOOL voiceoverRunning;

@end
