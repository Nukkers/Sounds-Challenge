//
//  BBCMediaSelectorClient.m
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 04/02/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

@import HTTPClient;
#import "BBCMediaConnectionSorter.h"
#import "BBCMediaSelectorClient.h"
#import "BBCMediaSelectorDefaultConfiguration.h"
#import "BBCMediaSelectorParser.h"
#import "BBCMediaSelectorRandomizer.h"
#import "BBCMediaSelectorRequestHeadersBuilder.h"
#import "BBCMediaSelectorURLBuilder.h"
#import "BBCMediaSelectorVersion.h"
#import "BBCOperationQueueWorker.h"
#import "BBCWorker.h"

NSErrorDomain const BBCMediaSelectorClientErrorDomain = @"BBCMediaSelectorClientError";
NSErrorDomain const BBCMediaSelectorErrorDomain = @"BBCMediaSelectorError";

BBCMediaSelectorErrorDescription const BBCMediaSelectorErrorBadResponseDescription = @"Media-selector returned a bad response";
BBCMediaSelectorErrorDescription const BBCMediaSelectorErrorSelectionUnavailableDescription = @"Selection is unavailable";
BBCMediaSelectorErrorDescription const BBCMediaSelectorErrorGeoLocationDescription = @"Selection is GeoIP restricted";

@interface BBCMediaSelectorClient ()

@property (strong, nonatomic) id<BBCMediaSelectorParsing> parsing;
@property (strong, nonatomic) id<BBCMediaSelectorConfiguring> configuring;
@property (strong, nonatomic) id<BBCMediaSelectorRandomization> randomiser;
@property (strong, nonatomic) id<BBCHTTPClient> httpClient;
@property (strong, nonatomic) id<BBCWorker> responseWorker;
@property (strong, nonatomic) id<BBCHTTPUserAgent> userAgent;

@end

@implementation BBCMediaSelectorClient

static BBCMediaSelectorClient* sharedClient = nil;

+ (BBCMediaSelectorClient*)sharedClient
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[BBCMediaSelectorClient alloc] init];
    });
    return sharedClient;
}

- (instancetype)init
{
    if ((self = [super init])) {
        self.parsing = [[BBCMediaSelectorParser alloc] initWithConnectionSorting:[[BBCMediaConnectionSorter alloc] initWithRandomization:[[BBCMediaSelectorRandomizer alloc] init]]];
        self.configuring = [[BBCMediaSelectorDefaultConfiguration alloc] init];
        self.httpClient = [[BBCHTTPNetworkClient alloc] init];
        self.userAgent = [BBCHTTPLibraryUserAgent userAgentWithLibraryName:@"MediaSelectorClient" libraryVersion:@BBC_MEDIASELECTOR_VERSION];
        self.responseWorker = [BBCOperationQueueWorker new];
    }
    return self;
}

- (instancetype)withRandomiser:(id<BBCMediaSelectorRandomization>)randomiser
{
    self.randomiser = randomiser;
    self.parsing = [[BBCMediaSelectorParser alloc] initWithConnectionSorting:[[BBCMediaConnectionSorter alloc] initWithRandomization:randomiser]];
    return self;
}

- (instancetype)withConfiguring:(id<BBCMediaSelectorConfiguring>)configuring
{
    self.configuring = configuring;
    if ([_configuring respondsToSelector:@selector(userAgent)] && [_configuring userAgent]) {
        self.userAgent = [_configuring userAgent];
    }
    return self;
}

- (instancetype)withHTTPClient:(id<BBCHTTPClient>)httpClient
{
    self.httpClient = httpClient;
    return self;
}

- (instancetype)withParsing:(id<BBCMediaSelectorParsing>)parsing
{
    self.parsing = parsing;
    return self;
}

- (instancetype)withResponseWorker:(id<BBCWorker>)worker
{
    self.responseWorker = worker;
    return self;
}

- (void)sendRequestForURL:(NSString*)url withHeaders:(NSDictionary*)headers withSecureConnectionPreference:(BBCMediaSelectorSecureConnectionPreference)secureConnectionPreference success:(BBCMediaSelectorClientResponseBlock)success failure:(BBCMediaSelectorClientFailureBlock)failure
{
    id<BBCWorker> responseWorker = _responseWorker;
    BBCHTTPNetworkRequest* request = [[[[[BBCHTTPNetworkRequest alloc] initWithString:url] withHeaders:headers] withUserAgent:_userAgent] withResponseProcessors:@[ [[BBCHTTPJSONResponseProcessor alloc] init] ]];
    __weak BBCMediaSelectorClient *weakSelf = self;
    [_httpClient sendRequest:request
        success:^(id<BBCHTTPRequest> request, id<BBCHTTPResponse> response) {
            NSError* error = nil;
            BBCMediaSelectorResponse* mediaSelectorResponse = [weakSelf.parsing responseFromJSONObject:response.body error:&error];
            [mediaSelectorResponse setSecureConnectionPreference:secureConnectionPreference];
            [responseWorker performWork:^{
                if (mediaSelectorResponse) {
                    success(mediaSelectorResponse);
                }
                else {
                    failure(error);
                }
            }];
        }
        failure:^(id<BBCHTTPRequest> request, id<BBCHTTPError> error) {
            NSError* responseError = error.error;
            if (error.body) {
                [weakSelf.parsing responseFromJSONObject:error.body error:&responseError];
            }

            [responseWorker performWork:^{
                failure(responseError);
            }];
        }];
}

- (void)sendMediaSelectorRequest:(BBCMediaSelectorRequest*)request success:(BBCMediaSelectorClientResponseBlock)success failure:(BBCMediaSelectorClientFailureBlock)failure
{
    NSError* requestValidationError = nil;
    if (![request isValid:&requestValidationError]) {
        failure(requestValidationError);
        return;
    }
    
    BBCMediaSelectorRequest* requestToSend = request;
    if (!request.hasMediaSet && [_configuring respondsToSelector:@selector(mediaSet)]) {
        requestToSend = [[[BBCMediaSelectorRequest alloc] initWithRequest:request] withMediaSet:[_configuring mediaSet]];
    }
    BBCMediaSelectorURLBuilder* urlBuilder = [[BBCMediaSelectorURLBuilder alloc] initWithConfiguring:_configuring];
    NSString* url = [urlBuilder urlForRequest:requestToSend];
    BBCMediaSelectorRequestHeadersBuilder* requestHeadersBuilder = [[BBCMediaSelectorRequestHeadersBuilder alloc] initWithConfiguring:_configuring];
    NSDictionary* headers = [requestHeadersBuilder headersForRequest:requestToSend];
    [self sendRequestForURL:url withHeaders:headers withSecureConnectionPreference:request.secureConnectionPreference success:success failure:failure];
}

@end
