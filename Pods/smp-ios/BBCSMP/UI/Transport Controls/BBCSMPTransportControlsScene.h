//
//  BBCSMPTransportControlsScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 24/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPTransportControlsScene;

@protocol BBCSMPTransportControlsInteractivityDelegate <NSObject>
@required

- (void)transportControlsSceneInteractionsDidBegin:(id<BBCSMPTransportControlsScene>)transportControlsScene;
- (void)transportControlsSceneInteractionsDidFinish:(id<BBCSMPTransportControlsScene>)transportControlsScene;

@end
 
@protocol BBCSMPTransportControlsViewSpaceDelegate <NSObject>
@required

- (void)spaceRestricted;
- (void)spaceAvailable;

@end

@protocol BBCSMPTransportControlsScene <NSObject>
@required

@property (nonatomic, weak, nullable) id<BBCSMPTransportControlsInteractivityDelegate> interactivityDelegate;
@property (nonatomic, weak, nullable) id<BBCSMPTransportControlsViewSpaceDelegate> spaceDelegate;

- (void)show;
- (void)hide;

@end



NS_ASSUME_NONNULL_END
