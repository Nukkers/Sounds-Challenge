//
//  BBCSMPAccessibilityAnnouncer.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(AccessibilityAnnouncer)
@protocol BBCSMPAccessibilityAnnouncer <NSObject>
@required

- (void)announce:(nonnull NSString*)phrase;

@end
