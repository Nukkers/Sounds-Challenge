//
//  BBCSMPMediaSelectionLogMessage.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 29/01/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import <SMP/SMP-Swift.h>
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCMediaItem;

@interface BBCSMPMediaSelectionLogMessage : NSObject <BBCLogMessage>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithMediaItem:(BBCMediaItem *)mediaItem NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
