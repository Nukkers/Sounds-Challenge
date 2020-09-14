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

#import "MediaSelector.h"
#import "BBCMediaConnection.h"
#import "BBCMediaConnectionFilter.h"
#import "BBCMediaConnectionFiltering.h"
#import "BBCMediaConnectionFilteringFactory.h"
#import "BBCMediaConnectionFilteringPredicateBuilder.h"
#import "BBCMediaConnectionSorter.h"
#import "BBCMediaConnectionSorting.h"
#import "BBCMediaEnforceNonSecureConnectionFiltering.h"
#import "BBCMediaEnforceSecureConnectionFiltering.h"
#import "BBCMediaItem.h"
#import "BBCMediaNoPreferenceConnectionFiltering.h"
#import "BBCMediaPreferSecureConnectionFiltering.h"
#import "BBCMediaSelectorClient.h"
#import "BBCMediaSelectorConfiguring.h"
#import "BBCMediaSelectorDefaultConfiguration.h"
#import "BBCMediaSelectorErrors.h"
#import "BBCMediaSelectorParser.h"
#import "BBCMediaSelectorParsing.h"
#import "BBCMediaSelectorRandomization.h"
#import "BBCMediaSelectorRandomizer.h"
#import "BBCMediaSelectorRequest.h"
#import "BBCMediaSelectorRequestHeadersBuilder.h"
#import "BBCMediaSelectorRequestParameter.h"
#import "BBCMediaSelectorResponse.h"
#import "BBCMediaSelectorSecureConnectionPreference.h"
#import "BBCMediaSelectorURLBuilder.h"
#import "BBCMediaSelectorVersion.h"
#import "BBCOperationQueueWorker.h"
#import "BBCWorker.h"
#import "MediaSelectorDefines.h"

FOUNDATION_EXPORT double MediaSelectorVersionNumber;
FOUNDATION_EXPORT const unsigned char MediaSelectorVersionString[];

