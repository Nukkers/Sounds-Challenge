//
//  BBCSMPAutorecoveryRule.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 03/11/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPPlayerObservable;

@protocol BBCSMPAutorecoveryDelegate <NSObject>

- (void)autorecoveryShouldBePerformed;
- (void)autorecoveryShouldAbandonPlayback;

@end

@protocol BBCSMPAutorecoveryRule <NSObject>
@required

@property (nonatomic, weak, nullable) id<BBCSMPAutorecoveryDelegate> delegate;

- (void)attachToPlayerObservable:(id<BBCSMPPlayerObservable>)playerObservable;
- (void)evaluate;

@end

NS_ASSUME_NONNULL_END
