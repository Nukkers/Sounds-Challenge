//
//  BBCSMPUIFullscreenDefaultConfiguration.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 31/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPUIFullscreenDefaultConfiguration.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPUIFullscreenDefaultConfiguration

#pragma mark Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleBarEnabled = YES;
        self.fullscreenEnabled = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
        self.allowPortrait = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
    }

    return self;
}

@end
