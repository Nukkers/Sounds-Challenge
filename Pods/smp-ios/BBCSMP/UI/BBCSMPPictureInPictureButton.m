//
//  BBCSMPPictureInPictureButton.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 30/03/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPPictureInPictureButton.h"
#import "BBCSMPIcon.h"

@interface BBCSMPPictureInPictureButton ()

@property (nonatomic, strong) id<BBCSMPIcon> lastRenderedIcon;

@end

#pragma mark -

@implementation BBCSMPPictureInPictureButton

#pragma mark Overrides

- (void)drawIcon
{
    [_lastRenderedIcon drawInFrame:self.bounds];
}

#pragma mark Public

- (void)renderIcon:(id<BBCSMPIcon>)icon
{
    _lastRenderedIcon = icon;
    [self setNeedsDisplay];
}

@end
