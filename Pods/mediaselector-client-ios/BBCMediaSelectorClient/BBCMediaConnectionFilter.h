//
//  BBCMediaConnectionFilter.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 28/09/2016.
//  Copyright © 2016 Michael Emmens. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MediaConnectionFilter)
@interface BBCMediaConnectionFilter : NSObject

@property (readonly) NSDictionary<NSString*, NSSet<NSString *>*>* requiredFilters;

+ (instancetype)filter;
+ (instancetype)filterWithFilter:(BBCMediaConnectionFilter *)filter;

- (instancetype)withRequiredTransferFormats:(NSArray<NSString *> *)requiredTransferFormats NS_SWIFT_NAME(with(requiredTransferFormats:));
- (instancetype)withRequiredProtocols:(NSArray<NSString *> *)requiredProtocols NS_SWIFT_NAME(with(requiredProtocols:));
- (instancetype)withRequiredSuppliers:(NSArray<NSString *> *)requiredSuppliers NS_SWIFT_NAME(with(requiredSuppliers:)); // Note - probably not a good idea to filter on supplier strings as they're liable to change between MS5 and MS6

@end

NS_ASSUME_NONNULL_END
