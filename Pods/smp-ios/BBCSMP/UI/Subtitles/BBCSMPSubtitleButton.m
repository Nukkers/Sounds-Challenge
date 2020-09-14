//
//  BBCSMPSubtitleButton.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 19/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPSubtitleButton.h"
#import "BBCSMPAccessibilityIndex.h"
#import "BBCSMPBrandingIcons.h"
#import "BBCSMPSubtitlesIcon.h"

@implementation BBCSMPSubtitleButton

#pragma mark Initialization

+ (instancetype)subtitleButton
{
    return [[[self class] alloc] initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    _subtitlesIcon = [BBCSMPSubtitlesIcon new];
}

- (void)setBrand:(BBCSMPBrand*)brand
{
    [super setBrand:brand];

    id<BBCSMPIcon> subtitlesIcon = brand.icons.subtitlesIcon;
    if (subtitlesIcon) {
        self.subtitlesIcon = subtitlesIcon;
    }
}

#pragma mark Accessibility

- (BBCSMPAccessibilityElement)accessibilityIndexElement
{
    return self.selected ? BBCSMPAccessibilityElementSubtitlesEnabled : BBCSMPAccessibilityElementSubtitlesDisabled;
}

- (NSString*)accessibilityIdentifier
{
    return @"smp_subtitles_button";
}

- (NSString*)accessibilityLabel
{
    return [self.brand.accessibilityIndex labelForAccessibilityElement:self.accessibilityIndexElement];
}

- (NSString*)accessibilityHint
{
    return [self.brand.accessibilityIndex hintForAccessibilityElement:self.accessibilityIndexElement];
}

#pragma mark Overrides

- (void)drawIcon
{
    CGRect iconFrame = CGRectMake(12, 11, 24, 24);

    [_subtitlesIcon setColour:self.colour];
    [_subtitlesIcon drawInFrame:iconFrame];
}

@end
