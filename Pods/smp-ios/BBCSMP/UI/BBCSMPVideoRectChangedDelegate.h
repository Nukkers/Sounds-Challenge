//
//  BBCSMPVideoRectChangedDelegate.h
//  BBCSMP
//
//  Created by Al Priest on 17/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBCSMPVideoRectChangedDelegate <NSObject>

- (void)videoRectUpdated:(CGRect)videoRect;

@end
