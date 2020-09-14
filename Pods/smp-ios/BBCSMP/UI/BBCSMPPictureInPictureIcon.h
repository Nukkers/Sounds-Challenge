//
//  BBCSMPPictureInPictureIcon.h
//  BBCSMP
//
//  Created by Al Priest on 01/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPIcon.h"

@class UITraitCollection;
@class UIImage;

@interface BBCSMPPictureInPictureIcon : NSObject <BBCSMPIcon>

@property (nonatomic, strong, nonnull) UIColor* colour;
@property (nonatomic, strong, nonnull) UITraitCollection* traitCollection;
@property (nonatomic, strong, readonly, nonnull) UIImage* image;

@end

@interface BBCSMPEnablePictureInPictureIcon : BBCSMPPictureInPictureIcon
@end

@interface BBCSMPDisablePictureInPictureIcon : BBCSMPPictureInPictureIcon
@end
