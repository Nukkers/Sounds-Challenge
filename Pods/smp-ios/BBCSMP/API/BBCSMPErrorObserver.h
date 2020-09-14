//
//  BBCSMPErrorObserver.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 15/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPObserver.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPError;

@protocol BBCSMPErrorObserver <BBCSMPObserver>

- (void)errorOccurred:(BBCSMPError*)error;

@end

NS_ASSUME_NONNULL_END
