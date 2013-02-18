//
//  CaculatorResource.m
//  dbm-mw-caculator
//
//  Created by Patrick Deng on 13-2-18.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorResource.h"

static SystemSoundID s_buttonClickSoundID;
static NSString* s_buttonClickSoundFilePath;

@implementation CaculatorResource

+(void) initialize
{
    s_buttonClickSoundFilePath = [[NSBundle mainBundle] pathForResource:@"button" ofType:@"wav"];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:s_buttonClickSoundFilePath], &s_buttonClickSoundID);
}

+(void) playButtonClickSound
{
    AudioServicesPlaySystemSound(s_buttonClickSoundID);
    
    //    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
