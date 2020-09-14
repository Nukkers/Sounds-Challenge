//
//  BBCSMPMediaSelectorItem.m
//  BBCSMP
//
//  Created by Michael Emmens on 31/07/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPMediaSelectorItem.h"
#import "BBCSMPURLResolvedContent.h"
#import "BBCSMPItemMetadata.h"

@implementation BBCSMPMediaSelectorItem

- (instancetype)init
{
    if ((self = [super init])) {
        self.metadata = [[BBCSMPItemMetadata alloc] init];
        self.allowsAirplay = YES;
        self.allowsExternalDisplay = YES;
    }
    return self;
}

- (id<BBCSMPResolvedContent>)resolvedContent
{
    return [[BBCSMPURLResolvedContent alloc] initWithContentURL:_mediaURL representsNetworkResource:YES];
}

- (void)teardown
{
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@ : %@", [super description],
                     [@{
                                          @"metadata" : _metadata ? [_metadata description] : @"nil",
                                          @"mediaURL" : _mediaURL ? [_mediaURL description] : @"nil",
                                          @"subtitleURL" : _subtitleURL ? [_subtitleURL description] : @"nil",
                                          @"allowsAirplay" : _allowsAirplay ? @(YES) : @(NO),
                                          @"allowsExternalDisplay" : _allowsExternalDisplay ? @(YES) : @(NO),
                                          @"actionOnBackground" : [self backgroundActionDescription:_actionOnBackground],
                                          @"playOffset" : @(_playOffset)
                                      } description]];
}

- (NSString*)backgroundActionDescription:(BBCSMPBackgroundAction)action
{
    switch (action) {
    case BBCSMPBackgroundActionDefault:
        return @"BBCSMPBackgroundActionDefault";
    case BBCSMPBackgroundActionPausePlayback:
        return @"BBCSMPBackgroundActionPausePlayback";
    case BBCSMPBackgroundActionTeardownPlayer:
        return @"BBCSMPBackgroundActionTeardownPlayer";
    }
}
 -(BOOL)isPlayable
{
    if (_mediaURL != nil) {
        return YES;
    } else {
        return NO;
    }
}

@end
