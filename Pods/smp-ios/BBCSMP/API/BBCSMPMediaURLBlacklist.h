//
//  BBCSMPMediaURLBlacklist.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 25/01/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPMediaURLBlacklist <NSObject>

- (void)blacklistMediaURL:(NSURL *)mediaURL;
- (BOOL)containsMediaURL:(NSURL *)mediaURL;
- (void)removeAllMediaURLs;

@end

NS_ASSUME_NONNULL_END
