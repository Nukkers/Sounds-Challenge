//
//  BBCSMPUnpreparedStateListener.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 12/06/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(UnpreparedStateListener)
@protocol BBCSMPUnpreparedStateListener <NSObject>
@required

- (void)playerDidEnterUnpreparedState;

@end
