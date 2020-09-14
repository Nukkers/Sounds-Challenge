//
//  BBCSMPUserInteractionStatisticsManagerEvent.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 26/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPUserInteractionStatisticsManagerEvent.h"

@implementation BBCSMPUserInteractionStatisticsManagerEvent

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@ : %@", [super description], [@{ @"counterName" : _counterName ? _counterName : @"nil",
                                          @"actionType" : _actionType ? _actionType : @"nil",
                                          @"actionName" : _actionName ? _actionName : @"nil",
                                          @"labels" : _labels ? [_labels description] : @"nil" } description]];
}

@end
