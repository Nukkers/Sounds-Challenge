//
//  BBCSMPViewControllerDelegate.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 18/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPViewControllerDelegate <NSObject>
@required

- (void)viewWillAppear;
- (void)viewDidAppear;
- (void)viewWillDisappear;
- (void)viewDidDisappear;
- (BOOL)viewDidReceiveAccessibilityPerformEscapeGesture;

@end
