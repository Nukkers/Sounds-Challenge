//
//  BBCSMPUserInteractionStatisticsManagerEvent.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 26/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPUserInteractionEvent.h"

@interface BBCSMPUserInteractionStatisticsManagerEvent : NSObject <BBCSMPUserInteractionEvent>

@property (nonatomic, strong) NSString* counterName;
@property (nonatomic, strong) NSString* actionType;
@property (nonatomic, strong) NSString* actionName;
@property (nonatomic, strong) NSDictionary* labels;

@end
