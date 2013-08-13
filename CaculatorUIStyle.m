//
//  CaculatorUIStyle.m
//  dbm-mw-caculator
//
//  Created by Patrick Deng on 13-2-17.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorUIStyle.h"
#import "CaculatorButton.h"
static UIColor* s_caculatorButtonNormalBackgroundColor;
static UIColor* s_caculatorButtonHighlightedBackgroundColor;
static UIColor* s_screenLabelBackgroundColor;
static UIColor* s_focusedScreenLabelBackgroundColor;

@implementation CaculatorUIStyle

+(void)initialize
{
    if (nil == s_caculatorButtonNormalBackgroundColor)
    {
        s_caculatorButtonNormalBackgroundColor = [UIColor colorWithRed:0.839216 green:0.839216 blue:0.839216 alpha:1.0];
    }
    
    if (nil == s_caculatorButtonHighlightedBackgroundColor)
    {
        s_caculatorButtonHighlightedBackgroundColor = [UIColor darkGrayColor];
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

+(UIColor*) caculatorButtonNormalBackgroundColor
{
    return s_caculatorButtonNormalBackgroundColor;
}

+(UIColor*) caculatorButtonHighlightedBackgroundColor
{
    return s_caculatorButtonHighlightedBackgroundColor;
}

+(UIColor*) screenLabelBackgroundColor
{
    return s_screenLabelBackgroundColor;
}

+(UIColor*) focusedScreenLabelBackgroundColor
{
    return s_focusedScreenLabelBackgroundColor;
}

+(NSString*) wattUnitString:(WattUnit)unit
{
    switch (unit)
    {
        case kW:
            return WATT_UNIT_KW;
        case W:
            return WATT_UNIT_W;
        case mW:
            return WATT_UNIT_MW;
        case uW:
            return WATT_UNIT_UW;
        default:
            return EMPTY_STRING;
    }
}

+(NSString*) formatDoubleToString:(double)value
{
    NSString* string = [NSString stringWithFormat:@"%g", value];
    return string;
}

+(NSString*) formatIntToString:(int)value
{
    NSString* string = [NSString stringWithFormat:@"%d", value];
    return string;
}

+(UINavigationBar*) createCustomNavigationBar
{
    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    bar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    bar.layer.borderWidth = UI_SCREEN_LABEL_BORDERWIDTH;
    bar.layer.cornerRadius = UI_SCREEN_LABEL_CORNERRADIUS;
    bar.frame = CGRectMake(5, 5, 310, 44);
    
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:nil];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    [left setFrame:CGRectMake(0, 2, 60, 28)];
    [left setBackgroundImage:[UIImage imageNamed:@"barbuttonitem.png"] forState:UIControlStateNormal];
    [left setBackgroundImage:[UIImage imageNamed:@"barbuttonitem.png"] forState:UIControlStateHighlighted];
    [left addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [left setTitle:@"Back" forState:UIControlStateNormal];
    [left setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [left setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    left.layer.borderColor = [UIColor lightGrayColor].CGColor;
    left.layer.borderWidth = UI_SCREEN_LABEL_BORDERWIDTH;
    left.layer.cornerRadius = UI_SCREEN_LABEL_CORNERRADIUS;
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:left];
    
    
    [item setLeftBarButtonItem:leftButton];
    [bar pushNavigationItem:item animated:NO];
    
    return bar;
}

+(void) globalUIStyleSetup
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [[CaculatorButton appearance] setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
}

@end
