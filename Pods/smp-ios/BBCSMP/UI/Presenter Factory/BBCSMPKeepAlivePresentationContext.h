//
//  BBCSMPKeepAlivePresentationContext.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 25/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

@class BBCSMPPresentationContext;
@protocol BBCSMPPresenter;
@protocol BBCSMPPlugin;

@interface BBCSMPKeepAlivePresentationContext : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithPresentationContext:(BBCSMPPresentationContext *)presentationContext presenters:(NSArray<id<BBCSMPPresenter>> *)presenters plugins:(NSArray<id<BBCSMPPlugin>> *)plugins NS_DESIGNATED_INITIALIZER;

@end
