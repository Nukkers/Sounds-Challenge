//
//  BBCSMPSuppressChromeWhileAirplaying.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 09/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAirplayObserver.h"
#import "BBCSMPChromeSupression.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPSuppressChromeWhileAirplaying.h"

static NSString* const kBBCSMPAirplayStateSuppressionReason = @"Airplay";

@interface BBCSMPSuppressChromeWhileAirplaying () <BBCSMPAirplayObserver>
@end

#pragma mark -

@implementation BBCSMPSuppressChromeWhileAirplaying {
    __weak id<BBCSMPChromeSupression> _chromeSuppression;
}

#pragma mark Initialization

- (instancetype)initWithChromeSuppression:(id<BBCSMPChromeSupression>)chromeSuppression
                                   player:(id<BBCSMP>)player
{
    self = [super init];
    if (self) {
        _chromeSuppression = chromeSuppression;
        [player addObserver:self];
    }

    return self;
}

#pragma mark BBCSMPAirplayObserver

- (void)airplayAvailabilityChanged:(__unused NSNumber*)available
{
}

- (void)airplayActivationChanged:(NSNumber*)active
{
    if (active.boolValue) {
        [_chromeSuppression suppressControlAutohideForReason:kBBCSMPAirplayStateSuppressionReason];
    }
    else {
        [_chromeSuppression stopSuppressingControlAutohideForReason:kBBCSMPAirplayStateSuppressionReason];
    }
}

@end
