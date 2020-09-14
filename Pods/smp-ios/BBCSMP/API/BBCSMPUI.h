//
//  BBCSMPUI.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 11/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPVideoSurface;
@protocol BBCSMPUIBuilder;

@protocol BBCSMPUI <NSObject>
@required

- (id<BBCSMPUIBuilder>)buildUserInterface;
- (void)setContentFit;
- (void)setContentFill;

@end

NS_ASSUME_NONNULL_END
