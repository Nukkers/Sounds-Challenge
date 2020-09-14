//
//  BBCSMPGuidanceMessageView.h
//  BBCSMP
//
//  Created by Gregory Spiers on 18/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPGuidanceMessageScene.h"
#import <UIKit/UIKit.h>

@interface BBCSMPGuidanceMessageView : UIView <BBCSMPGuidanceMessageScene>

@property (nonatomic, strong) NSString* guidanceMessage;
- (CGFloat)viewHeightForWidth:(CGFloat)width;

@end
