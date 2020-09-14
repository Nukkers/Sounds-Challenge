//
//  BBCSMPStaticURLArtworkURLProvider.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 02/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPArtworkURLProvider.h"

@interface BBCSMPStaticURLArtworkURLProvider : NSObject <BBCSMPArtworkURLProvider>

- (instancetype)initWithURL:(NSString*)URL;

@end
