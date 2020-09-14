//
//  BBCSMPTimeFormatter.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 22/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPDuration.h"
#import "BBCSMPTime.h"
#import "BBCSMPTimeFormatterProtocol.h"

@interface BBCSMPTimeFormatter : NSObject <BBCSMPTimeFormatterProtocol>

@property (nonatomic, assign) BOOL showLeadingZero;

- (NSString*)stringFromTime:(BBCSMPTime*)time;
- (NSString*)stringFromDuration:(BBCSMPDuration*)duration;
- (NSString*)stringFromTimeInterval:(NSTimeInterval)seconds;

- (NSString*)readableStringFromTime:(BBCSMPTime*)time;
- (NSString*)readableStringFromDuration:(BBCSMPDuration*)duration;
- (NSString*)readableStringFromTimeInterval:(NSTimeInterval)seconds;

@end
