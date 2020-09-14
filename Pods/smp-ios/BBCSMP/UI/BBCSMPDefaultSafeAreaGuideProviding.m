//
//  BBCSMPDefaultSafeAreaGuideProviding.m
//  UI Tests Hosted
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/09/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPSystemSensitiveSafeAreaGuideProvidingFactory.h"
#import "BBCSMPFullFrameSafeAreaGuideProviding.h"
#import "BBCSMPLayoutGuideSafeAreaGuideProviding.h"

@implementation BBCSMPSystemSensitiveSafeAreaGuideProvidingFactory

- (id<BBCSMPSafeAreaGuideProviding>)createSafeAreaGuideProvidingWithView:(UIView *)view
{
    if (@available(iOS 11.0, *)) {
        return [[BBCSMPLayoutGuideSafeAreaGuideProviding alloc] initWithView:view];
    }
    else {
        return [[BBCSMPFullFrameSafeAreaGuideProviding alloc] initWithView:view];
    }
}

@end
