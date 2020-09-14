//
//  BBCSMPSubtitleView.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 13/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPSubtitleView.h"
#import "BBCSMPSubtitleChunk.h"
#import "BBCSMPSubtitleRegion.h"
#import "BBCSMPSubtitle.h"
#import "BBCSMPUIConfiguration.h"
#import "UIColor+SMPPalette.h"
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>

@interface BBCSMPSubtitleColorParser ()

@property (strong, nonatomic, nonnull) NSDictionary<NSString*, UIColor*>* logicalColors;

@end

@implementation BBCSMPSubtitleColorParser

static NSString* kColorCodePrefix = @"#";

- (instancetype)init
{
    if ((self = [super init])) {
        _logicalColors = @{@"black":[[self class] colorWithHexRed:0x00 hexGreen:0x00 hexBlue:0x00 hexAlpha:0xff],
                           @"red":[[self class] colorWithHexRed:0xff hexGreen:0x00 hexBlue:0x00 hexAlpha:0xff],
                           @"green":[[self class] colorWithHexRed:0x40 hexGreen:0x80 hexBlue:0x80 hexAlpha:0xff],
                           @"lime":[[self class] colorWithHexRed:0x00 hexGreen:0xff hexBlue:0x00 hexAlpha:0xff],
                           @"yellow":[[self class] colorWithHexRed:0xff hexGreen:0xff hexBlue:0x00 hexAlpha:0xff],
                           @"blue":[[self class] colorWithHexRed:0x00 hexGreen:0x00 hexBlue:0xa0 hexAlpha:0xff],
                           @"magenta":[[self class] colorWithHexRed:0x80 hexGreen:0x00 hexBlue:0x80 hexAlpha:0xff],
                           @"cyan":[[self class] colorWithHexRed:0x00 hexGreen:0xff hexBlue:0xff hexAlpha:0xff],
                           @"white":[[self class] colorWithHexRed:0xff hexGreen:0xff hexBlue:0xff hexAlpha:0xff]};
    }
    return self;
}

+ (UIColor *)colorWithHexRed:(NSUInteger)red hexGreen:(NSUInteger)green hexBlue:(NSUInteger)blue hexAlpha:(NSUInteger)alpha
{
    return [UIColor colorWithRed:red / 255.0f
                           green:green / 255.0f
                            blue:blue / 255.0f
                           alpha:alpha / 255.0f];
}

+ (UIColor *)colorForRGB:(unsigned)hex
{
    NSUInteger red = (hex >> 16) & 0xFF;
    NSUInteger green = (hex >> 8) & 0xFF;
    NSUInteger blue = (hex) & 0xFF;
    return [self colorWithHexRed:red hexGreen:green hexBlue:blue hexAlpha:0xFF];
}

+ (UIColor *)colorForRGBA:(unsigned)hex
{
    NSUInteger red = (hex >> 24) & 0xFF;
    NSUInteger green = (hex >> 16) & 0xFF;
    NSUInteger blue = (hex >> 8) & 0xFF;
    NSUInteger alpha = (hex) & 0xFF;
    return [self colorWithHexRed:red hexGreen:green hexBlue:blue hexAlpha:alpha];
}

+ (UIColor *)colorForHexColorCode:(NSString*)hexString
{
    if (hexString.length == 6 || hexString.length == 8) {
        NSScanner* scanner = [NSScanner scannerWithString:hexString];
        unsigned hex;
        if ([scanner scanHexInt:&hex]) {
            if (hexString.length == 6) {
                return [self colorForRGB:hex];
            } else {
                return [self colorForRGBA:hex];
            }
        }
    }
    return nil;
}

- (UIColor*)colorForLogicalColorName:(NSString*)name
{
    return [_logicalColors objectForKey:[name lowercaseString]];
}

- (UIColor*)colorFromString:(NSString*)colorString
{
    UIColor* color = nil;
    if (colorString) {
        if ([colorString hasPrefix:kColorCodePrefix]) {
            color = [[self class] colorForHexColorCode:[colorString substringFromIndex:kColorCodePrefix.length]];
        } else {
            color = [self colorForLogicalColorName:colorString];
        }
    }
    return color ? color : [UIColor whiteColor];
}

@end

@interface BBCSMPSubtitleView ()

