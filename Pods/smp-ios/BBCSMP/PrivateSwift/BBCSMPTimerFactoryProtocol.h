//
//  BBCSMPTimerFactory.h
//  BBCSMP
//
//  Created by Flavius Mester on 25/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPTimerProtocol.h"

@protocol BBCSMPTimerProtocol;

@protocol BBCSMPTimerFactoryProtocol <NSObject>
- (id<BBCSMPTimerProtocol>)timerWithInterval:(NSTimeInterval)interval target:(id)aTarget selector:(SEL)aSelector;
@end
