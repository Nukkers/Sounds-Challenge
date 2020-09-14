//
//  BBCSMPAccessibilityIndex.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 16/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAccessibilityIndex.h"

@interface BBCSMPAccessibilityIndex ()

@property (nonatomic, strong) NSMutableDictionary<NSNumber*, BBCSMPAccessibilityTerm*>* termsStorage;
@property (nonatomic, strong) NSMutableDictionary<NSNumber*, NSString*>* announcementsStorage;

@end

#pragma mark -

@implementation BBCSMPAccessibilityIndex

#pragma mark Overrides

- (instancetype)init
{
    self = [super init];
    if (self) {
        _termsStorage = [NSMutableDictionary new];
        _announcementsStorage = [NSMutableDictionary new];

        [self initializeDefaultTerms];
        [self initializeDefaultAnnouncements];
    }

    return self;
}

- (void)initializeDefaultTerms
{
    [self setLabel:@"Subtitles" forAccessibilityElement:BBCSMPAccessibilityElementSubtitlesEnabled];
    [self setHint:@"Double tap to hide subtitles." forAccessibilityElement:BBCSMPAccessibilityElementSubtitlesEnabled];

    [self setLabel:@"Subtitles" forAccessibilityElement:BBCSMPAccessibilityElementSubtitlesDisabled];
    [self setHint:@"Double tap to show subtitles." forAccessibilityElement:BBCSMPAccessibilityElementSubtitlesDisabled];

    [self setLabel:@"Player" forAccessibilityElement:BBCSMPAccessibilityElementShowPlaybackControls];
    [self setHint:@"Double tap to show controls." forAccessibilityElement:BBCSMPAccessibilityElementShowPlaybackControls];

    [self setLabel:@"Player" forAccessibilityElement:BBCSMPAccessibilityElementHidePlaybackControls];
    [self setHint:@"Double tap to hide controls." forAccessibilityElement:BBCSMPAccessibilityElementHidePlaybackControls];
    
    [self setLabel:@"Play" forAccessibilityElement:BBCSMPAccessibilityElementPlayButton];
    [self setHint:@"Double tap to play." forAccessibilityElement:BBCSMPAccessibilityElementPlayButton];
    
    [self setLabel:@"Pause" forAccessibilityElement:BBCSMPAccessibilityElementPauseButton];
    [self setHint:@"Double tap to pause." forAccessibilityElement:BBCSMPAccessibilityElementPauseButton];
    
    [self setLabel:@"Stop" forAccessibilityElement:BBCSMPAccessibilityElementStopButton];
    [self setHint:@"Double tap to stop." forAccessibilityElement:BBCSMPAccessibilityElementStopButton];
    
    [self setLabel:@"Display fullscreen" forAccessibilityElement:BBCSMPAccessibilityElementEnterFullscreenButton];
    [self setHint:@"Double tap to display fullscreen." forAccessibilityElement:BBCSMPAccessibilityElementEnterFullscreenButton];
    
    [self setLabel:@"Leave fullscreen" forAccessibilityElement:BBCSMPAccessibilityElementLeaveFullscreenButton];
    [self setHint:@"Double tap to leave fullscreen." forAccessibilityElement:BBCSMPAccessibilityElementLeaveFullscreenButton];
    
    [self setLabel:@"Dismiss player" forAccessibilityElement:BBCSMPAccessibilityElementDismissPlayerButton];
    [self setHint:@"Double tap to dismiss the player." forAccessibilityElement:BBCSMPAccessibilityElementDismissPlayerButton];
    
    [self setLabel:@"Display picture in picture" forAccessibilityElement:BBCSMPAccessibilityElementEnterPictureInPictureButton];
    [self setHint:@"Double tap to display picture in picture." forAccessibilityElement:BBCSMPAccessibilityElementEnterPictureInPictureButton];
    
    [self setLabel:@"Leave picture in picture" forAccessibilityElement:BBCSMPAccessibilityElementLeavePictureInPictureButton];
    [self setHint:@"Double tap to leave picture in picture." forAccessibilityElement:BBCSMPAccessibilityElementLeavePictureInPictureButton];
    
    [self setLabel:@"Seek position" forAccessibilityElement:BBCSMPAccessibilityElementScrubberSeekPosition];
    
    [self setLabel:@"Live" forAccessibilityElement:BBCSMPAccessibilityElementLiveIndicator];
}

