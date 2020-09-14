//
//  BBCSMPAVPlayerPictureInPictureAdapterDelegate.h
//  Pods
//
//  Created by Al Priest on 04/04/2016.
//
//

#import <Foundation/Foundation.h>

@protocol BBCSMPAVPlayerPictureInPictureAdapterDelegate <NSObject>

- (void)pictureInPictureControllerDidStopPictureInPicture;
- (void)pictureInPictureControllerWillStartPictureInPicture;

@end
