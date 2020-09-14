//
//  BBCSMPTimeProvider.h
//  BBCSMP
//
//  Created by Al Priest on 20/11/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPTimerProvider <NSObject>

- (void)start;
- (NSTimeInterval)durationSinceStart;

@end
