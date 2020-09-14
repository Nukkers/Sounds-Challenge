//
//  BBCSMPTitleBarScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 24/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBCSMPUIConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPTitleTruncationDelegate <NSObject>
-(void)checkForTruncationWithNewWidth:(CGFloat)width;
@end

@protocol BBCSMPTitleBarScene <NSObject>
@required

@property (nonatomic, weak, nullable) id<BBCSMPTitleTruncationDelegate> truncationDelegate;

- (void)show;
- (void)hide;
- (void)setUpLeftAlignedCloseButton;
- (void)setUpRightAlignedCloseButton;
- (void)setUpTitleRestricted:(BBCSMPTitleBarCloseButtonAlignment)closeButtonAlignment;
- (void)setUpTitleNotRestricted;

@end

NS_ASSUME_NONNULL_END
