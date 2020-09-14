//
//  BBCSMPBrandingIcons.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 11/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPIcon;

@interface BBCSMPBrandingIcons : NSObject

@property (nonatomic, strong) id<BBCSMPIcon> audioPlayIcon;
@property (nonatomic, strong) id<BBCSMPIcon> videoPlayIcon;
@property (nonatomic, strong) id<BBCSMPIcon> pauseIcon;
@property (nonatomic, strong) id<BBCSMPIcon> stopIcon;
@property (nonatomic, strong) id<BBCSMPIcon> subtitlesIcon;
@property (nonatomic, strong) id<BBCSMPIcon> enterPictureInPictureIcon;
@property (nonatomic, strong) id<BBCSMPIcon> exitPictureInPictureIcon;
@property (nonatomic, strong) id<BBCSMPIcon> enterFullscreenIcon;
@property (nonatomic, strong) id<BBCSMPIcon> leaveFullscreenIcon;
@property (nonatomic, strong) id<BBCSMPIcon> closePlayerIcon;

@end

NS_ASSUME_NONNULL_END
