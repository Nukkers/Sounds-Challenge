//
//  MediaSelectorDefines.h
//  BBCMediaSelectorClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 07/11/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#ifndef MEDIA_SELECTOR_DEFINES
#define MEDIA_SELECTOR_DEFINES

#ifndef MEDIA_SELECTOR_INIT_UNAVAILABLE
#   define MEDIA_SELECTOR_INIT_UNAVAILABLE - (instancetype)init __attribute__((unavailable));
#endif

#ifndef MEDIA_SELECTOR_UNAVAILABLE
#   define MEDIA_SELECTOR_UNAVAILABLE(msg) __attribute__((unavailable(msg)))
#endif

#ifndef MEDIA_SELECTOR_DEPRECATED
#   define MEDIA_SELECTOR_DEPRECATED(msg) __attribute__((deprecated(msg)))
#endif

#endif
