//
//  BBCSMPIconFactory.h
//  BBCSMP
//
//  Created by Michael Emmens on 18/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPIcon.h"
#import <Foundation/Foundation.h>

@interface BBCSMPIconFactory : NSObject

+ (id<BBCSMPIcon>)playIcon;
+ (id<BBCSMPIcon>)pauseIcon;
+ (id<BBCSMPIcon>)stopIcon;
+ (id<BBCSMPIcon>)audioPlayIcon;

@end
