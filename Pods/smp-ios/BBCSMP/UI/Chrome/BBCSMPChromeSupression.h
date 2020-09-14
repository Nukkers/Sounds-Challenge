//
//  BBCSMPChromeSupression.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 31/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPChromeSupression <NSObject>
@required

- (void)suppressControlAutohideForReason:(NSString*)reason;
- (void)stopSuppressingControlAutohideForReason:(NSString*)reason;

@end

NS_ASSUME_NONNULL_END
