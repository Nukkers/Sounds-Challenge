//
//  BBCSMPSafeAreaGuideProviding.h
//  UI Tests Hosted
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/09/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <CoreGraphics/CGGeometry.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIGeometry.h>

NS_ASSUME_NONNULL_BEGIN

@class UIView;

@protocol BBCSMPSafeAreaGuideProviding <NSObject>
@required

@property (nonatomic, readonly) CGRect safeAreaGuideFrame;
@property (nonatomic, readonly) UIEdgeInsets titleBarContentInsets;

@end

@protocol BBCSMPSafeAreaGuideProvidingFactory <NSObject>
@required

- (id<BBCSMPSafeAreaGuideProviding>)createSafeAreaGuideProvidingWithView:(UIView *)view NS_SWIFT_NAME(makeSafeAreaGuideProviding(with:));

@end

NS_ASSUME_NONNULL_END
