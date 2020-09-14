//
//  BBCSMPDefaultErrorMessageView.h
//  BBCSMP
//
//  Created by Samuel Taylor on 20/01/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPBrand.h"
#import "BBCSMPButton.h"
#import "BBCSMPErrorMessageScene.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ErrorMessageViewDismissAction)(void);
typedef void (^RetryAction)(void);

@interface BBCSMPDefaultErrorMessageView : UIView <BBCSMPErrorMessageScene>

@property (nonatomic, weak, nullable) id<BBCSMPErrorMessageSceneDelegate> errorMessageDelegate;

@property (nonatomic, strong, readonly) UILabel* messageView;
@property (nonatomic, strong, readonly) BBCSMPButton* dismissButton;
@property (nonatomic, strong, readonly) BBCSMPButton* retryButton;

- (void)setBrand:(BBCSMPBrand*)brand;

@end

NS_ASSUME_NONNULL_END
