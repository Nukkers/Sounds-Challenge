//
//  BBCSMPDecoderFactory.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 07/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPDecoder;

@protocol BBCSMPDecoderFactory <NSObject>
@required

- (id<BBCSMPDecoder>)createDecoder;

@end

NS_ASSUME_NONNULL_END
