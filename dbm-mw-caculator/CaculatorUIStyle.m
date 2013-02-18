//
//  CaculatorUIStyle.m
//  dbm-mw-caculator
//
//  Created by Patrick Deng on 13-2-17.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorUIStyle.h"

static UIColor* s_caculatorButtonBackgroundColor;
static UIColor* s_screenLabelBackgroundColor;
static UIColor* s_focusedScreenLabelBackgroundColor;

@implementation CaculatorUIStyle

+(void)initialize
{
    if (nil == s_caculatorButtonBackgroundColor)
    {
        s_caculatorButtonBackgroundColor = [UIColor colorWithRed:0.839216 green:0.839216 blue:0.839216 alpha:1.0];
    }
    
    if (nil == s_screenLabelBackgroundColor)
    {
        s_screenLabelBackgroundColor = [UIColor colorWithRed:0.125490 green:0.603922 blue:0.890196 alpha:1.0];
    }
    
    if (nil == s_focusedScreenLabelBackgroundColor)
    {
        s_focusedScreenLabelBackgroundColor = [UIColor colorWithRed:1.000000 green:0.490196 blue:0.474510 alpha:1.0];
    }
}

+(UIColor*) caculatorButtonBackgroundColor
{
    return s_caculatorButtonBackgroundColor;
}

+(UIColor*) screenLabelBackgroundColor
{
    return s_screenLabelBackgroundColor;
}

+(UIColor*) focusedScreenLabelBackgroundColor
{
    return s_focusedScreenLabelBackgroundColor;
}

@end
