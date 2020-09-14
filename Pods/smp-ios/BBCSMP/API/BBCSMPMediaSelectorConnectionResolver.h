//
//  BBCSMPMediaSelectorConnectionResolver.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 15/03/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPItem;

@protocol BBCSMPMediaSelectorConnectionResolver <NSObject>
@required

- (void)resolvePlayerItem:(id<BBCSMPItem>)playerItem usingPlayerItemCallback:(void(^)(id<BBCSMPItem>))callback;

@end

NS_ASSUME_NONNULL_END
