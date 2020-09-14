//
//  BBCSMPUserInteractionEvent.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 24/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPUserInteractionEvent <NSObject>

- (NSString*)counterName;
- (NSString*)actionType;
- (NSString*)actionName;
- (NSDictionary*)labels;

@end
