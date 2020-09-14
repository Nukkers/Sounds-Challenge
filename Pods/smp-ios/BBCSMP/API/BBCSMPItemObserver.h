//
//  BBCSMPItemObserver.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 18/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPObserver.h"

@protocol BBCSMPItem;

@protocol BBCSMPItemObserver <BBCSMPObserver>

- (void)itemUpdated:(nonnull id<BBCSMPItem>)playerItem;

@end
