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

@interface CaculatorModel ()

@property (strong, nonatomic) NSMutableArray* recordList;

@end

@implementation CaculatorModel

@synthesize recordList = _recordList;

+(NSString*) derenderValueStringWithThousandSeparator:(NSString *)rawString
{
    NSMutableString* mutableString = [NSMutableString stringWithCapacity:rawString.length];
    [mutableString setString:rawString];
    
    if (nil != mutableString && 0 < mutableString.length)
    {
        while (TRUE)
        {
            NSRange rangeOfComma = [mutableString rangeOfString:SCIENTIFIC_NOTIATION_COMMA];
            if (NSNotFound != rangeOfComma.location)
            {
                [mutableString deleteCharactersInRange:rangeOfComma];
            }
            else
            {
                break;
            }
        }
    }
    return mutableString;
}

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

+(double) getDbmValueFromWattValueWithUnit:(double) wattValue andUnit:(WattUnit) unit
{
    double mWValue = [self.class getMWValueFromWattValueWithUnit:wattValue andUnit:unit];
    
    double dbmValue = 10 * log10(mWValue);
    
    return [self.class getRoundDoubleValue:dbmValue andRange:DECIMAL_ROUND_LENGTH];
}

+(double) getWattValueFromDbmValue:(double) dbmValue andUnit:(WattUnit) unit
{
    double mWValue = 1 * pow(10, dbmValue / 10);
    
    double wattValue = [self.class getWattValueFromMWValue:mWValue andUnit:unit];
    
    return [self.class getRoundDoubleValue:wattValue andRange:DECIMAL_ROUND_LENGTH];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        // Initialization code here.
        [self loadFromLocalStorage];
    }
    
    return self;
}

-(NSUInteger) recordsCount
{
    return self.recordList.count;
}

-(CaculatorRecord*) recordAtIndex:(NSUInteger) index
{
    CaculatorRecord* record = nil;
    
    if (index < self.recordList.count)
    {
        record = [self.recordList objectAtIndex:index];
    }
    
    return record;
}

-(void) addRecord:(CaculatorRecord*) record
{
    if (nil != record)
    {
        [record setSavedTime:[NSDate date]];
        [self.recordList addObject:record];
        [self saveToLocalStorage];
    }
}

-(void) compressList
{
    NSInteger index = self.recordList.count;
    while (0 < index)
    {
        if ([[self.recordList objectAtIndex:index - 1] isKindOfClass:[NSString class]])
        {
            [self.recordList removeObjectAtIndex:index - 1];
        }
        index = index - 1;
    }
    [self saveToLocalStorage];
}

-(void) deleteRecord:(NSUInteger) index
{
    [self deleteRecord:index compressList:TRUE];
}

-(void) deleteRecord:(NSUInteger)index compressList:(BOOL) needCompress
{
    if (index < self.recordList.count)
    {
        //        [self.recordList removeObjectAtIndex:index];
        [self.recordList setObject:EMPTY_STRING atIndexedSubscript:index];

        if (needCompress)
        {
            [self compressList];
        }
    }
}

-(void) deleteAllRecords
{
    [self.recordList removeAllObjects];
    [self saveToLocalStorage];
}

-(void) saveToLocalStorage
{
    NSArray* array = [NSArray arrayWithArray:self.recordList];

    [NSKeyedArchiver archiveRootObject:array toFile:[CaculatorResource localStoreFileFullName]];
}

-(void) loadFromLocalStorage
{
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile: [CaculatorResource localStoreFileFullName]];
    
    if (nil == array || ![array isKindOfClass:[NSArray class]])
    {
        _recordList = [NSMutableArray arrayWithCapacity:0];
    }
    else
    {
        _recordList = [NSMutableArray arrayWithArray:array];
    }
}

@end
