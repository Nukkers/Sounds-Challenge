//
//  BBCSMPAccessibilityIndex.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 16/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPAccessibilityTerm;

typedef NS_ENUM(NSUInteger, BBCSMPAccessibilityElement) {
    BBCSMPAccessibilityElementSubtitlesEnabled,
    BBCSMPAccessibilityElementSubtitlesDisabled,
    BBCSMPAccessibilityElementShowPlaybackControls,
    BBCSMPAccessibilityElementHidePlaybackControls,
    BBCSMPAccessibilityElementPlayButton,
    BBCSMPAccessibilityElementPauseButton,
    BBCSMPAccessibilityElementStopButton,
    BBCSMPAccessibilityElementEnterFullscreenButton,
    BBCSMPAccessibilityElementLeaveFullscreenButton,
    BBCSMPAccessibilityElementDismissPlayerButton,
    BBCSMPAccessibilityElementEnterPictureInPictureButton,
    BBCSMPAccessibilityElementLeavePictureInPictureButton,
    BBCSMPAccessibilityElementScrubberSeekPosition,
    BBCSMPAccessibilityElementLiveIndicator
};

typedef NS_ENUM(NSUInteger, BBCSMPAccessibilityEvent) {
    BBCSMPAccessibilityEventPlayerBuffering,
    BBCSMPAccessibilityEventPlayerBufferingForExtendedPeriod,
    BBCSMPAccessibilityEventPlaybackStarted,
    BBCSMPAccessibilityEventPlaybackPaused,
    BBCSMPAccessibilityEventPlaybackEnded,
    BBCSMPAccessibilityEventPlaybackStopped
};

@interface BBCSMPAccessibilityIndex : NSObject <NSCopying>

@property (nonatomic, strong, readonly) NSArray<BBCSMPAccessibilityTerm*>* terms;

- (BBCSMPAccessibilityTerm*)termForAccessibilityElement:(BBCSMPAccessibilityElement)element;
- (void)setTerm:(BBCSMPAccessibilityTerm*)term forAccessibilityElement:(BBCSMPAccessibilityElement)element NS_SWIFT_NAME(set(term:for:));

- (void)setAnnouncement:(NSString*)announcement forEvent:(BBCSMPAccessibilityEvent)event NS_SWIFT_NAME(set(announcement:for:));
- (nullable NSString*)announcementForEvent:(BBCSMPAccessibilityEvent)event;

@end

@interface BBCSMPAccessibilityIndex (Convenience)

- (void)setLabel:(NSString*)label forAccessibilityElement:(BBCSMPAccessibilityElement)element NS_SWIFT_NAME(set(label:for:));
- (nullable NSString*)labelForAccessibilityElement:(BBCSMPAccessibilityElement)element;
- (void)setHint:(NSString*)hint forAccessibilityElement:(BBCSMPAccessibilityElement)element NS_SWIFT_NAME(set(hint:for:));
- (nullable NSString*)hintForAccessibilityElement:(BBCSMPAccessibilityElement)element;

@end

@interface BBCSMPAccessibilityTerm : NSObject <NSCopying>

@property (nonatomic, copy, nullable) NSString* label;
@property (nonatomic, copy, nullable) NSString* hint;

@end

NS_ASSUME_NONNULL_END
