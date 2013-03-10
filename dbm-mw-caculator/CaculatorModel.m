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

static NSArray* s_hexCharArray;

@interface CaculatorModel ()

@property (strong, nonatomic) NSMutableArray* recordList;

@end

@implementation CaculatorModel

@synthesize recordList = _recordList;

+(void) initialize
{
    s_hexCharArray = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"A", @"B", @"C", @"D", @"E", @"F", nil];
}

+(NSString*) hexStringFromDecValue:(NSInteger)integer
{
    if (0 < integer)
    {
        
    }
    else if (0 > integer)
    {
        
    }
    else
    {
        
    }
    
    return nil;
}

+(NSInteger) decValueFromHexString:(NSString*) hexString
{
    return 0;
}

+(NSString*) binStringFromDecValue:(NSInteger) integer
{
    NSMutableString* binString = [NSMutableString stringWithCapacity:0];
    
    if (0 != integer)
    {
        NSInteger tempInteger = (0 < integer) ? integer : -integer;
        
        NSInteger quotient = tempInteger / 2;
        NSInteger remainder = tempInteger % 2;
        NSMutableArray* filoStack = [NSMutableArray arrayWithCapacity:0];
        
        while (0 < quotient)
        {
            [filoStack addObject:[NSNumber numberWithInteger:remainder]];
            remainder = quotient % 2;
            quotient = quotient / 2;
        }
        [filoStack addObject:[NSNumber numberWithInteger:remainder]];
        
        for (NSInteger indexA = filoStack.count - 1; indexA >= 0; indexA--)
        {
            NSNumber* binNumber = (NSNumber*)[filoStack objectAtIndex:indexA];
            [binString appendString: binNumber.stringValue];
        }
        if (0 > integer)
        {
            // step 1: reverse 0/1 bit by bit
            for (NSInteger indexB = 0; indexB < binString.length; indexB++)
            {
                unichar c = [binString characterAtIndex:indexB];
                c = (c == '0') ? '1' : '0';
                NSString* str = [NSString stringWithCharacters:&c length:1];
                
                [binString deleteCharactersInRange:NSMakeRange(indexB, 1)];
                [binString insertString:str atIndex:indexB];
            }
            
            // step 2: + 1
            NSInteger indexC = binString.length - 1;
            while (indexC >= 0)
            {
                unichar c = [binString characterAtIndex:indexC];
                if (c == '0')
                {
                    c = '1';
                    NSString* str = [NSString stringWithCharacters:&c length:1];
                    [binString deleteCharactersInRange:NSMakeRange(indexC, 1)];
                    [binString insertString:str atIndex:indexC];
                    break;
                }
                else
                {
                    c = '0';
                }
                
                indexC--;
            }
            
            // step 3: fill '1' in header (byte:8, word:16, dword:32, qword:64)
            NSInteger fillLength = 0;
            if (binString.length < 8)
            {
                fillLength = 8 - binString.length;
            }
            else if (binString.length < 16)
            {
                fillLength = 16 - binString.length;
            }
            else if (binString.length < 32)
            {
                fillLength = 32 - binString.length;
            }
            else if (binString.length < 64)
            {
                fillLength = 64 - binString.length;
            }
            else
            {
                //TODO:
                fillLength = 1;
            }
            
            for (NSInteger indexD = 0; indexD < fillLength; indexD++)
            {
                [binString insertString:@"1" atIndex:0];
            }
        }
    }
    else
    {
        [binString appendString:@"0"];
    }
    
    return binString;
}

+(NSInteger) decValueFromBinString:(NSString*) binString ifSigned:(BOOL)ifSigned
{
    NSInteger decValue = 0;

    if (nil != binString && binString.length > 0)
    {
        NSMutableString* mutableString = [NSMutableString stringWithString:binString];
        
        unichar firstChar = [mutableString characterAtIndex:0];
        BOOL isNegativeValue = (firstChar == '1' && ifSigned) ? TRUE: FALSE;
        
        if (isNegativeValue)
        {
            // step 1: reverse '1' to '0' in header (Byte:8, Word:16, DWord:32, QWord:64)
            NSInteger reverseLength = 0;
            if (mutableString.length == 8)
            {
                reverseLength = 8 - binString.length;
            }
            else if (mutableString.length == 16)
            {
                reverseLength = 16 - binString.length;
            }
            else if (mutableString.length == 32)
            {
                reverseLength = 32 - binString.length;
            }
            else if (mutableString.length == 64)
            {
                reverseLength = 64 - binString.length;
            }
            else
            {
                //TODO:
                reverseLength = 0;
            }
            for (NSInteger indexD = 0; indexD < reverseLength; indexD++)
            {
                [mutableString insertString:@"0" atIndex:0];
            }
            
            // step 2: -1
            NSInteger indexA = binString.length - 1;
            while (indexA >= 0)
            {
                unichar c = [mutableString characterAtIndex:indexA];
                if (c == '0')
                {
                    c = '1';
                    NSString* str = [NSString stringWithCharacters:&c length:1];
                    [mutableString deleteCharactersInRange:NSMakeRange(indexA, 1)];
                    [mutableString insertString:str atIndex:indexA];
                }
                else
                {
                    c = '0';
                    break;
                }
                
                indexA--;
            }
            
            // step 3: reverse 0/1 by bit
            for (NSInteger indexB = 0; indexB < binString.length; indexB++)
            {
                unichar c = [binString characterAtIndex:indexB];
                c = (c == '0') ? '1' : '0';
                NSString* str = [NSString stringWithCharacters:&c length:1];
                
                [mutableString deleteCharactersInRange:NSMakeRange(indexB, 1)];
                [mutableString insertString:str atIndex:indexB];
            }
        }
        
        for (NSInteger index = mutableString.length - 1; index >= 0; index--)
        {
            unichar c = [mutableString characterAtIndex:index];
            
            if (index == 0 && isNegativeValue)
            {
                break;
            }
            
            if (c == '1')
            {
                NSInteger powVal = mutableString.length - 1 - index;
                decValue += 1 * pow(2, powVal);
            }
        }
        
        // step 4: reverse whole value
        decValue = (isNegativeValue) ? -decValue : decValue;
    }
    
    return decValue;
}

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
