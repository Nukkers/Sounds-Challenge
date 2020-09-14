//
//  BBCSMPChromeVisibility.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 07/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPChromeVisibilityObserver <NSObject>
@required

- (void)chromeDidBecomeVisible;
- (void)chromeDidBecomeHidden;

@end

@protocol BBCSMPChromeVisibility <NSObject>
@required

- (void)addVisibilityObserver:(id<BBCSMPChromeVisibilityObserver>)visibilityObserver;

@end

NS_ASSUME_NONNULL_END
