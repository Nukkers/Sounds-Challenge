//
//  BBCSMPResolvedContent.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 16/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPResolvedContent <NSObject>

@property (nonatomic, copy, readonly) NSURL *content;
@property (nonatomic, assign, readonly, getter=isNetworkResource) BOOL networkResource;

@end

NS_ASSUME_NONNULL_END
