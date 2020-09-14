//
//  BBCSMPMediaRetrievalType.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 24/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

typedef NS_ENUM(NSInteger, BBCSMPMediaRetrievalType) {
    BBCSMPMediaRetrievalTypeStream = 0,
    BBCSMPMediaRetrievalTypeDownload
};

extern NSString* NSStringFromBBCSMPMediaRetrievalType(BBCSMPMediaRetrievalType mediaRetrievalType);