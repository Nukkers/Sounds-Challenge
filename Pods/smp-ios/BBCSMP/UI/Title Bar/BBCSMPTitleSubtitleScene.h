//
//  BBCSMPTitleSubtitleScene.h
//  BBCSMP
//
//  Created by Timothy James Condon on 14/11/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPTitleSubtitleScene <NSObject>
@required

- (void)setTitle:(NSString*)title;
- (void)setSubtitle:(NSString *)subtitle;
- (void)show;
- (void)hide;
- (void)setTitleSubtitleAccessibilityLabel:(NSString *)accessibilityLabel;
- (void)setTitleSubtitleAccessibilityHint:(NSString *)accessibilityHint;
- (void)resignAccessibilityInteraction;
- (void)becomeAccessible;
- (void)setLabelAlignment:(NSTextAlignment)textAlignment;
-(CGFloat)largestTitleWidth;

@end

NS_ASSUME_NONNULL_END
