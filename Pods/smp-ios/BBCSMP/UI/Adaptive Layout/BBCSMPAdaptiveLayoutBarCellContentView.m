//
//  BBCSMPAdaptiveLayoutBarCellContentView.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 28/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPAdaptiveLayoutBarCellContentView.h"

@implementation BBCSMPAdaptiveLayoutBarCellContentView

#pragma mark Overrides

- (void)willRemoveSubview:(UIView *)subview
{
    [super willRemoveSubview:subview];
    [_contentViewDelegate contentView:self willRemoveSubview:subview];
}

@end
