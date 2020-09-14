//
//  BBCSMPArtworkFetcher.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 02/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <HTTPClient/BBCHTTPLibraryUserAgent.h>
#import <HTTPClient/BBCHTTPNetworkClient.h>
#import <HTTPClient/BBCHTTPNetworkRequest.h>
#import "BBCSMPNetworkArtworkFetcher.h"
#import "BBCSMPArtworkURLProvider.h"
#import "BBCSMPVersion.h"

NSOperationQueue * BBCSMPImageProcessingOperationQueue()
{
    static NSOperationQueue *queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [NSOperationQueue new];
        queue.name = @"uk.co.bbc.smp-ios.image_processing_queue";
        queue.qualityOfService = NSQualityOfServiceUtility;
    });
    
    return queue;
}

@interface BBCSMPNetworkArtworkFetcher ()

@property (nonatomic, strong) id<BBCHTTPClient> httpClient;
@property (nonatomic, strong) id<BBCHTTPUserAgent> userAgent;

@end

@implementation BBCSMPNetworkArtworkFetcher

- (instancetype)init
{
    BBCHTTPNetworkClient* httpClient = [[BBCHTTPNetworkClient alloc] init];
    [httpClient setResponseOperationQueue:BBCSMPImageProcessingOperationQueue()];
    return [self initWithHTTPClient:httpClient];
}

- (instancetype)initWithHTTPClient:(id<BBCHTTPClient>)httpClient
{
    if ((self = [super init])) {
        _httpClient = httpClient;
        _userAgent = [BBCHTTPLibraryUserAgent userAgentWithLibraryName:@"BBCSMP" libraryVersion:@BBC_SMP_VERSION];
    }
    return self;
}

- (void)fetchArtworkImageAtSize:(CGSize)size scale:(CGFloat)scale success:(ArtworkFetchSuccess)success failure:(ArtworkFetchFailure)failure
{
    [_httpClient sendRequest:[[[BBCHTTPNetworkRequest alloc] initWithURL:[self.artworkURLProvider URLForArtworkAtSize:size scale:scale]] withUserAgent:_userAgent]
        success:^(id<BBCHTTPRequest> request, id<BBCHTTPResponse> response) {
            UIImage* artworkImage = [UIImage imageWithData:response.body scale:scale];
            if (artworkImage) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(artworkImage);
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure([NSError errorWithDomain:@"BBCSMPArtworkFetcher" code:1 userInfo:@{ NSLocalizedDescriptionKey : @"Unknown error fetching artwork - response did not contain an image" }]);
                });
            }
        }
        failure:^(id<BBCHTTPRequest> request, id<BBCHTTPError> error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error.error);
            });
        }];
}

@end
