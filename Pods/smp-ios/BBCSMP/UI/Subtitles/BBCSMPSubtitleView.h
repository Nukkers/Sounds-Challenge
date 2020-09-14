//
//  BBCSMPSubtitleView.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 13/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPSubtitleObserver.h"
#import "BBCSMPSubtitleScene.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPUIConfiguration;

@protocol BBCSMPSubtitleColorParsing <NSObject>

- (nonnull UIColor*)colorFromString:(nullable NSString*)name;

@end

@interface BBCSMPSubtitleColorParser : NSObject <BBCSMPSubtitleColorParsing>

@end

@interface BBCSMPSubtitleView : UIView <BBCSMPSubtitleObserver, BBCSMPSubtitleScene>

@property (nonatomic, strong) NSArray<UILabel*>* subtitleLabels;
@property (nonatomic, strong, readonly, nonnull) id<BBCSMPSubtitleColorParsing> colorParsing;
@property (nonatomic, strong, nullable) id<BBCSMPUIConfiguration> configuration;

- (instancetype)initWithFrame:(CGRect)frame colorParsing:(id<BBCSMPSubtitleColorParsing>)colorParsing NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder colorParsing:(id<BBCSMPSubtitleColorParsing>)colorParsing NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
