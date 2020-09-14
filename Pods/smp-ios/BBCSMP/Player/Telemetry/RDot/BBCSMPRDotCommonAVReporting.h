#import "BBCSMPCommonAVReporting.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCHTTPClient;
@protocol BBCSMPSessionIdentifierProvider;

@interface BBCSMPRDotCommonAVReporting : NSObject <BBCSMPCommonAVReporting>

@property (nonatomic, readonly) id<BBCHTTPClient> httpClient;

- (instancetype)initWithHTTPClient:(id<BBCHTTPClient>)httpClient sessionIdentifierProvider: (id<BBCSMPSessionIdentifierProvider>)sessionIdentifierProvider NS_DESIGNATED_INITIALIZER;

- (void) overrideBaseUrl:(NSString*) baseUrl;

@end

NS_ASSUME_NONNULL_END
