//
//  BBCSMPScrubbingChromeSuppression.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 08/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPChromeSupression.h"
#import "BBCSMPScrubberScene.h"
#import "BBCSMPScrubbingChromeSuppression.h"
#import "BBCSMPScrubberController.h"

static NSString* const kBBCSMPChromeScrubbingSuppressionReason = @"Scrubbing";

@interface BBCSMPScrubbingChromeSuppression () <BBCSMPScrubberInteractionObserver>
@end

#pragma mark -

@implementation BBCSMPScrubbingChromeSuppression {
    __weak id<BBCSMPChromeSupression> _chromeSupression;
}

#pragma mark Initialization

- (instancetype)initWithChromeSuppression:(id <BBCSMPChromeSupression>)chromeSupression
                       scrubberController:(BBCSMPScrubberController*)scrubberController
{
    self = [super self];
    if (self) {
        _chromeSupression = chromeSupression;
        [scrubberController addObserver:self];
    }

    return self;
}

#pragma mark BBCSMPScrubberInteractionObserver

- (void)scrubberDidBeginScrubbing
{
    [_chromeSupression suppressControlAutohideForReason:kBBCSMPChromeScrubbingSuppressionReason];
}

- (void)scrubberDidFinishScrubbing
{
    [_chromeSupression stopSuppressingControlAutohideForReason:kBBCSMPChromeScrubbingSuppressionReason];
}

- (void)scrubberDidScrubToPosition:(NSNumber *)position {}
- (void)scrubberDidReceiveAccessibilityIncrement {}
- (void)scrubberDidReceiveAccessibilityDecrement {}

@end
