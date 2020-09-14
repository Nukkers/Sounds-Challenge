//
//  BBCSMPItemRetryRule.h
//  BBCSMPTests
//
//  Created by Thomas Sherwood on 31/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPPlayerObservable;

@protocol BBCSMPItemRetryRule <NSObject>
@required

- (void)attachToPlayerObservable:(id<BBCSMPPlayerObservable>)playerObservable;
- (BOOL)evaluateRule;

@end

NS_ASSUME_NONNULL_END
