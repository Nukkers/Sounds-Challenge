//
//  BBCSMPDefaultAccessibilityAnnouncer.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefaultAccessibilityAnnouncer.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPDefaultAccessibilityAnnouncer

- (void)announce:(NSString*)phrase
{
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, phrase);
}

@end
