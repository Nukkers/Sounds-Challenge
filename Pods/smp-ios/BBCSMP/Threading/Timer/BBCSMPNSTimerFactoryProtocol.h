//
//  BBCSMPNSTimerFactoryProtocol.h
//  BBCSMP
//
//  Created by Flavius Mester on 30/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NSTimerProtocol;

@protocol BBCSMPNSTimerFactoryProtocol <NSObject>

- (id<NSTimerProtocol>)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

@end

NS_ASSUME_NONNULL_END
