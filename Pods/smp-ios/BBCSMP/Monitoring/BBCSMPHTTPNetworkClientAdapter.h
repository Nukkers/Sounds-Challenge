//
//  BBCSMPHTTPNetworkClient.h
//  BBCSMP
//
//  Created by Al Priest on 20/11/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

@protocol BBCHTTPClient;

@interface BBCSMPHTTPNetworkClientAdapter : NSObject

- (instancetype)initWithHTTPClient:(id<BBCHTTPClient>)httpClient;
- (void)postData:(NSString*)body toURL:(NSURL*)url;

@end
