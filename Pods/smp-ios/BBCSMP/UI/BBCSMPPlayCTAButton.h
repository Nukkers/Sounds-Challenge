//
//  BBCSMPPlayCTAButton.h
//  BBCSMP
//
//  Created by Richard Price01 on 23/03/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAVType.h"
#import "BBCSMPButton.h"
#import "BBCSMPPlayCTAButtonScene.h"

@class BBCSMPDuration;

@interface BBCSMPPlayCTAButton : BBCSMPButton <BBCSMPPlayCTAButtonScene>

@property (nonatomic, assign) CGFloat iconSize;
@property (nonatomic, assign) BBCSMPAVType avType;
@property (nonatomic, strong) BBCSMPDuration* duration;

@end

