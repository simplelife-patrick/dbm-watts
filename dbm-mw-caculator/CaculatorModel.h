//
//  CaculatorModel.h
//  dbm-mw-caculator
//
//  Created by Patrick Deng on 13-2-12.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DECIMAL_ROUND_LENGTH 10
#define WATT_UNIT_INDENT_LENGTH 1000

@interface CaculatorModel : NSObject

typedef enum {kW=1000000000, W=1000000, mW=1000, uW=1} WattUnit;

+(double) getRoundDoubleValue:(double) rawValue andRange:(int) rangeValue;
+(double) getMWValueFromWattValueWithUnit:(double) wattValue andUnit:(WattUnit) unit;
+(double) getWattValueFromMWValue:(double) mWValue andUnit:(WattUnit) unit;

-(double) getDbmValueFromWattValueWithUnit:(double) wattValue andUnit:(WattUnit) unit;
-(double) getWattValueFromDbmValue:(double) dbmValue andUnit:(WattUnit) unit;

@end
