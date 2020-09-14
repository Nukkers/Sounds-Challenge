//
//  BBCSMPBufferingIndicatorScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 23/12/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPBufferingIndicatorScene <NSObject>
@required

- (void)appear;
- (void)disappear;

@end
