//
//  CaculatorModel.h
//  dbm-mw-caculator
//
//  Created by Patrick Deng on 13-2-12.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//
//
//******How to convert mW to dBm*****
//
//The power conversion of mW to dBm is given by the formula:
//P(dBm) = 10 · log10( P(mW) )
//
//So,
//1mW = 0dBm
//
//Example
//Convert 20mW to dBm:,
//P(dBm) = 10 · log10( 20mW ) = 13.0103dBm
//
//dBm to mW conversion table
//
//Power (dBm)	Power (mW)
//-40 dBm        0.0001 mW
//-30 dBm        0.0010 mW
//-20 dBm        0.0100 mW
//-10 dBm        0.1000 mW
//0 dBm          1.0000 mW
//1 dBm          1.2589 mW
//2 dBm          1.5849 mW
//3 dBm          1.9953 mW
//4 dBm          2.5119 mW
//5 dBm          3.1628 mW
//6 dBm          3.9811 mW
//7 dBm          5.0119 mW
//8 dBm          6.3096 mW
//9 dBm          7.9433 mW
//10 dBm         10.0000 mW
//20 dBm         100.0000 mW
//30 dBm         1000.0000 mW
//40 dBm         10000.0000 mW
//50 dBm         100000.0000 mW
//
//
//*****How to convert mW to dBm*****
//
//The power conversion of mW to dBm is given by the formula:
//P(dBm) = 10 · log10( P(mW) )
//
//So,
//1mW = 0dBm
//
//Example
//Convert 20mW to dBm:,
//P(dBm) = 10 · log10( 20mW ) = 13.0103dBm
//
//dBm to mW conversion table
//
//Power (dBm)	Power (mW)
//-40 dBm        0.0001 mW
//-30 dBm        0.0010 mW
//-20 dBm        0.0100 mW
//-10 dBm        0.1000 mW
//0 dBm          1.0000 mW
//1 dBm          1.2589 mW
//2 dBm          1.5849 mW
//3 dBm          1.9953 mW
//4 dBm          2.5119 mW
//5 dBm          3.1628 mW
//6 dBm          3.9811 mW
//7 dBm          5.0119 mW
//8 dBm          6.3096 mW
//9 dBm          7.9433 mW
//10 dBm         10.0000 mW
//20 dBm         100.0000 mW
//30 dBm         1000.0000 mW
//40 dBm         10000.0000 mW
//50 dBm         100000.0000 mW
//
//

#import <Foundation/Foundation.h>

#define DECIMAL_ROUND_LENGTH 10
#define WATT_UNIT_INDENT_LENGTH 1000

#define DIGIT_DOT @"."
#define DIGIT_0 @"0"
#define DIGIT_1 @"1"
#define DIGIT_INFINITY @"inf"
#define DIGIT_NEGATIVE_INFINITY @"-inf"
#define NEGATIVE_CHAR @"-"
#define EMPTY_STRING @""
#define SCIENTIFIC_NOTIATION_CHAR @"e"
#define SCIENTIFIC_NOTIATION_COMMA @","
#define SCIENTIFIC_NOTIATION_LENGTH 3

@interface CaculatorModel : NSObject

typedef enum {kW=1000000000, W=1000000, mW=1000, uW=1} WattUnit;

+(NSString*) renderValueStringWithThousandSeparator:(NSString *)rawString;

+(double) getRoundDoubleValue:(double) rawValue andRange:(int) rangeValue;

+(double) getMWValueFromWattValueWithUnit:(double) wattValue andUnit:(WattUnit) unit;
+(double) getWattValueFromMWValue:(double) mWValue andUnit:(WattUnit) unit;
+(double) getDbmValueFromWattValueWithUnit:(double) wattValue andUnit:(WattUnit) unit;
+(double) getWattValueFromDbmValue:(double) dbmValue andUnit:(WattUnit) unit;

@end
