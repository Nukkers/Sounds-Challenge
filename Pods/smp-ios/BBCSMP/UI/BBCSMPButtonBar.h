//
//  BBCSMPButtonBar.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 20/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPBrandable.h"
#import "BBCSMPButton.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BBCSMPButtonBarAlignment) {
    BBCSMPButtonBarAlignmentLeft,
    BBCSMPButtonBarAlignmentRight
};

@protocol BBCSMPButtonBarDelegate <NSObject>

- (void)buttonTouchStarted;
- (void)buttonTouchEnded;

@end

@interface BBCSMPButtonBar : UIView <BBCSMPBrandable>

@property (nonatomic, weak) id<BBCSMPButtonBarDelegate> delegate;
@property (nonatomic, assign) BBCSMPButtonBarAlignment alignment;
@property (nonatomic, assign) CGFloat buttonWidth;
@property (nonatomic, assign) CGFloat buttonSeparation;
@property (nonatomic, assign, readonly) CGFloat requiredWidth;

- (void)addButton:(UIView*)button;
- (void)removeButton:(UIView*)button;
- (void)removeAllButtons;

@end
