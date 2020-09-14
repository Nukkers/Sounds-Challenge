//
//  BBCSMPStateObservable.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 12/06/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPUnpreparedStateListener;

@protocol BBCSMPStateObservable <NSObject>

- (void)addUnpreparedStateListener:(id<BBCSMPUnpreparedStateListener>)unpreparedStateListener;

@end

NS_ASSUME_NONNULL_END
