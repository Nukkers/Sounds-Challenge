//
//  BBCSMPAudioSession.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 15/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPAudioSession;

@protocol BBCSMPAudioSessionDelegate <NSObject>
@required

- (void)audioSessionRoutingDidChange:(id<BBCSMPAudioSession>)audioSession;

@end

@protocol BBCSMPAudioSession <NSObject>
@required

@property (nonatomic, weak, nullable) id<BBCSMPAudioSessionDelegate> delegate;
@property (nonatomic, readonly) BOOL audioRoutedToExternalDevice;

@end

NS_ASSUME_NONNULL_END
