//
//  BBCSMPAlertIcon.h
//  BBCSMP
//
//  Created by Al Priest on 20/01/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPIcon.h"

@interface BBCSMPAlertIcon : NSObject <BBCSMPIcon>

@property (nonatomic, strong, nonnull) UIColor* colour;
@property (nonatomic, strong, nonnull) UIColor* exclamationMarkColour;

@end
