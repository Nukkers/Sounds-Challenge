//
//  BBCSMPNetworkStatusProvider.h
//  BBCSMP
//
//  Created by Thomas Sherwood on 21/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBCSMPNetworkStatus;
@protocol BBCSMPNetworkStatusObserver;

@protocol BBCSMPNetworkStatusProvider <NSObject>
@required

@property (nonatomic, strong, readonly) BBCSMPNetworkStatus* status;

- (void)addObserver:(id<BBCSMPNetworkStatusObserver>)observer;
- (void)removeObserver:(id<BBCSMPNetworkStatusObserver>)observer;

@end
