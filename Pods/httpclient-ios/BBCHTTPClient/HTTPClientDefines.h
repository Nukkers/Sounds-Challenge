//
//  HTTPClientDefines.h
//  BBCHTTPClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/10/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#ifndef HTTP_CLIENT_DEFINES
#define HTTP_CLIENT_DEFINES

#ifndef HTTP_CLIENT_UNAVAILABLE
#   define HTTP_CLIENT_UNAVAILABLE(msg) __attribute__((unavailable(msg)))
#endif

#ifndef HTTP_CLIENT_INIT_UNAVAILABLE
#   define HTTP_CLIENT_INIT_UNAVAILABLE - (instancetype)init NS_UNAVAILABLE;
#endif

#ifndef HTTP_CLIENT_DEPRECATED
#   define HTTP_CLIENT_DEPRECATED(msg) __attribute__((deprecated(msg)))
#endif

#endif
