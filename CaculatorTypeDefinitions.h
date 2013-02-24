//
//  CaculatorTypeDefinitions.h
//  dbm-watt
//
//  Created by Patrick Deng on 13-2-23.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#ifndef dbm_watt_CaculatorTypeDefinitions_h
#define dbm_watt_CaculatorTypeDefinitions_h

#define APP_CONFIG_RECORD_LIST @"cfg_recordList"

#define DECIMAL_ROUND_LENGTH 10
#define WATT_UNIT_INDENT_LENGTH 1000

#define DIGIT_DOT @"."
#define DIGIT_0 @"0"
#define DIGIT_1 @"1"
#define DIGIT_INFINITY @"inf"
#define DIGIT_NEGATIVE_INFINITY @"-inf"
#define NEGATIVE_CHAR @"-"
#define EMPTY_STRING @""
#define EQUAL_CHAR @"="
#define SPACE_CHAR @" "
#define SCIENTIFIC_NOTIATION_CHAR @"e"
#define SCIENTIFIC_NOTIATION_COMMA @","
#define SCIENTIFIC_NOTIATION_LENGTH 3

#define SWITCHMODE_DBM2WATT @"dbm"
#define SWITCHMODE_WATT2DBM @"watt"

#define UI_SCREEN_LABEL_CORNERRADIUS 8
#define UI_SCREEN_LABEL_BORDERWIDTH 3

#define UI_CACULATOR_BUTTON_CORNERRADIUS 4
#define UI_CACULATOR_BUTTON_BORDERWIDTH 1.5

#define WATT_UNIT_KW @"kW"
#define WATT_UNIT_W @"W"
#define WATT_UNIT_MW @"mW"
#define WATT_UNIT_UW @"uW"

#define DBM @"dbm"
#define WATT @"watt"

#define SEGUE_ID_TO_NAVIGATION_CONTROLLER @"toNavigationController"

typedef enum {kW=1000000000, W=1000000, mW=1000, uW=1} WattUnit;

#endif
