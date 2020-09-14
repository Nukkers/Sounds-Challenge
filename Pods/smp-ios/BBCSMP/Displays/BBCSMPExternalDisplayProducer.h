//
//  BBCSMPExternalDisplayProducer.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 19/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPDisplayCoordinatorProtocol;

@protocol BBCSMPExternalDisplayProducer <NSObject>
@required

@property (nonatomic, strong, nullable) id<BBCSMPDisplayCoordinatorProtocol> coordinator;

@end
