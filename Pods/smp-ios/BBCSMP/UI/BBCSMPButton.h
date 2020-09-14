//
//  BBCSMPButton.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 19/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPBrandable.h"
#import <UIKit/UIKit.h>

@interface BBCSMPButton : UIButton <BBCSMPBrandable>

@property (nonatomic, strong, readonly) UIColor* colour;
@property (nonatomic, strong, readonly) UIColor* selectionColor;
@property (nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;

- (BBCSMPBrand*)brand;
- (void)drawIcon; // Derived classes should override this to draw the button's icon

@end
