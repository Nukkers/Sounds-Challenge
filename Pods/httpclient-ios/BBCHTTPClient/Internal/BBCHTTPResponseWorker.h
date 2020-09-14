//
//  BBCHTTPResponseWorker.h
//  BBCHTTPClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 19/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCHTTPResponseWorker <NSObject>
@required

- (void)perform:(nonnull void(^)(void))work;

@end