@property (nonatomic, strong) NSArray<BBCSMPSubtitle*>* subtitles;
@property (nonatomic, strong) NSDictionary* styleDictionary;
@property (nonatomic, strong) NSString* baseStyleKey;
@property (nonatomic, strong, nonnull) id<BBCSMPSubtitleColorParsing> colorParsing;

@property (nonatomic, assign, readonly) UIEdgeInsets defaultContentInsets;

@end

@implementation BBCSMPSubtitleView

const CGFloat kSubtitleMargin = 5.0f; // This is the distance between the text and the edges of the semi-transparent background of subtitleLabel
const CGFloat kSubtitleDefaultInset = 5.0f; // This is the default distance between the edges of the view and subtitleLabel
const int kSubtitleViewCount = 8;
const CGFloat kDesignGuidelinesBottomMarginPercentage = 0.03f;
const CGFloat kDesignGuidelinesProportionalFontLabelSizePercentage = 0.08f;

- (instancetype)initWithFrame:(CGRect)frame colorParsing:(id<BBCSMPSubtitleColorParsing>)colorParsing
{
    if ((self = [super initWithFrame:frame])) {
        [self commonInitWithColorParsing:colorParsing];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame colorParsing:[[BBCSMPSubtitleColorParser alloc] init]];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder colorParsing:(id<BBCSMPSubtitleColorParsing>)colorParsing
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self commonInitWithColorParsing:colorParsing];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithCoder:aDecoder colorParsing:[[BBCSMPSubtitleColorParser alloc] init]];
}

- (void)commonInitWithColorParsing:(id<BBCSMPSubtitleColorParsing>)colorParsing
{
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
    
    _colorParsing = colorParsing;
    
    _defaultContentInsets = UIEdgeInsetsMake(kSubtitleDefaultInset, kSubtitleDefaultInset, kSubtitleDefaultInset, kSubtitleDefaultInset);
    [self buildSubtitleViews];
}

- (void)buildSubtitleViews
{
    NSMutableArray* views = [[NSMutableArray alloc] init];
    for (int i = 0; i < kSubtitleViewCount; i++) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.hidden = YES;
        label.isAccessibilityElement = NO;
        label.backgroundColor = [UIColor SMPStormTranslucentColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;

        [self addSubview:label];
        [views addObject:label];
    }
    _subtitleLabels = views;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateSubtitleLabelFrames];
}

- (void)updateSubtitleLabelFrames
{
    __weak typeof(self) weakSelf = self;
    [_subtitles enumerateObjectsUsingBlock:^(BBCSMPSubtitle* _Nonnull obj, NSUInteger idx, BOOL* _Nonnull stop) {
        if ([obj hasPositionalSubtitles]) {
            [weakSelf updateSubtitleLabelFramesForPositionalSubtitle:obj withSubtitleLabel:[weakSelf.subtitleLabels objectAtIndex:idx]];
        }
        else {
            [weakSelf updateSubtitleLabelFrame:[weakSelf.subtitleLabels objectAtIndex:idx] forSubtitle:obj];
        }
    }];
}

- (void)updateSubtitleLabelFrame:(UILabel*)subtitleLabel forSubtitle:(BBCSMPSubtitle*)subtitle
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(_defaultContentInsets.top, _defaultContentInsets.left, _defaultContentInsets.bottom, _defaultContentInsets.right);
    CGSize requiredSize = [subtitleLabel sizeThatFits:CGSizeMake(self.bounds.size.width - 2 * kSubtitleMargin - edgeInsets.left - edgeInsets.right,
                                                                 self.bounds.size.height - 2 * kSubtitleMargin - edgeInsets.top - edgeInsets.bottom)];
    CGSize sizeWithMargins = CGSizeMake(requiredSize.width + 2 * kSubtitleMargin, requiredSize.height + 2 * kSubtitleMargin);
    
    float width = sizeWithMargins.width;
    float height = sizeWithMargins.height;

    float originX = 0.5 * (self.bounds.size.width - sizeWithMargins.width);
    float bottomMargin = (self.bounds.size.height * kDesignGuidelinesBottomMarginPercentage);
    float originY = self.bounds.size.height - bottomMargin - sizeWithMargins.height;

    subtitleLabel.frame = CGRectIntegral(CGRectMake(originX, originY, width, height));
}

- (BBCSMPObserverType)observerType
{
    return BBCSMPObserverTypeUI;
}

