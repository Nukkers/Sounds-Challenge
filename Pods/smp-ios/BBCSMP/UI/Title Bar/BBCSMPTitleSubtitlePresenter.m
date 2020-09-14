//
//  BBCSMPTitleSubtitlePresenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 24/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPPreloadMetadataObserver.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPTitleSubtitlePresenter.h"
#import "BBCSMPTitleSubtitleScene.h"
#import "BBCSMPUIConfiguration.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPItemPreloadMetadata.h"

@interface BBCSMPTitleSubtitlePresenter () <BBCSMPPreloadMetadataObserver>
@end

#pragma mark -

@implementation BBCSMPTitleSubtitlePresenter {
    __weak id<BBCSMPTitleSubtitleScene> _titleSubtitleScene;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if (self) {
        _titleSubtitleScene = context.view.scenes.titleSubtitleScene;
        
        if ([context.configuration hideTitleBarLabels]) {
            [_titleSubtitleScene hide];
        } else  {
            [_titleSubtitleScene show];
        }
        
        [context.player addObserver:self];
    }

    return self;
}

#pragma mark BBCSMPPreloadMetadataObserver

- (void)preloadMetadataUpdated:(BBCSMPItemPreloadMetadata*)preloadMetadata
{
    [_titleSubtitleScene setTitle:preloadMetadata.title];
    [_titleSubtitleScene setSubtitle:preloadMetadata.subtitle];
    [_titleSubtitleScene setTitleSubtitleAccessibilityLabel:[self makeAccessibilityLabelFromPreloadMetadata:preloadMetadata]];
    
    if ([self shouldMakeHeadingAccessibleForPreloadMetadata:preloadMetadata]) {
        [_titleSubtitleScene becomeAccessible];
    }
    else {
        [_titleSubtitleScene resignAccessibilityInteraction];
    }
}

#pragma mark Private

- (NSString *)makeAccessibilityLabelFromPreloadMetadata:(BBCSMPItemPreloadMetadata *)preloadMetadata
{
    NSMutableArray *labelComponents = [NSMutableArray array];
    if(preloadMetadata.title) {
        [labelComponents addObject:preloadMetadata.title];
    }
    
    if(preloadMetadata.subtitle) {
        [labelComponents addObject:preloadMetadata.subtitle];
    }
    
    return [labelComponents componentsJoinedByString:@", "];
}

- (BOOL)shouldMakeHeadingAccessibleForPreloadMetadata:(BBCSMPItemPreloadMetadata *)preloadMetadata
{
    return preloadMetadata.title || preloadMetadata.subtitle;
}

@end
