//
//  BBCSMPSystemSuspension.h
//  SMP
//
//  Created by Matt Mould on 29/11/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(SystemSuspensionListener)
@protocol BBCSMPSystemSuspensionListener
-(void)systemSuspended;
@end

NS_SWIFT_NAME(SystemSuspension)
@protocol BBCSMPSystemSuspension
-(void)addSystemSuspensionListener:(id<BBCSMPSystemSuspensionListener>) listener NS_SWIFT_NAME(add(listener:));
@end

NS_ASSUME_NONNULL_END
