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
#define ZERO_CHAR @"0"
#define ONE_CHAR @"1"
#define SCIENTIFIC_NOTIATION_CHAR @"e"
#define SCIENTIFIC_NOTIATION_COMMA @","
#define SCIENTIFIC_NOTIATION_LENGTH 3
#define SCIENTIFIC_NOTIATION_EDGE 100000000

#define SWITCHMODE_DBM2WATT @"dbm"
#define SWITCHMODE_WATT2DBM @"watt"

#define FORMAT_DEC @"dec"
#define FORMAT_HEX @"hex"

#define UI_SCREEN_LABEL_CORNERRADIUS 8
#define UI_SCREEN_LABEL_BORDERWIDTH 3

#define UI_CACULATOR_BUTTON_CORNERRADIUS 4
#define UI_CACULATOR_BUTTON_BORDERWIDTH 1.5

#define UI_TABLE_ROW_HEIGHT 70

#define UI_HELP_PAGE_DISPLAY_INTERVAL 2.0f

#define WATT_UNIT_KW @"kW"
#define WATT_UNIT_W @"W"
#define WATT_UNIT_MW @"mW"
#define WATT_UNIT_UW @"uW"

#define DBM @"dbm"
#define WATT @"watt"
#define COLON_CHAR @":"

#define CODING_KEY_DBM @"dbm"
#define CODING_KEY_WATT @"watt"
#define CODING_KEY_WATTUNIT @"wattUnit"
#define CODING_KEY_ISDBM2WATT @"isDbm2Watt"
#define CODING_KEY_SAVEDTIME @"savedTime"

#define LOCAL_STORE_FILE @"caculator_record_list.rl"

#define SEGUE_ID_SPLASHVIEW_CONTROLLER_TO_NAVIGATION_CONTROLLER @"toNavigationController"
#define SEGUE_ID_NAVIGATION_CONTROLLER_TO_TABLEVIEW_CONTROLLER @"toCaculatorRecordViewController"
#define SEGUE_ID_TABLEVIEW_CONTROLLER_TO_HELPVIEW_CONTROLLER @"toCaculatorHelpViewController"
#define SEGUE_ID_HELPVIEW_CONTROLLER_TO_NAVIGATION_CONTROLLER @"helpViewController2navigationController"

typedef enum {kW=1000000000, W=1000000, mW=1000, uW=1} WattUnit;

#endif
