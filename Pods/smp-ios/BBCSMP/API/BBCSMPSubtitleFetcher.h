//
//  BBCSMPSubtitleFetcher.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 07/08/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BBCSMPSubtitleFetchSuccess)(NSData* subtitleData); // Should pass in data for TTML subtitles since that's what the player can parse
typedef void (^BBCSMPSubtitleFetchFailure)(NSError* subtitleError);

@protocol BBCSMPSubtitleFetcher

- (void)fetchSubtitles:(BBCSMPSubtitleFetchSuccess)success failure:(BBCSMPSubtitleFetchFailure)failure NS_SWIFT_NAME(fetchSubtitles(success:failure:));

@end
