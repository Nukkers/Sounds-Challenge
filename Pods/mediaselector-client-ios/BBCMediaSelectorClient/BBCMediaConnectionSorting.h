//
//  BBCMediaConnectionSorting.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 09/02/2015.
//  Copyright (c) 2015 Michael Emmens. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@class BBCMediaConnection;

NS_SWIFT_NAME(MediaConnectionSorting)
@protocol BBCMediaConnectionSorting <NSObject>

- (NSArray<BBCMediaConnection *> *)normalizeAndSortMediaConnections:(NSArray<BBCMediaConnection *> *)connections NS_SWIFT_NAME(normalizeAndSort(mediaConnections:));

@end

NS_ASSUME_NONNULL_END
