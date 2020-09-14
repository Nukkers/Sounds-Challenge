//
//  BBCSMPPictureInPictureAdapter.h
//  BBCSMP
//
//  Created by Al Priest on 04/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPPictureInPictureAdapterDelegate <NSObject>

- (void)pictureInPictureAdapterDidStopPictureInPicture;
- (void)pictureInPictureAdapterWillStartPictureInPicture;

@end

@protocol BBCSMPPictureInPictureAdapter <NSObject>

@property (nonatomic, weak, nullable) id<BBCSMPPictureInPictureAdapterDelegate> delegate;
@property (nonatomic, assign, readonly, getter=isPictureInPictureActive) BOOL pictureInPictureActive;

- (BOOL)supportsPictureInPicture;
- (void)stopPictureInPicture;
- (void)startPictureInPicture;

@end
