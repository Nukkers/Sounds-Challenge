//
//  BBCSMPKeepAlivePresentationContext.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 25/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPKeepAlivePresentationContext.h"
#import "BBCSMPPresentationContext.h"
#import "BBCSMPNavigationCoordinator.h"

@implementation BBCSMPKeepAlivePresentationContext {
    BBCSMPPresentationContext *_presentationContext;
    NSArray<id<BBCSMPPresenter>> *_presenters;
    NSArray<id<BBCSMPPlugin>> *_plugins;
}

#pragma mark Deallocation

- (void)dealloc
{
    if(_presentationContext.presentationMode != BBCSMPPresentationModeFullscreenFromEmbedded) {
        [_presentationContext.navigationCoordinator teardown];
    }
}

#pragma mark Initialization

- (instancetype)initWithPresentationContext:(BBCSMPPresentationContext *)presentationContext
                                 presenters:(NSArray<id<BBCSMPPresenter>> *)presenters
                                    plugins:(NSArray<id<BBCSMPPlugin>> *)plugins
{
    self = [super init];
    if(self) {
        _presentationContext = presentationContext;
        _presenters = presenters;
        _plugins = plugins;
    }
    
    return self;
}

@end
