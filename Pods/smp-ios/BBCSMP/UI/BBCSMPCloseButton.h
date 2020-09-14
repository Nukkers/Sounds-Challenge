//
//  BBCSMPCloseButton.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 08/07/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPIconButton.h"
#import "BBCSMPCloseButtonScene.h"

@interface BBCSMPCloseButton : BBCSMPIconButton <BBCSMPCloseButtonScene>

+ (instancetype)closeButton;

@end
