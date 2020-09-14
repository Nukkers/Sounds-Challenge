//
//  BBCSMPActivityScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 24/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPActivityScene;

@protocol BBCSMPActivitySceneDelegate <NSObject>
@required

- (void)activitySceneDidReceiveInteraction:(id<BBCSMPActivityScene>)activityScene;

@end

@protocol BBCSMPActivityScene <NSObject>
@required

@property (nonatomic, weak, nullable) id<BBCSMPActivitySceneDelegate> activitySceneDelegate;

- (void)setActivitySceneAccessibilityLabel:(NSString *)accessibilityLabel;
- (void)setActivitySceneAccessibilityHint:(NSString *)accessibilityHint;

@end

NS_ASSUME_NONNULL_END
