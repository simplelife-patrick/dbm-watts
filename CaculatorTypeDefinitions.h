//
//  CaculatorTypeDefinitions.h
//  dbm-watt
//
//  Created by Patrick Deng on 13-2-23.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#ifndef dbm_watt_CaculatorTypeDefinitions_h
#define dbm_watt_CaculatorTypeDefinitions_h

#define APP_CONFIG_ISLAUNCHED_BEFORE @"isAppLaunchedBefore"

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

#define NOTATION_DEC @"dec"
#define NOTATION_HEX @"hex"

#define UI_SCREEN_LABEL_CORNERRADIUS 4
#define UI_SCREEN_LABEL_BORDERWIDTH 2

#define UI_CACULATOR_BUTTON_CORNERRADIUS 4
#define UI_CACULATOR_BUTTON_BORDERWIDTH 1.5

#define UI_TABLE_ROW_HEIGHT 70

#define UI_HELP_PAGE_DISPLAY_INTERVAL 3.0f

#define UI_RENDER_RECORD_TABLECELL 1
#define UI_CACULATOR_RECORD_TABLECELL_ID @"CaculatorResultTableViewCell"

#define UI_TABLECELL_FONT_SIZE 18

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

#define SEGUE_ID_SPLASH_TO_CACULATOR @"splash->caculator"
#define SEGUE_ID_SPLASH_TO_HELP @"splash->help"
#define SEGUE_ID_CACULATOR_TO_HELP @"caculator->help"
#define SEGUE_ID_CACULATOR_TO_TABLE @"caculator->table"
#define SEGUE_ID_HELP_TO_CACULATOR @"help->caculator"

typedef enum {kW=1000000000, W=1000000, mW=1000, uW=1} WattUnit;

#endif
