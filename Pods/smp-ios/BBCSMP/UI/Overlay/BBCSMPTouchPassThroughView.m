//
//  BBCSMPTouchPassThroughView.m
//  BBCSMP
//
//  Created by Daniel Ellis on 07/10/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPTouchPassThroughView.h"

@implementation BBCSMPTouchPassThroughView

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([super pointInside:point withEvent:event]) {
        for (UIView *subview in self.subviews) {
            if (!subview.hidden && [subview pointInside:[self convertPoint:point toView:subview] withEvent:event]) {
                return YES;
            }
        }
    }
    return NO;
}

@end
