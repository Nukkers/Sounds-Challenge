//
//  BBCSMPTimeIntervalFormatter.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 07/09/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPTimeIntervalFormatter <NSObject>
@required

- (NSString *)stringFromSeconds:(NSTimeInterval)seconds;
- (NSString *)stringFromDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
