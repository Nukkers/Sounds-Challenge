
//
//  BBCSMPHTTPNetworkClient.m
//  BBCSMP
//
//  Created by Al Priest on 20/11/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import <HTTPClient/BBCHTTPNetworkClient.h>
#import <HTTPClient/BBCHTTPNetworkRequest.h>
#import "BBCSMPHTTPNetworkClientAdapter.h"

@interface BBCSMPHTTPNetworkClientAdapter ()

@property (nonatomic, strong) id<BBCHTTPClient> httpClient;

@end

@implementation BBCSMPHTTPNetworkClientAdapter

- (instancetype)initWithHTTPClient:(id<BBCHTTPClient>)httpClient
{
    if ((self = [super init])) {
        _httpClient = httpClient;
    }
    return self;
}

- (void)postData:(NSString*)body toURL:(NSURL*)url
{
    BBCHTTPNetworkRequest* request = [[BBCHTTPNetworkRequest alloc] initWithURL:url];
    [request withMethod:@"POST"];
    [request withBody:[body dataUsingEncoding:NSUTF8StringEncoding]];

    [_httpClient sendRequest:request
        success:^(id<BBCHTTPRequest> request, id<BBCHTTPResponse> response) {
        }
        failure:^(id<BBCHTTPRequest> request, id<BBCHTTPError> error) {
            NSLog(@"%@", [[error error] localizedDescription]);
        }];
}

@end