- (void)setSubtitles:(NSArray<BBCSMPSubtitle*>*)subtitles
{
    _subtitles = subtitles;
    
    for (UILabel* _Nonnull label in _subtitleLabels) {
        label.hidden = YES;
    }
    
    if (![subtitles.firstObject hasPositionalSubtitles]){
        __weak typeof(self) weakSelf = self;
        [_subtitles enumerateObjectsUsingBlock:^(BBCSMPSubtitle* _Nonnull obj, NSUInteger idx, BOOL* _Nonnull stop) {
            [weakSelf.subtitleLabels objectAtIndex:idx].hidden = NO;
            [weakSelf.subtitleLabels objectAtIndex:idx].attributedText = [weakSelf attributedStringForSubtitle:obj];
        }];
    }
    
    [self updateSubtitleLabelFrames];
}

- (void)updateSubtitleLabelFramesForPositionalSubtitle:(BBCSMPSubtitle*)subtitle withSubtitleLabel:(UILabel*)subtitleLabel
{
    float extentWidth = self.frame.size.width;
    float extentHeight = self.frame.size.height;
    
    float extentOriginX = ([subtitle.region origin].x / 100.0f) * extentWidth;
    float extentOriginY = ([subtitle.region origin].y / 100.0f) * extentHeight;
    
    if (!CGPointEqualToPoint(CGPointZero, [subtitle.region extent])) {
        extentWidth = extentWidth * ([subtitle.region extent].x / 100.0f);
        extentHeight = extentHeight * ([subtitle.region extent].y / 100.0f);
    }

    subtitleLabel.frame = CGRectMake(extentOriginX, extentOriginY, extentWidth, extentHeight);
    
    CGFloat labelOriginX = extentOriginX;
    CGFloat labelOriginY;
    
    subtitleLabel.attributedText = [self attributedStringForSubtitle:subtitle];
        
    [subtitleLabel sizeToFit];
    CGSize labelSize = subtitleLabel.frame.size;
     
    CGFloat labelHeight = labelSize.height;
    CGFloat labelWidth = labelSize.width;
    
    
    // Label Origin Y
    if ([subtitle.region displayAlign] && [[subtitle.region displayAlign] isEqualToString:@"after"]) {
        labelOriginY = extentOriginY + extentHeight - labelHeight;
    }
    else if ([subtitle.region displayAlign] && [[subtitle.region displayAlign] isEqualToString:@"center"]) {
        labelOriginY = extentOriginY + (extentHeight / 2.0f) - (labelHeight / 2.0f);
    }
    else {
        // The specs say before is used as default if none specified
        labelOriginY = extentOriginY;
    }
    
    // Label Origin X
    if (subtitleLabel.attributedText.length > 0) {
        NSMutableParagraphStyle* paragraphStyle = [subtitleLabel.attributedText attributesAtIndex:0 effectiveRange:nil][NSParagraphStyleAttributeName];
        
        if (paragraphStyle) {
            switch (paragraphStyle.alignment) {
                case NSTextAlignmentCenter:
                    labelOriginX = extentOriginX + (extentWidth / 2.0f) - (labelWidth / 2.0f);
                    break;
                case NSTextAlignmentLeft:
                    labelOriginX = extentOriginX;
                    break;
                case NSTextAlignmentRight:
                    labelOriginX = extentOriginX + extentWidth - labelWidth;
                    break;
                default:
                    break;
            }
        }
    }
    
    subtitleLabel.backgroundColor = [UIColor clearColor];
    
    subtitleLabel.frame = CGRectMake(labelOriginX, labelOriginY, labelWidth, labelHeight);
    
    subtitleLabel.hidden = NO;
    
}


#pragma mark - Attributed String

- (NSAttributedString*)attributedStringForSubtitle:(BBCSMPSubtitle*)subtitle
{
    NSMutableAttributedString* result = [[NSMutableAttributedString alloc] init];
    for (BBCSMPSubtitleChunk* chunk in subtitle.subtitleChunks) {
        if (chunk.text != nil) {
            NSAttributedString* as = [[NSAttributedString alloc] initWithString:chunk.text attributes:[self attributesForChunk:chunk ofSubtitle:subtitle]];
            [result appendAttributedString:as];
        }
    }
    return result;
}

