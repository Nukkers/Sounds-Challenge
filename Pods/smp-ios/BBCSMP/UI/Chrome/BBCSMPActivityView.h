//
//  BBCSMPActivityView.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 24/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPActivityScene.h"
#import <UIKit/UIKit.h>

@interface BBCSMPActivityView : UIButton <BBCSMPActivityScene>

@property (nonatomic, weak, nullable) id<BBCSMPActivitySceneDelegate> activitySceneDelegate;

@end
