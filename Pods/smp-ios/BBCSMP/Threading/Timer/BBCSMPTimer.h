//
//  BBCSMPTimer.h
//  BBCSMP
//
//  Created by Flavius Mester on 26/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import "BBCSMPTimerProtocol.h"

@protocol NSTimerProtocol;
@protocol BBCSMPNSTimerFactoryProtocol;

@interface BBCSMPTimer : NSObject <BBCSMPTimerProtocol>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithInterval:(NSTimeInterval)interval target:(id)aTarget selector:(SEL)aSelector nsTimerFactory:(id<BBCSMPNSTimerFactoryProtocol>)nsTimerFactory NS_DESIGNATED_INITIALIZER;

@property (nonatomic, strong) id<NSTimerProtocol> timer;

@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, strong) id target;
@property (nonatomic, assign) SEL selector;

@end
