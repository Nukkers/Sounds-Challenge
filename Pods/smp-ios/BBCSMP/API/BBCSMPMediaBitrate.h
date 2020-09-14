//
//  BBCSMPMediaBitrate.h
//  Pods
//
//  Created by Richard Gilpin on 21/03/2018.
//

#import <Foundation/Foundation.h>

@interface BBCSMPMediaBitrate : NSObject

@property (nonatomic, assign) double mediaBitrate;

+ (instancetype)mediaBitrateWithBitrate:(double)mediaBitrate;
- (instancetype)initWithBitrate:(double)bitrate;

@end
