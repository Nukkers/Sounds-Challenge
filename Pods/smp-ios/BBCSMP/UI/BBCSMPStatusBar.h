//
//  BBCSMPStatusBar.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 25/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPStatusBar <NSObject>
@required

- (void)showStatusBar NS_SWIFT_NAME(showStatusBar());
- (void)hideStatusBar NS_SWIFT_NAME(hideStatusBar());

@end
