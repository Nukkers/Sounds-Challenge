//
//  BBCSMPAVPlayerItemFactory.h
//  BBCSMPTests
//
//  Created by Richard Gilpin on 23/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AVPlayerItem;

@protocol BBCSMPAVPlayerItemFactory

- (AVPlayerItem *)createPlayerItemWithURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
