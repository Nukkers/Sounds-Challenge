//
//  BBCMediaSelectorErrors.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 12/02/2015.
//  Copyright (c) 2015 Michael Emmens. All rights reserved.
//

@import Foundation;

FOUNDATION_EXTERN NS_SWIFT_NAME(MediaSelectorClientErrorDomain)
NSErrorDomain const BBCMediaSelectorClientErrorDomain;

FOUNDATION_EXTERN NS_SWIFT_NAME(MediaSelectorErrorDomain)
NSErrorDomain const BBCMediaSelectorErrorDomain;

typedef NSString * BBCMediaSelectorErrorDescription NS_EXTENSIBLE_STRING_ENUM NS_SWIFT_NAME(MediaSelectorErrorDescription);

FOUNDATION_EXTERN NS_SWIFT_NAME(badResponse)
BBCMediaSelectorErrorDescription const BBCMediaSelectorErrorBadResponseDescription;

FOUNDATION_EXTERN NS_SWIFT_NAME(geoLocation)
BBCMediaSelectorErrorDescription const BBCMediaSelectorErrorGeoLocationDescription;

FOUNDATION_EXTERN NS_SWIFT_NAME(selectionUnavailable)
BBCMediaSelectorErrorDescription const BBCMediaSelectorErrorSelectionUnavailableDescription ;

typedef NS_ENUM(NSInteger, BBCMediaSelectorClientError) {
    BBCMediaSelectorClientErrorInvalidRequest = 1
} NS_SWIFT_NAME(MediaSelectorClientError);

typedef NS_ENUM(NSInteger, BBCMediaSelectorError) {
    BBCMediaSelectorErrorBadResponse = 1,
    BBCMediaSelectorErrorSelectionUnavailable,
    BBCMediaSelectorErrorGeoLocation
} NS_SWIFT_NAME(MediaSelectorError);
