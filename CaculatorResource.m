//
//  CaculatorResource.m
//  dbm-mw-caculator
//
//  Created by Patrick Deng on 13-2-18.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorResource.h"

static SystemSoundID s_caculatorButtonClickSoundID;
static SystemSoundID s_saveButtonClickSoundID;
static SystemSoundID s_switchButtonClickSoundID;
static SystemSoundID s_historyButtonClickSoundID;
static SystemSoundID s_helpButtonClickSoundID;

static NSString* s_localStoredFileFullName;

@implementation CaculatorResource

+(void) initialize
{
    NSString* buttonWavPath = [[NSBundle mainBundle] pathForResource:@"button" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:buttonWavPath], &s_caculatorButtonClickSoundID);
    
    NSString* helpWavPath = [[NSBundle mainBundle] pathForResource:@"help" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:helpWavPath], &s_helpButtonClickSoundID);
    
    NSString* historyWavPath = [[NSBundle mainBundle] pathForResource:@"history" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:historyWavPath], &s_historyButtonClickSoundID);
    
    NSString* saveWavPath = [[NSBundle mainBundle] pathForResource:@"save" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:saveWavPath], &s_saveButtonClickSoundID);
    
    NSString* switchWavPath = [[NSBundle mainBundle] pathForResource:@"switch" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:switchWavPath], &s_switchButtonClickSoundID);

    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    s_localStoredFileFullName = [Path stringByAppendingPathComponent:LOCAL_STORE_FILE];
}

+(NSString*) localStoreFileFullName
{
    return s_localStoredFileFullName;
}

+(void) playCaculatorButtonClickSound
{
    AudioServicesPlaySystemSound(s_caculatorButtonClickSoundID);
}

+(void) playHelpButtonClickSound
{
    AudioServicesPlaySystemSound(s_switchButtonClickSoundID);
}

+(void) playHistoryButtonClickSound
{
    AudioServicesPlaySystemSound(s_switchButtonClickSoundID);
}

+(void) playSaveButtonClickSound
{
    AudioServicesPlaySystemSound(s_switchButtonClickSoundID);
}

+(void) playSwitchButtonClickSound
{
    AudioServicesPlaySystemSound(s_switchButtonClickSoundID);
}

+(void) playFormatButtonClickSound
{
    AudioServicesPlaySystemSound(s_switchButtonClickSoundID);
}

@end
