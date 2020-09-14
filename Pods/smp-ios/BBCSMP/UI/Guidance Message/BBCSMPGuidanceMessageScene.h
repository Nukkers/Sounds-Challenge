//
//  BBCSMPGuidanceMessageScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 14/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPGuidanceMessageScene <NSObject>
@required

- (void)hide;
- (void)show;
- (void)presentGuidanceMessage:(NSString*)guidanceMessage;
- (void)setGuidanceMessageAccessibilityLabel:(NSString *)accessibilityLabel;
- (void)setGuidanceMessageAccessibilityHint:(NSString *)accessibilityHint;

@end

NS_ASSUME_NONNULL_END
