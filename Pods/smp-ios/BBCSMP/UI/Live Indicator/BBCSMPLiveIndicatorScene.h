//
//  BBCSMPLiveIndicatorScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 08/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPLiveIndicatorScene <NSObject>
@required

- (void)showLiveLabel;
- (void)hideLiveLabel;
- (void)setLiveIndicatorAccessibilityLabel:(NSString *)accessibilityLabel;

@end
