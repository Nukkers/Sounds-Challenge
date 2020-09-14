//
//  BBCSMPAVComponentFactory.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 13/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AVPlayerProtocol;
@protocol AVAudioSessionProtocol;

@protocol BBCSMPAVComponentFactory <NSObject>
@required

- (id<AVAudioSessionProtocol>)audioSession;
- (id<AVPlayerProtocol>)createPlayer;

@end

NS_ASSUME_NONNULL_END