- (NSDictionary*)attributesForChunk:(BBCSMPSubtitleChunk*)chunk ofSubtitle:(BBCSMPSubtitle*)subtitle
{
    NSMutableDictionary* result = [NSMutableDictionary new];
    
    NSMutableDictionary* mergedStyles = [[NSMutableDictionary alloc] init];
    if (self.baseStyleKey != nil) {
        NSArray *baseStyleKeys = [self.baseStyleKey componentsSeparatedByString:@" "];
        for (NSString* baseStyle in baseStyleKeys) {
            [self mergeReferentialStyles:baseStyle toMergedStyles:mergedStyles];
        }
    }

    if (chunk.styleDictionary != nil) {
        [mergedStyles addEntriesFromDictionary:chunk.styleDictionary];
        
        [self mergeReferentialStyles:[chunk.styleDictionary objectForKey:@"style"] toMergedStyles:mergedStyles];
    }
    
    [self mergeReferentialStyles:[subtitle.styleDictionary objectForKey:@"style"] toMergedStyles:mergedStyles];
    
    NSString* colorString = [mergedStyles objectForKey:@"color"];
    [result setObject:[_colorParsing colorFromString:colorString] forKey:NSForegroundColorAttributeName];
    
    BOOL isItalic = NO;
    NSString* fontStyle = [mergedStyles objectForKey:@"fontStyle"];
    if (fontStyle != nil && [fontStyle isEqualToString:@"italic"]) {
        isItalic = YES;
    }
    
    if ([subtitle hasPositionalSubtitles]) {
        [self processPositionalSubtitleAttributesWithItalics:isItalic
                                                  fromStyles:mergedStyles
                                     appendingIntoAttributes:result];
    }
    else {
        CGFloat labelHeight = self.bounds.size.height * kDesignGuidelinesProportionalFontLabelSizePercentage;

        [result setObject:[self calculateFontSizeFromLabelHeight:labelHeight withItalicFont:isItalic] forKey:NSFontAttributeName];
    }
    return result;
}

- (UIFont*)getFontForSize:(CGFloat)fontSize withItalics:(BOOL)isItalic
{
    NSString* fontName;
    if (isItalic) {
        fontName = @"Helvetica-BoldOblique";
    }
    else {
        fontName = @"Helvetica-Bold";
    }
    
    return [UIFont fontWithName:fontName size:fontSize];
}

- (UIFont*)calculateFontSizeFromLabelHeight:(CGFloat)labelHeight withItalicFont:(BOOL)isItalic
{
    NSString* testString = @"abcdef";
    NSInteger tempMin = 16;
    NSInteger tempMax = 92;
    NSInteger mid = 0;
    NSInteger difference = 0;
    NSInteger calculcatedLabelHeight = roundf(labelHeight - (2 * kSubtitleMargin));

    while (tempMin <= tempMax) {
        mid = tempMin + (tempMax - tempMin) / 2;
        CGSize tempFontSize = [testString sizeWithAttributes:@{ NSFontAttributeName : [self getFontForSize:mid withItalics:isItalic] }];
        difference = calculcatedLabelHeight - roundf(tempFontSize.height);

        if (mid == tempMin || mid == tempMax) {
            if (difference < 0) {
                mid = mid - 1;
                break;
            }

            break;
        }

        if (difference < 0) {
            tempMax = mid - 1;
        }
        else if (difference > 0) {
            tempMin = mid + 1;
        }
        else {
            break;
        }
    }

    return [self getFontForSize:mid withItalics:isItalic];
}

- (void)mergeReferentialStyles:(NSString*)styleName toMergedStyles:(NSMutableDictionary*)toMergedStyles
{
    if (styleName != nil) {
        [toMergedStyles addEntriesFromDictionary:[self.styleDictionary objectForKey:styleName]];
    }
}

#pragma mark Positional Subtitles

- (void)processPositionalSubtitleAttributesWithItalics:(BOOL)isItalic
                                            fromStyles:(NSMutableDictionary *)mergedStyles
                               appendingIntoAttributes:(NSMutableDictionary *)attributes
{
    [self processTextAlignmentAttributesFromStyles:mergedStyles appendingIntoAttributes:attributes];
    [self processLineHeightAttributesFromStyles:mergedStyles appendingIntoAttributes:attributes];
    [self processFontAttributesFromStyles:mergedStyles withItalics:isItalic appendingIntoAttributes:attributes];
    [self processBackgroundAttributesFromStyles:mergedStyles appendingIntoAttributes:attributes];
}

