//
//  BBCSMPUIEmbeddedDefaultConfiguration.m
//  BBCSMP
//
//  Created by Michael Emmens on 09/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPUIEmbeddedDefaultConfiguration.h"

@implementation BBCSMPUIEmbeddedDefaultConfiguration

- (instancetype)init
{
    if ((self = [super init])) {
        self.subtitlesEnabled = NO;
        self.airplayEnabled = NO;
        self.standInPlayButtonStyle = BBCSMPStandInPlayButtonStyleIcon;
        self.inactivityPeriod = 2.0;
    }
    return self;
}

@end
