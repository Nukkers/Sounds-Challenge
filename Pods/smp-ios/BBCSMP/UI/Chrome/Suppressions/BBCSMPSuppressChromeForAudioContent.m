//
//  BBCSMPSuppressChromeForAudioContent.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 12/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPChromeSupression.h"
#import "BBCSMPItem.h"
#import "BBCSMPItemObserver.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPSuppressChromeForAudioContent.h"
#import "BBCSMPAVType.h"
#import "BBCSMPItemMetadata.h"

static NSString* const kBBCSMPAudioContentSuppressionReason = @"Audio Content";

@interface BBCSMPSuppressChromeForAudioContent () <BBCSMPItemObserver>
@end

#pragma mark -

@implementation BBCSMPSuppressChromeForAudioContent {
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

#pragma mark BBCSMPItemObserver

- (void)itemUpdated:(id<BBCSMPItem>)playerItem
{
    if (playerItem.metadata.avType == BBCSMPAVTypeAudio) {
        [_chromeSuppression suppressControlAutohideForReason:kBBCSMPAudioContentSuppressionReason];
    }
    else {
        [_chromeSuppression stopSuppressingControlAutohideForReason:kBBCSMPAudioContentSuppressionReason];
    }
}

@end
