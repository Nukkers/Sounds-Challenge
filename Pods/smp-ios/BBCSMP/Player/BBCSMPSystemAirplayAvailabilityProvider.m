//
//  BBCSMPSystemAirplayAvailabilityProvider.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 12/04/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPSystemAirplayAvailabilityProvider.h"
#import <MediaPlayer/MPVolumeView.h>

@interface BBCSMPSystemAirplayAvailabilityProvider ()

@property (nonatomic, strong) MPVolumeView *volumeView;

@end

#pragma mark -

@implementation BBCSMPSystemAirplayAvailabilityProvider

#pragma mark Initialization

- (instancetype)init
{
    return self = [self initWithVolumeView:[MPVolumeView new]
                        notificationCenter:[NSNotificationCenter defaultCenter]];
}

- (instancetype)initWithVolumeView:(MPVolumeView *)volumeView
                notificationCenter:(NSNotificationCenter *)notificationCenter
{
    self = [super init];
    if(self) {
        _volumeView = volumeView;
        [notificationCenter addObserver:self
                               selector:@selector(wirelessRoutesAvailableDidChange:)
                                   name:MPVolumeViewWirelessRoutesAvailableDidChangeNotification
                                 object:volumeView];
    
    }
    return self;
}

#pragma mark BBCSMPAirplayAvailabilityProvider

@synthesize delegate = _delegate;

- (void)setDelegate:(id<BBCSMPAirplayAvailabilityProviderDelegate>)delegate
{
    _delegate = delegate;
    [self notifyDelegateAboutAirplayAvailabilityState];
}

#pragma mark Notification Handler

- (void)wirelessRoutesAvailableDidChange:(__unused NSNotification *)notification
{
    [self notifyDelegateAboutAirplayAvailabilityState];
}

#pragma mark Private

- (void)notifyDelegateAboutAirplayAvailabilityState
{
    if(_volumeView.wirelessRoutesAvailable) {
        [_delegate airplayProviderDidResolveAirplayAvailable:self];
    }
    else {
        [_delegate airplayProviderDidResolveAirplayUnavailable:self];
    }
}

@end
