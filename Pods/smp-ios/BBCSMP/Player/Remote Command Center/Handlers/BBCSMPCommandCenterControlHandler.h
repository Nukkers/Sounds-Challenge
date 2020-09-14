//
//  BBCSMPCommandCenterControlHandler.h
//  BBCSMP
//
//  Created by Richard Gilpin on 24/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@protocol BBCSMPCommandCenterControlHandler <NSObject>

- (MPRemoteCommandHandlerStatus)handle;

@end