- (void)initializeDefaultAnnouncements
{
    [self setAnnouncement:@"Content is buffering." forEvent:BBCSMPAccessibilityEventPlayerBuffering];
    [self setAnnouncement:@"Content is still buffering." forEvent:BBCSMPAccessibilityEventPlayerBufferingForExtendedPeriod];
    [self setAnnouncement:@"Playback started." forEvent:BBCSMPAccessibilityEventPlaybackStarted];
    [self setAnnouncement:@"Playback paused." forEvent:BBCSMPAccessibilityEventPlaybackPaused];
    [self setAnnouncement:@"Playback finished." forEvent:BBCSMPAccessibilityEventPlaybackEnded];
    [self setAnnouncement:@"Playback stopped." forEvent:BBCSMPAccessibilityEventPlaybackStopped];
}

#pragma mark Public

- (NSArray<BBCSMPAccessibilityTerm*>*)terms
{
    return _termsStorage.allValues;
}

- (BBCSMPAccessibilityTerm*)termForAccessibilityElement:(BBCSMPAccessibilityElement)element
{
    BBCSMPAccessibilityTerm* term = _termsStorage[@(element)];
    if (term) {
        term = [term copy];
    }
    else {
        term = [BBCSMPAccessibilityTerm new];
        [self setTerm:term forAccessibilityElement:element];
    }

    return term;
}

- (void)setTerm:(BBCSMPAccessibilityTerm*)term forAccessibilityElement:(BBCSMPAccessibilityElement)element;
{
    if (term) {
        _termsStorage[@(element)] = term;
    }
}

- (void)setAnnouncement:(NSString*)announcement forEvent:(BBCSMPAccessibilityEvent)event
{
    _announcementsStorage[@(event)] = [announcement copy];
}

- (NSString*)announcementForEvent:(BBCSMPAccessibilityEvent)event
{
    return _announcementsStorage[@(event)];
}

#pragma mark NSCopying

- (id)copyWithZone:(NSZone*)zone
{
    BBCSMPAccessibilityIndex* copy = [[[self class] allocWithZone:zone] init];
    copy.termsStorage = [_termsStorage copy];
    return copy;
}

@end

#pragma mark -

@implementation BBCSMPAccessibilityIndex (Convenience)

- (void)setLabel:(NSString*)label forAccessibilityElement:(BBCSMPAccessibilityElement)element
{
    BBCSMPAccessibilityTerm* term = [self termForAccessibilityElement:element];
    term.label = label;
    [self setTerm:term forAccessibilityElement:element];
}

- (nullable NSString*)labelForAccessibilityElement:(BBCSMPAccessibilityElement)element
{
    return [self termForAccessibilityElement:element].label;
}

- (void)setHint:(NSString*)hint forAccessibilityElement:(BBCSMPAccessibilityElement)element
{
    BBCSMPAccessibilityTerm* term = [self termForAccessibilityElement:element];
    term.hint = hint;
    [self setTerm:term forAccessibilityElement:element];
}

- (nullable NSString*)hintForAccessibilityElement:(BBCSMPAccessibilityElement)element
{
    return [self termForAccessibilityElement:element].hint;
}

@end

#pragma mark -

@implementation BBCSMPAccessibilityTerm

#pragma mark NSCopying

- (id)copyWithZone:(NSZone*)zone
{
    BBCSMPAccessibilityTerm* copy = [[[self class] alloc] init];
    copy.label = [_label copy];
    copy.hint = [_hint copy];

    return copy;
}

@end