- (void)processTextAlignmentAttributesFromStyles:(NSMutableDictionary *)mergedStyles
                         appendingIntoAttributes:(NSMutableDictionary *)attributes
{
    NSString* textAlignString = [mergedStyles objectForKey:@"textAlign"];
    if (!textAlignString) {
        return;
    }
    
    NSMutableParagraphStyle* paragraphStyle = NSMutableParagraphStyle.new;
    
    if ([textAlignString isEqualToString:@"center"]) {
        paragraphStyle.alignment = NSTextAlignmentCenter;
    }
    if ([textAlignString isEqualToString:@"right"]) {
        paragraphStyle.alignment = NSTextAlignmentRight;
    }
    if ([textAlignString isEqualToString:@"left"] || [textAlignString isEqualToString:@"start"]) {
        paragraphStyle.alignment = NSTextAlignmentLeft;
    }
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
}

- (void)processLineHeightAttributesFromStyles:(NSMutableDictionary *)mergedStyles
                      appendingIntoAttributes:(NSMutableDictionary *)attributes
{
    NSString* lineHeightString = [mergedStyles objectForKey:@"lineHeight"];
    if (!lineHeightString) {
        return;
    }
    
    int lineHeightPercentage = [[lineHeightString stringByReplacingOccurrencesOfString:@"%" withString:@""] intValue];
    CGFloat lineHeight = (lineHeightPercentage / 100.0f);
    NSMutableParagraphStyle* paragraphStyle = [attributes objectForKey:NSParagraphStyleAttributeName];
    if (!paragraphStyle) {
        paragraphStyle = NSMutableParagraphStyle.new;
    }
    paragraphStyle.lineSpacing = lineHeight;
    
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
}

- (void)processFontAttributesFromStyles:(NSMutableDictionary *)mergedStyles
                             withItalics:(BOOL)isItalic
                 appendingIntoAttributes:(NSMutableDictionary *)attributes
{
    NSString* fontSizeString = [mergedStyles objectForKey:@"fontSize"];
    NSString* cellResolutionString = [mergedStyles objectForKey:@"cellResolution"];
    if (!(fontSizeString && cellResolutionString)) {
        return;
    }
    
    NSArray<NSString *>* cells = [cellResolutionString componentsSeparatedByString:@" "];
    if ([cells count] != 2) {
        return;
    }
    
    int cellRows = [cells[1] intValue];
    if (cellRows > 0) {
        CGFloat cellHeight = self.frame.size.height / cellRows;
        int fontPercentageSize = [[fontSizeString stringByReplacingOccurrencesOfString:@"%" withString:@""] intValue];
        CGFloat minimumSubtitlesSize = [self preferredMinimumSubtitlesSize];
        CGFloat fontSize = MAX(minimumSubtitlesSize, cellHeight * (fontPercentageSize / 100.0f));
        [attributes setObject:[self getFontForSize:fontSize withItalics:isItalic] forKey:NSFontAttributeName];
    }
}

- (CGFloat)preferredMinimumSubtitlesSize
{
    CGFloat minimumSubtitlesSize = 0;
    if ([_configuration respondsToSelector:@selector(minimumSubtitlesSize)]) {
        minimumSubtitlesSize = [_configuration minimumSubtitlesSize];
    }
    
    return minimumSubtitlesSize;
}

- (void)processBackgroundAttributesFromStyles:(NSMutableDictionary *)mergedStyles
                      appendingIntoAttributes:(NSMutableDictionary *)attributes
{
    NSString* backgroundColorString = [mergedStyles objectForKey:@"backgroundColor"];
    if (!backgroundColorString) {
        return;
    }
    
    UIColor* backgroundColor = [_colorParsing colorFromString:backgroundColorString];
    [attributes setObject:backgroundColor forKey:NSBackgroundColorAttributeName];
}

#pragma mark - Subtitle observer

- (void)subtitleAvailabilityChanged:(NSNumber*)available
{
}

- (void)subtitleActivationChanged:(NSNumber*)active
{
}

- (void)styleDictionaryUpdated:(NSDictionary*)styleDictionary baseStyleKey:(NSString*)baseStyleKey
{
    self.styleDictionary = styleDictionary;
    self.baseStyleKey = baseStyleKey;
}

- (void)subtitlesUpdated:(NSArray<BBCSMPSubtitle*>*)subtitles
{
    [self setSubtitles:subtitles];
}

#pragma mark - BBCSMPSubtitleScene

- (void)showSubtitles
{
    self.hidden = NO;
}

- (void)hideSubtitles
{
    self.hidden = YES;
}

@end
