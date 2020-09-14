//
//  BBCSMPUserInteractionStatisticsConsumer.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 24/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPStatisticsConsumer.h"

@protocol BBCSMPUserInteractionEvent;

@protocol BBCSMPUserInteractionStatisticsConsumer <BBCSMPStatisticsConsumer>

- (void)trackPageViewEvent:(NSString*)counterName NS_SWIFT_NAME(trackPageViewEvent(counterName:));
- (void)trackUserInteraction:(id<BBCSMPUserInteractionEvent>)event NS_SWIFT_NAME(trackUserInteraction(event:));

@end
