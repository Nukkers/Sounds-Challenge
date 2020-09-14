//
//  AVAudioSessionProtocol.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 12/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AVAudioSessionRouteDescription;

NS_ASSUME_NONNULL_BEGIN

@protocol AVAudioSessionProtocol <NSObject>
@required

@property (readonly) AVAudioSessionRouteDescription* currentRoute;

- (BOOL)setCategory:(NSString*)category error:(NSError**)outError;
- (BOOL)setActive:(BOOL)active error:(NSError**)outError;
- (BOOL)setCategory:(NSString *)category mode:(NSString *)mode routeSharingPolicy:(NSUInteger)policy options:(NSUInteger)options error:(NSError **)outError API_AVAILABLE(ios(11.0));

@end

NS_ASSUME_NONNULL_END
