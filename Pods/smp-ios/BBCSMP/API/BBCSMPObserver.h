//
//  BBCSMPObserver.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 28/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BBCSMPObserverType) {
    BBCSMPObserverTypeDefault = 0,
    BBCSMPObserverTypeUI
};

@protocol BBCSMPObserver <NSObject>

@optional

// Assumed to be BBCSMPObserverTypeDefault if not implemented
- (BBCSMPObserverType)observerType;

@end
