//
//  CaculatorUIStyle.m
//  dbm-mw-caculator
//
//  Created by Patrick Deng on 13-2-17.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorUIStyle.h"

static UIColor* s_componentCALayerBackgroundColor;

@implementation CaculatorUIStyle

+(void)initialize
{
    if (nil == s_componentCALayerBackgroundColor)
    {
        s_componentCALayerBackgroundColor = [UIColor colorWithRed:0.125490 green:0.603922 blue:0.890196 alpha:1.0];
    }
}

+(UIColor*) caculatorButtonBackgroundColor
{
    return s_componentCALayerBackgroundColor;
}

+(UIColor*) functionButtonBackgroundColor
{
    return s_componentCALayerBackgroundColor;
}

+(UIColor*) screenLabelBackgroundColor
{
    return s_componentCALayerBackgroundColor;
}

@end
