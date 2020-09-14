//
//  BBCSMPRemoteCommandCenter.h
//  BBCSMP
//
//  Created by Richard Gilpin on 07/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPRemoteCommandCenter <NSObject>
@required

- (void)addPauseTarget:(id<NSObject>)target action:(SEL)action;
- (void)removePauseTarget:(id<NSObject>)target;

- (void)addPlayTarget:(id<NSObject>)target action:(SEL)action;
- (void)removePlayTarget:(id<NSObject>)target;

- (void)addTogglePlayPauseTarget:(id<NSObject>)target action:(SEL)action;
- (void)removeTogglePlayPauseTarget:(id<NSObject>)target;

@end

NS_ASSUME_NONNULL_END
