//
//  BBCSMPSubtitleRegion.h
//  BBCSMP
//
//  Created by Al Priest on 15/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <CoreGraphics/CGGeometry.h>
#import <Foundation/Foundation.h>

@interface BBCSMPSubtitleRegion : NSObject

@property (nonatomic, strong) NSString* regionId;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGPoint extent;
@property (nonatomic, strong) NSString* displayAlign;

- (id)init NS_UNAVAILABLE;
- (instancetype)initWithAttributes:(NSDictionary*)attributes NS_DESIGNATED_INITIALIZER;
- (BOOL)hasPositionalSubtitles;

@end
