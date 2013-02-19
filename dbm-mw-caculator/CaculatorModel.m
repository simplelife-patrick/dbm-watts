//
//  CaculatorModel.m
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

#import "CaculatorModel.h"

@implementation CaculatorModel

+(double) getRoundDoubleValue:(double)rawValue andRange:(int)rangeValue
{
//    int intVal = 1;
//    for (int i = 0; i < rangeValue; i++)
//    {
//        intVal = intVal * 10;
//    }
//    
//    double roundedValue = round(rawValue * intVal) / intVal;
//    return roundedValue;
    return rawValue;
}

+(double) getMWValueFromWattValueWithUnit:(double)wattValue andUnit:(WattUnit)unit
{
    double mWValue = 0;
    
    switch (unit)
    {
        case kW:
            mWValue = wattValue * WATT_UNIT_INDENT_LENGTH * WATT_UNIT_INDENT_LENGTH;
            break;
        case W:
            mWValue = wattValue * WATT_UNIT_INDENT_LENGTH;            
            break;
        case mW:
            mWValue = wattValue;
            break;
        case uW:
            mWValue = wattValue / WATT_UNIT_INDENT_LENGTH;
            break;
        default:
            break;
    }
    
    return mWValue;
}

+(double) getWattValueFromMWValue:(double) mWValue andUnit:(WattUnit) unit
{
    double wattValue = 0;

    switch (unit)
    {
        case kW:
            wattValue = mWValue / (WATT_UNIT_INDENT_LENGTH * WATT_UNIT_INDENT_LENGTH);
            break;
        case W:
            wattValue = mWValue / WATT_UNIT_INDENT_LENGTH;            
            break;
        case mW:
            wattValue = mWValue;
            break;
        case uW:
            wattValue = mWValue * WATT_UNIT_INDENT_LENGTH;
            break;
        default:
            break;
    }
    
    return wattValue;
}

-(double) getDbmValueFromWattValueWithUnit:(double) wattValue andUnit:(WattUnit) unit
{
    double mWValue = [self.class getMWValueFromWattValueWithUnit:wattValue andUnit:unit];
    
    double dbmValue = 10 * log10(mWValue);
    
    return [self.class getRoundDoubleValue:dbmValue andRange:DECIMAL_ROUND_LENGTH];
}

-(double) getWattValueFromDbmValue:(double) dbmValue andUnit:(WattUnit) unit
{
    double mWValue = 1 * pow(10, dbmValue / 10);
    
    double wattValue = [self.class getWattValueFromMWValue:mWValue andUnit:unit];
    
    return [self.class getRoundDoubleValue:wattValue andRange:DECIMAL_ROUND_LENGTH];
}

@end
