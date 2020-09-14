//
//  BBCSMPPresenter.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 04/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPPresentationContext.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPPresenter <NSObject>
@required

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context;

@end

NS_ASSUME_NONNULL_END
