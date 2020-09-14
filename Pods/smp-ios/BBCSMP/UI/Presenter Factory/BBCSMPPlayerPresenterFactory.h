//
//  BBCSMPPlayerPresenterFactory.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 09/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPPresentationContext;

@protocol BBCSMPPlayerPresenterFactory <NSObject>
@required

- (void)buildPresentersWithContext:(BBCSMPPresentationContext *)context;

@end

NS_ASSUME_NONNULL_END
