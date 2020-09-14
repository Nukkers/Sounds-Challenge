//
//  BBCSMPScrubberView.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 15/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPBrandable.h"
#import "BBCSMPDuration.h"
#import "BBCSMPScrubberScene.h"
#import "BBCSMPTime.h"
#import "BBCSMPTimeRange.h"
#import <UIKit/UIKit.h>

@protocol BBCSMPScrubberViewDelegate <NSObject>

- (void)startedScrubbing;
- (void)scrubberScrubbedTo:(NSTimeInterval)position;
- (void)endedScrubbing;

@end

@interface BBCSMPScrubberView : UIControl <BBCSMPScrubberScene, BBCSMPBrandable>

@property (nonatomic, weak) id<BBCSMPScrubberViewDelegate> delegate;
@property (nonatomic, strong) BBCSMPTime* time;
@property (nonatomic, strong) BBCSMPDuration* duration;
@property (nonatomic, strong) BBCSMPTimeRange* seekableRange;

@end
