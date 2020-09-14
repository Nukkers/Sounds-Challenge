//
//  BBCSMPErrorMessageScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 24/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPErrorMessageScene;

@protocol BBCSMPErrorMessageSceneDelegate <NSObject>
@required

- (void)errorMessageSceneDidTapDismissButton:(id<BBCSMPErrorMessageScene>)errorMessageScene;
- (void)errorMessageSceneDidTapRetryButton:(id<BBCSMPErrorMessageScene>)errorMessageScene;

@end

@protocol BBCSMPErrorMessageScene <NSObject>
@required

@property (nonatomic, weak, nullable) id<BBCSMPErrorMessageSceneDelegate> errorMessageDelegate;

- (void)show;
- (void)hide;
- (void)presentErrorDescription:(NSString*)description;

@end

NS_ASSUME_NONNULL_END
