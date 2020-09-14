//
//  BBCSMPLibraryUserAgentProvider.h
//  BBCSMP
//
//  Created by Al Priest on 03/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPUserAgentProvider.h"

@interface BBCSMPLibraryUserAgentProvider : NSObject <BBCSMPUserAgentProvider>

- (NSString*)userAgent;

@end
