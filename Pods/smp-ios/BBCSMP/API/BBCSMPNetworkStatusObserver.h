//
//  BBCSMPNetworkStatusObserver.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 29/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPObserver.h"

@class BBCSMPNetworkStatus;

@protocol BBCSMPNetworkStatusObserver <BBCSMPObserver>

- (void)networkStatusChanged:(BBCSMPNetworkStatus*)status;

@end
