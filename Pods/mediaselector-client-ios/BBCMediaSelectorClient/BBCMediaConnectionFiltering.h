//
//  BBCMediaConnectionFiltering.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 03/10/2016.
//  Copyright © 2016 Michael Emmens. All rights reserved.
//

#import "BBCMediaConnection.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MediaConnectionFiltering)
@protocol BBCMediaConnectionFiltering <NSObject>

- (NSArray<BBCMediaConnection *> *)filterConnections:(NSArray<BBCMediaConnection*>*)connections NS_SWIFT_NAME(filter(connections:));

@end

NS_ASSUME_NONNULL_END
