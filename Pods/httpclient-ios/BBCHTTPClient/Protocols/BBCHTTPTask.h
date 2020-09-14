//
//  BBCHTTPTask.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 05/10/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

@import Foundation;

NS_SWIFT_NAME(Task)
@protocol BBCHTTPTask <NSProgressReporting>

- (void)cancel;

@end
