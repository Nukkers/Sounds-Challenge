//
//  BBCSMPSubtitleObserver.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 18/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPObserver.h"

@class BBCSMPSubtitle;

@protocol BBCSMPSubtitleObserver <BBCSMPObserver>

- (void)subtitleAvailabilityChanged:(NSNumber*)available;
- (void)subtitleActivationChanged:(NSNumber*)active;
- (void)styleDictionaryUpdated:(NSDictionary*)styleDictionary baseStyleKey:(NSString*)baseStyleKey NS_SWIFT_NAME(styleDictionaryChanged(_:_:));
- (void)subtitlesUpdated:(NSArray<BBCSMPSubtitle*>*)subtitles;

@end
