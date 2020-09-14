//
//  BBCSMPErrorMessageController.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPErrorMessageScene.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class UIButton;
@class UILabel;
@class UIView;

@interface BBCSMPErrorMessageController : NSObject <BBCSMPErrorMessageScene>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithErrorMessageContainer:(UIView *)errorMessageContainer
                        errorDescriptionLabel:(UILabel *)errorDescriptionLabel
                           dismissErrorButton:(UIButton *)dismissErrorButton
                               tryAgainButton:(UIButton *)tryAgainButton NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
