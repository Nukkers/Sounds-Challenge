//
//  BBCHTTPNetworkClientContext.h
//  BBCHTTPClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 25/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCHTTPNetworkTask.h"
#import "BBCHTTPNetworkClientAuthenticationDelegate.h"
#import "BBCHTTPNetworkObserver.h"
#import "BBCHTTPResponseWorker.h"
#import "BBCHTTPNetworkTaskRegistry.h"

@interface BBCHTTPNetworkClientContext : NSObject

@property (nonatomic, strong) BBCHTTPNetworkTaskRegistry *taskRegistry;
@property (nonatomic, strong) id<BBCHTTPResponseWorker> responseWorker;
@property (assign, nonatomic) NSRange acceptableStatusCodeRange; // Default is 200-299
@property (weak, nonatomic) id<BBCHTTPNetworkClientAuthenticationDelegate> authenticationDelegate;
@property (strong, nonatomic) NSArray<id<BBCHTTPNetworkObserver> >* observers;

@end
