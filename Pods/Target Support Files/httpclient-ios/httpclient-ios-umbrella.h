#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BBCHTTPCapturingNetworkObserver.h"
#import "BBCHTTPConsoleLogger.h"
#import "BBCHTTPConsoleLoggingNetworkObserver.h"
#import "BBCHTTPDefaultUserAgent.h"
#import "BBCHTTPDefaultUserAgentTokenSanitizer.h"
#import "BBCHTTPDeviceInformation.h"
#import "BBCHTTPFileLogger.h"
#import "BBCHTTPFileLoggingNetworkObserver.h"
#import "BBCHTTPImageResponseProcessor.h"
#import "BBCHTTPJSONResponseProcessor.h"
#import "BBCHTTPLibraryUserAgent.h"
#import "BBCHTTPLogger.h"
#import "BBCHTTPLoggingNetworkObserver.h"
#import "BBCHTTPMethod.h"
#import "BBCHTTPMultiTokenUserAgent.h"
#import "BBCHTTPNetworkClient.h"
#import "BBCHTTPNetworkClientAuthenticationDelegate.h"
#import "BBCHTTPNetworkError.h"
#import "BBCHTTPNetworkObserver.h"
#import "BBCHTTPNetworkReachabilityManager.h"
#import "BBCHTTPNetworkReachabilityStatus.h"
#import "BBCHTTPNetworkRequest.h"
#import "BBCHTTPNetworkResponse.h"
#import "BBCHTTPNetworkTask.h"
#import "BBCHTTPNetworkURLRequestBuilder.h"
#import "BBCHTTPOAuthRequestDecorator.h"
#import "BBCHTTPReachability.h"
#import "BBCHTTPReachabilityDeviceSpecific.h"
#import "BBCHTTPSAMLRequestDecorator.h"
#import "BBCHTTPStringUserAgent.h"
#import "BBCHTTPUserAgentToken.h"
#import "BBCHTTPVersion.h"
#import "HTTPClientDefines.h"
#import "BBCHTTPClient.h"
#import "BBCHTTPError.h"
#import "BBCHTTPNetworkStatus.h"
#import "BBCHTTPRequest.h"
#import "BBCHTTPRequestDecorator.h"
#import "BBCHTTPResponse.h"
#import "BBCHTTPResponseProcessor.h"
#import "BBCHTTPTask.h"
#import "BBCHTTPURLRequestBuilder.h"
#import "BBCHTTPUserAgent.h"
#import "BBCHTTPUserAgentTokenSanitizer.h"
#import "BBCHTTPDefaultNSURLSessionProvider.h"
#import "BBCHTTPNetworkClient+Internal.h"
#import "BBCHTTPNetworkClientContext.h"
#import "BBCHTTPNetworkTask+Internal.h"
#import "BBCHTTPNetworkTaskRegistry.h"
#import "BBCHTTPNSURLSessionProviding.h"
#import "BBCHTTPOperationQueueWorker.h"
#import "BBCHTTPResponseWorker.h"
#import "BBCHTTPURLSessionDelegate.h"
#import "HTTPClient.h"

FOUNDATION_EXPORT double HTTPClientVersionNumber;
FOUNDATION_EXPORT const unsigned char HTTPClientVersionString[];

