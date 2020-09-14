//
//  BBCSMPSubtitleChunk.h
//  BBCSMP
//
//  Created by Michael Emmens on 09/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

@interface BBCSMPSubtitleChunk : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, strong, readonly) NSString* text;
@property (nonatomic, strong, readonly) NSDictionary* styleDictionary;

- (instancetype)initWithText:(NSString*)text styleDictionary:(NSDictionary*)styleDictionary NS_DESIGNATED_INITIALIZER;
- (void)modifyText:(NSString*)text;

@end
