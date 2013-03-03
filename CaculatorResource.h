//
//  CaculatorResource.h
//  dbm-mw-caculator
//
//  Created by Patrick Deng on 13-2-18.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface CaculatorResource : NSObject

+(void) playCaculatorButtonClickSound;
+(void) playHelpButtonClickSound;
+(void) playHistoryButtonClickSound;
+(void) playSaveButtonClickSound;
+(void) playSwitchButtonClickSound;
+(void) playFormatButtonClickSound;
+(NSString*) localStoreFileFullName;

@end
