//
//  BBCSMPSuppressChromeDuringTransportControlsInteraction.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 12/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPChromeSupression.h"
#import "BBCSMPSuppressChromeDuringTransportControlsInteraction.h"
#import "BBCSMPTransportControlsScene.h"

static NSString* const kBBCSMPTransportControlsInteractionSuppressionReason = @"Interacting with transport controls";

@interface BBCSMPSuppressChromeDuringTransportControlsInteraction () <BBCSMPTransportControlsInteractivityDelegate>
@end

#pragma mark -

@implementation BBCSMPSuppressChromeDuringTransportControlsInteraction {
    __weak id<BBCSMPChromeSupression> _chromeSuppression;
}

#pragma mark Initialization

- (instancetype)initWithChromeSuppression:(id<BBCSMPChromeSupression>)chromeSuppression
                   transportControlsScene:(id<BBCSMPTransportControlsScene>)transportControlsScene
{
    self = [super init];
    if (self) {
        _chromeSuppression = chromeSuppression;
        transportControlsScene.interactivityDelegate = self;
    }

    return self;
}

#pragma mark BBCSMPTransportControlsInteractivityDelegate

- (void)transportControlsSceneInteractionsDidBegin:(id<BBCSMPTransportControlsScene>)transportControlsScene
{
    [_chromeSuppression suppressControlAutohideForReason:kBBCSMPTransportControlsInteractionSuppressionReason];
}

- (void)transportControlsSceneInteractionsDidFinish:(id<BBCSMPTransportControlsScene>)transportControlsScene
{
    [_chromeSuppression stopSuppressingControlAutohideForReason:kBBCSMPTransportControlsInteractionSuppressionReason];
}

@end
