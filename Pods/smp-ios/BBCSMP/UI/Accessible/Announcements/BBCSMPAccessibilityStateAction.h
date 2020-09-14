//
//  BBCSMPAccessibilityStateAction.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 29/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPAccessibilityStateAction <NSObject>
@required

- (void)executeAction;

@end
