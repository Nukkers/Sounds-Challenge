//
//  BBCSMPSubtitleFetcherFactory.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 07/08/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPSubtitleFetcher;
@protocol BBCSMPItem;

@interface BBCSMPSubtitleFetcherFactory : NSObject

+ (id<BBCSMPSubtitleFetcher>)subtitleFetcherForItem:(id<BBCSMPItem>)item;

@end
