//
//  BBCSMPTitlePresenter.m
//  SMP
//
//  Created by Michael Hamer on 24/12/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

#import "BBCSMPTitlePresenter.h"
#import "BBCSMPTitleBarScene.h"
#import "BBCSMPTitleSubtitleScene.h"
#import "BBCSMPUIConfiguration.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPView.h"

@interface BBCSMPTitlePresenter () <BBCSMPTitleTruncationDelegate>
@property (nonatomic, weak) id<BBCSMPTitleBarScene> titleBarScene;
@property (nonatomic, weak) id<BBCSMPTitleSubtitleScene> titleSubitleScene;
@property (nonatomic) BBCSMPTitleBarCloseButtonAlignment closeButtonAlignment;
@end

@implementation BBCSMPTitlePresenter
#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if (self) {
        _titleBarScene = context.view.scenes.titleBarScene;
        _titleSubitleScene = context.view.scenes.titleSubtitleScene;
        _titleBarScene.truncationDelegate = self;
        _closeButtonAlignment = context.configuration.closeButtonAlignment;
    }

    return self;
}

- (void)setupCloseButton
{
    if (_closeButtonAlignment == BBCSMPTitleBarCloseButtonAlignmentLeft) {
         [_titleBarScene setUpLeftAlignedCloseButton];
    } else {
         [_titleBarScene setUpRightAlignedCloseButton];
    }
}

-(void)checkForTruncationWithNewWidth:(CGFloat)width
{
    [self setupCloseButton];
    
    if (width < [_titleSubitleScene largestTitleWidth]) {
        [_titleSubitleScene setLabelAlignment:NSTextAlignmentLeft];
        [_titleBarScene setUpTitleRestricted:_closeButtonAlignment];
    } else {
        [_titleSubitleScene setLabelAlignment:NSTextAlignmentCenter];
        [_titleBarScene setUpTitleNotRestricted];

    }
}

@end
