//
//  BBCSMPArtworkView.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 02/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPContentPlaceholderScene.h"
#import <UIKit/UIKit.h>

@protocol BBCSMPArtworkViewLayoutListener

- (void)frameDidChange:(CGRect)frame;

@end

@interface BBCSMPArtworkView : UIImageView <BBCSMPContentPlaceholderScene>

@property (nonatomic, weak) id<BBCSMPArtworkViewLayoutListener> layoutListener;

@end
