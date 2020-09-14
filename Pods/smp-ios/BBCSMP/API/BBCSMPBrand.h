//
//  BBCSMPBrand.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 20/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class UIColor;
@class BBCSMPAccessibilityIndex;
@class BBCSMPBrandingIcons;
@class BBCSMPAccessibilityIndex;
@protocol BBCSMPIcon;

@interface BBCSMPBrand : NSObject

@property (nonatomic, strong) UIColor* highlightColor;
@property (nonatomic, strong) UIColor* focusedHighlightColor;
@property (nonatomic, strong, nullable) UIColor* foregroundColor;
@property (nonatomic, strong, nullable) UIColor* selectedForegroundColor;
@property (nonatomic, strong) BBCSMPBrandingIcons* icons;
@property (nonatomic, strong) BBCSMPAccessibilityIndex* accessibilityIndex;

@end

NS_ASSUME_NONNULL_END
