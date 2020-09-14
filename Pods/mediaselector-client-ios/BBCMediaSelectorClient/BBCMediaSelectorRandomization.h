//
//  BBCMediaSelectorRandomization.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 04/02/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

@import Foundation;

NS_SWIFT_NAME(MediaSelectorRandomization)
@protocol BBCMediaSelectorRandomization

- (NSUInteger)generateRandomPercentage;

@end
