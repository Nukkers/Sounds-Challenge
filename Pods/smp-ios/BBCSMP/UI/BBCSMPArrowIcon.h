//
//  BBCSMPArrowIcon.h
//  BBCSMP
//
//  Created by Thomas Sherwood on 23/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPIcon.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BBCSMPArrowDirection) {
    BBCSMPArrowDirectionNorth,
    BBCSMPArrowDirectionNorthEast,
    BBCSMPArrowDirectionSouthEast,
    BBCSMPArrowDirectionSouthWest,
    BBCSMPArrowDirectionNorthWest
};

@interface BBCSMPArrowIcon : NSObject <BBCSMPIcon>

@property (nonatomic, strong) UIColor* colour;
@property (nonatomic, assign) CGFloat headHeightSizeProportion;
@property (nonatomic, assign) CGFloat stemWidthSizeProportion;
@property (nonatomic, assign) BBCSMPArrowDirection direction;

+ (instancetype)arrowWithDirection:(BBCSMPArrowDirection)direction;
+ (instancetype)northEastArrow;
+ (instancetype)northWestArrow;
+ (instancetype)sorthEastArrow;
+ (instancetype)southWestArrow;

@end

NS_ASSUME_NONNULL_END
