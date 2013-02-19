//
//  CaculatorUIStyle.h
//  dbm-mw-caculator
//
//  Created by Patrick Deng on 13-2-17.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UI_SCREEN_LABEL_CORNERRADIUS 8
#define UI_SCREEN_LABEL_BORDERWIDTH 3

#define UI_CACULATOR_BUTTON_CORNERRADIUS 4
#define UI_CACULATOR_BUTTON_BORDERWIDTH 1.5

#define WATT_UNIT_KW @"kW"
#define WATT_UNIT_W @"W"
#define WATT_UNIT_MW @"mW"
#define WATT_UNIT_UW @"uW"


@interface CaculatorUIStyle : NSObject

+(UIColor*) caculatorButtonBackgroundColor;
+(UIColor*) screenLabelBackgroundColor;
+(UIColor*) focusedScreenLabelBackgroundColor;

@end
