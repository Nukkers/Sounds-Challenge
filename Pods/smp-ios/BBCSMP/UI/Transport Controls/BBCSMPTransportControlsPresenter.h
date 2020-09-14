//
//  BBCSMPTransportControlsPresenter.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 25/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPPresenter.h"
#import "BBCSMPTransportControlsSpaceObserver.h"

@interface BBCSMPTransportControlsPresenter : NSObject

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context transportControlSpaceObserver:(id<BBCSMPTransportControlsSpaceObserver>)transportControlSpaceObserver;

@end
