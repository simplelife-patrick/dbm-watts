//
//  CaculatorModel.m
//  dbm-mw-caculator
//
//  Created by Patrick Deng on 13-2-12.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//
//
//

#import "CaculatorModel.h"

@implementation CaculatorModel

+(NSString*) renderValueStringWithThousandSeparator:(NSString *)rawString
{
    NSMutableString* mutableString = [NSMutableString stringWithCapacity:rawString.length];
    [mutableString setString:rawString];
    
    if (nil != mutableString && 0 < mutableString.length)
    {
        if ([mutableString isEqualToString:DIGIT_INFINITY] || [mutableString isEqualToString:DIGIT_NEGATIVE_INFINITY])
        {
            return mutableString;
        }
        
        NSRange rangeOfE = [mutableString rangeOfString:SCIENTIFIC_NOTIATION_CHAR];
        BOOL isScientificNotiationString = (NSNotFound != rangeOfE.location) ? TRUE : FALSE;
        
        if (!isScientificNotiationString)
        {
            NSRange rangeOfNegativeChar = [mutableString rangeOfString:NEGATIVE_CHAR];
            BOOL isNegative = (NSNotFound != rangeOfNegativeChar.location) ? TRUE : FALSE;
            if (isNegative)
            {
                [mutableString deleteCharactersInRange:NSMakeRange(0, 1)];
            }
            
            NSRange rangeOfDot = [mutableString rangeOfString:DIGIT_DOT];
            NSString* integerString = (NSNotFound != rangeOfDot.location) ? [mutableString substringToIndex:rangeOfDot.location] :
            nil;

            NSString* processString = (nil != integerString) ? integerString : mutableString;
            if (SCIENTIFIC_NOTIATION_LENGTH < processString.length)
            {
                for (int i = processString.length - SCIENTIFIC_NOTIATION_LENGTH; i > 0; i = i - SCIENTIFIC_NOTIATION_LENGTH)
                {
                    [mutableString insertString:SCIENTIFIC_NOTIATION_COMMA atIndex:i];
                }
            }
            
            if (isNegative)
            {
                [mutableString insertString:NEGATIVE_CHAR atIndex:0];
            }
        }
    }
    
    return mutableString;
}

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
