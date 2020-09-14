//
//  BBCSMPDuration.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 26/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBCSMPDuration : NSObject

@property (nonatomic, readonly) NSTimeInterval seconds;

+ (instancetype)duration:(NSTimeInterval)seconds NS_SWIFT_NAME(duration(seconds:));
- (instancetype)initWithSeconds:(NSTimeInterval)seconds;

@end
