//
//  BBCSMPNSTimerFactory.m
//  BBCSMP
//
//  Created by Flavius Mester on 30/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPNSTimerFactory.h"
#import "NSTimerProtocol.h"

@interface NSTimer (BBCSMPCompatability) <NSTimerProtocol>

@end

@implementation NSTimer (BBCSMPCompatability)
@end

@implementation BBCSMPNSTimerFactory

- (id<NSTimerProtocol>)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo
{
    return [NSTimer scheduledTimerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
}

@end
