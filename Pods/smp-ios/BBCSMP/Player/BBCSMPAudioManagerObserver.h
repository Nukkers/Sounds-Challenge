//
//  BBCSMPAudioManagerObserver.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPObserver.h"

@protocol BBCSMPAudioManagerObserver <BBCSMPObserver>
@required

- (void)audioTransitionedToExternalSession;
- (void)audioTransitionedToInternalSession;

@end
