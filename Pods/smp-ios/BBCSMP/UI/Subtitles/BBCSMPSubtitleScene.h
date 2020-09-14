//
//  BBCSMPSubtitleScene.h
//  BBCSMP
//
//  Created by Daniel Ellis on 21/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPSubtitle;

@protocol BBCSMPSubtitleScene <NSObject>
@required

- (void)showSubtitles;
- (void)hideSubtitles;
- (void)styleDictionaryUpdated:(NSDictionary*)styleDictionary baseStyleKey:(NSString*)baseStyleKey;
- (void)subtitlesUpdated:(NSArray<BBCSMPSubtitle *> *)subtitles;

@end

NS_ASSUME_NONNULL_END
