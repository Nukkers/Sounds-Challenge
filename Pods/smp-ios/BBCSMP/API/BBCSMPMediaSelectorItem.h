//
//  BBCSMPMediaSelectorItem.h
//  BBCSMP
//
//  Created by Michael Emmens on 31/07/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPItem.h"

@interface BBCSMPMediaSelectorItem : NSObject <BBCSMPItem>

@property (nonatomic, strong) BBCSMPItemMetadata* metadata;
@property (nonatomic, strong) NSURL* mediaURL;
@property (nonatomic, strong) NSURL* subtitleURL;
@property (nonatomic, assign) BOOL allowsAirplay;
@property (nonatomic, assign) BOOL allowsExternalDisplay;
@property (nonatomic, assign) BBCSMPBackgroundAction actionOnBackground;
@property (nonatomic, assign) NSTimeInterval playOffset;

- (BOOL) isPlayable;

@end
