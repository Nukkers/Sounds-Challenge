//
//  BBCSMPWorker.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BBCWork)(void);

@protocol BBCSMPWorker <NSObject>
@required

- (void)performWork:(BBCWork)work;

@end

NS_ASSUME_NONNULL_END
