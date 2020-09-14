//
//  BBCSMPTimerFactory.m
//  BBCSMP
//
//  Created by Flavius Mester on 26/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPNSTimerFactory.h"
#import "BBCSMPTimer.h"
#import "BBCSMPTimerFactory.h"
#import "BBCSMPTimerProtocol.h"

@implementation BBCSMPTimerFactory

- (id<BBCSMPTimerProtocol>)timerWithInterval:(NSTimeInterval)interval target:(id)aTarget selector:(SEL)aSelector
{
    BBCSMPNSTimerFactory* nsTimerFactory = [[BBCSMPNSTimerFactory alloc] init];
    id<BBCSMPTimerProtocol> timer = [[BBCSMPTimer alloc] initWithInterval:interval target:aTarget selector:aSelector nsTimerFactory:nsTimerFactory];
    return timer;
}
@end
