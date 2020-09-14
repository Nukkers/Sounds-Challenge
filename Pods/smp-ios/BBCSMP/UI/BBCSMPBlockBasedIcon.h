//
//  BBCSMPBlockBasedIcon.h
//  BBCSMP
//
//  Created by Michael Emmens on 18/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import "BBCSMPIcon.h"
#import <UIKit/UIKit.h>

typedef void (^BBCSMPIconDrawingBlock)(UIColor* colour, CGRect iconFrame);

@interface BBCSMPBlockBasedIcon : NSObject <BBCSMPIcon>
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, strong) UIColor* colour;

+ (instancetype)iconWithBlock:(BBCSMPIconDrawingBlock)block;
- (instancetype)initWithBlock:(BBCSMPIconDrawingBlock)block NS_DESIGNATED_INITIALIZER;

@end
