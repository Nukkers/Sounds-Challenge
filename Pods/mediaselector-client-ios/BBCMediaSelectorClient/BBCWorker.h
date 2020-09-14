//
//  BBCWorker.h
//  BBCMediaSelectorClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/05/2016.
//  Copyright © 2016 Michael Emmens. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Work)
typedef void (^BBCWork)(void);

NS_SWIFT_NAME(Worker)
@protocol BBCWorker <NSObject>
@required

- (void)performWork:(BBCWork)work NS_SWIFT_NAME(perform(work:));

@end

NS_ASSUME_NONNULL_END
