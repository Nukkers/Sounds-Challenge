//
// Created by Charlotte Hoare on 07/10/2016.
// Copyright (c) 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBCSMPAVType.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPDuration;

@protocol BBCSMPPlayCTAButtonScene;

@protocol BBCSMPPlayCTAButtonSceneDelegate <NSObject>
@required

- (void)callToActionSceneDidReceiveTap:(id<BBCSMPPlayCTAButtonScene>)playCTAScene NS_SWIFT_NAME(callToActionSceneDidReceiveTap(_:));

@end

@protocol BBCSMPPlayCTAButtonScene <NSObject>
@required

@property (nonatomic, weak, nullable) id<BBCSMPPlayCTAButtonSceneDelegate> delegate;

- (void)appear;
- (void)disappear;
- (void)hideDuration;
- (void)showDuration;
- (void)setFormattedDurationString:(NSString *)formattedDuration;
- (void)setPlayCallToActionAccessibilityLabel:(NSString *)accessibilityLabel;
- (void)setPlayCallToActionAccessibilityHint:(NSString *)accessibilityHint;

// TODO: Remove
- (void)showDurationWithDuration:(BBCSMPDuration *)duration;
- (void)setAvType:(BBCSMPAVType)avType;

@end

NS_ASSUME_NONNULL_END
