//
//  BBCHTTPMethod.h
//  BBCHTTPClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 16/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString * BBCHTTPMethod NS_STRING_ENUM NS_SWIFT_NAME(HTTPMethod);

FOUNDATION_EXPORT BBCHTTPMethod const BBCHTTPMethodGET NS_SWIFT_NAME(get);
FOUNDATION_EXPORT BBCHTTPMethod const BBCHTTPMethodPUT NS_SWIFT_NAME(put);
FOUNDATION_EXPORT BBCHTTPMethod const BBCHTTPMethodPOST NS_SWIFT_NAME(post);
FOUNDATION_EXPORT BBCHTTPMethod const BBCHTTPMethodDELETE NS_SWIFT_NAME(delete);
FOUNDATION_EXPORT BBCHTTPMethod const BBCHTTPMethodHEAD NS_SWIFT_NAME(head);
FOUNDATION_EXPORT BBCHTTPMethod const BBCHTTPMethodOPTIONS NS_SWIFT_NAME(options);
FOUNDATION_EXPORT BBCHTTPMethod const BBCHTTPMethodTRACE NS_SWIFT_NAME(trace);
FOUNDATION_EXPORT BBCHTTPMethod const BBCHTTPMethodPATCH NS_SWIFT_NAME(patch);
FOUNDATION_EXPORT BBCHTTPMethod const BBCHTTPMethodCONNECT NS_SWIFT_NAME(connect);
