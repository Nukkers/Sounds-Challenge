//
//  MediaSelector.h
//  MediaSelector
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 07/11/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for MediaSelector.
FOUNDATION_EXPORT double MediaSelectorVersionNumber;

//! Project version string for MediaSelector.
FOUNDATION_EXPORT const unsigned char MediaSelectorVersionString[];

#import <MediaSelector/BBCMediaNoPreferenceConnectionFiltering.h>
#import <MediaSelector/BBCWorker.h>
#import <MediaSelector/BBCMediaConnectionSorting.h>
#import <MediaSelector/MediaSelectorDefines.h>
#import <MediaSelector/BBCMediaSelectorRequestHeadersBuilder.h>
#import <MediaSelector/BBCMediaPreferSecureConnectionFiltering.h>
#import <MediaSelector/BBCMediaConnectionFilteringPredicateBuilder.h>
#import <MediaSelector/BBCMediaConnectionFilter.h>
#import <MediaSelector/BBCMediaSelectorSecureConnectionPreference.h>
#import <MediaSelector/BBCMediaSelectorVersion.h>
#import <MediaSelector/BBCMediaConnectionFilteringFactory.h>
#import <MediaSelector/BBCMediaSelectorConfiguring.h>
#import <MediaSelector/BBCMediaSelectorRequestParameter.h>
#import <MediaSelector/BBCMediaConnectionSorter.h>
#import <MediaSelector/BBCMediaSelectorRandomization.h>
#import <MediaSelector/BBCMediaItem.h>
#import <MediaSelector/BBCMediaEnforceSecureConnectionFiltering.h>
#import <MediaSelector/BBCOperationQueueWorker.h>
#import <MediaSelector/BBCMediaSelectorClient.h>
#import <MediaSelector/BBCMediaSelectorErrors.h>
#import <MediaSelector/BBCMediaSelectorResponse.h>
#import <MediaSelector/BBCMediaConnection.h>
#import <MediaSelector/BBCMediaSelectorRandomizer.h>
#import <MediaSelector/BBCMediaSelectorParsing.h>
#import <MediaSelector/BBCMediaSelectorParser.h>
#import <MediaSelector/BBCMediaConnectionFiltering.h>
#import <MediaSelector/BBCMediaEnforceNonSecureConnectionFiltering.h>
#import <MediaSelector/BBCMediaSelectorRequest.h>
#import <MediaSelector/BBCMediaSelectorURLBuilder.h>
#import <MediaSelector/BBCMediaSelectorDefaultConfiguration.h>
