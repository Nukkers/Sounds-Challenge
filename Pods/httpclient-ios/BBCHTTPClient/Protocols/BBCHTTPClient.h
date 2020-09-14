//
//  BBCHTTPClient.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 07/09/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCHTTPRequest.h"
#import "BBCHTTPTask.h"
#import "BBCHTTPResponse.h"
#import "BBCHTTPError.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(ClientSuccess)
typedef void(^BBCHTTPClientSuccess)(id<BBCHTTPRequest> _Nonnull request, id<BBCHTTPResponse> _Nullable response);

NS_SWIFT_NAME(ClientFailure)
typedef void(^BBCHTTPClientFailure)(id<BBCHTTPRequest> _Nonnull request, id<BBCHTTPError> _Nullable error);

NS_SWIFT_NAME(Client)
@protocol BBCHTTPClient <NSObject>

- (id<BBCHTTPTask>)sendRequest:(id<BBCHTTPRequest>)request
                       success:(BBCHTTPClientSuccess)success
                       failure:(BBCHTTPClientFailure)failure;

@end

NS_ASSUME_NONNULL_END
