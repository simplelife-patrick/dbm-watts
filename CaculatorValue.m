//
//  CaculatorValue.m
//  dbm-watt
//
//  Created by Patrick Deng on 13-3-10.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorValue.h"

@interface CaculatorValue ()

@property (strong, nonatomic) NSMutableString* currentInputString;


@property (nonatomic) NSInteger complementLength;

-(void) reCaculate;

@end

@implementation CaculatorValue

@synthesize currentInputString = _currentInputString;

@synthesize notation = _notation;
@synthesize bitsLength = _bitsLength;
@synthesize complementLength = _complementLength;
@synthesize valueString = _valueString;
@synthesize reversedObject = _reversedObject;
@synthesize isNegative = _isNegative;

-(id) init
{
    if (self = [super init])
    {
        _currentInputString = [NSMutableString stringWithCapacity:0];
        _notation = DecNotation;
        _bitsLength = DecBitsLength;
        _complementLength = 0;
        _isNegative = FALSE;
        [self appendString:ZERO_CHAR];
    }

    return self;
}

-(void) setIsNegative:(BOOL) negative
{
    _isNegative = negative;
    [self reCaculate];
}

-(NSString *)valueString
{
    if (nil == _valueString)
    {
        _valueString = _currentInputString;
    }

    if (_isNegative && _notation == DecNotation)
    {
        NSMutableString* mutableString = [NSMutableString stringWithString:NEGATIVE_CHAR];
        [mutableString appendString:_currentInputString];
        _valueString = mutableString;
    }
    
    return _valueString;
}

-(CaculatorValue *)reversedObject
{
    if (nil == _reversedObject)
    {
        _reversedObject = [[CaculatorValue alloc] init];
        _reversedObject.reversedObject = self;
        _reversedObject.notation = _notation;
        _reversedObject.bitsLength = _bitsLength;
        _reversedObject.isNegative = -_isNegative;
    }

    switch (_notation)
    {
        case DecNotation:
        {
            break;
        }
        case BinNotation:
        case OctNotation:
        case HexNotation:
        {
            break;
        }
        default:
        {
            break;
        }
    }
    
    return _reversedObject;
}

-(NSInteger) length
{
    return _currentInputString.length;
}

-(void) appendString:(NSString*) string;
{
    [_currentInputString appendString:string];
}

-(double) doubleValue
{
    switch (_notation)
    {
        case DecNotation:
        {
            return _currentInputString.doubleValue;
        }
        case BinNotation:
        case OctNotation:
        case HexNotation:
        {
            break;
        }
        default:
        {
            break;
        }
    }
    
    return 0; //TODO:
}

-(int) intValue
{
    switch (_notation)
    {
        case DecNotation:
        {
            return _currentInputString.intValue;
        }
        case BinNotation:
        case OctNotation:
        case HexNotation:
        {
            break;
        }
        default:
        {
            break;
        }
    }
    
    return 0; //TODO:
}

-(NSInteger) integerValue
{
    switch (_notation)
    {
        case DecNotation:
        {
            return _currentInputString.integerValue;
        }
        case BinNotation:
        case OctNotation:
        case HexNotation:
        {
            break;
        }
        default:
        {
            break;
        }
    }
    
    return 0; //TODO:
}

-(void) replaceStringInRange:(NSRange) range withString:(NSString*) string
{
    [_currentInputString replaceCharactersInRange:range withString:string];
    [self reCaculate];
}

-(void) setString:(NSString*) string
{
    [_currentInputString setString:string];
    [self reCaculate];
}

-(void) deleteStringInRange:(NSRange) range
{
    [_currentInputString deleteCharactersInRange:range];
    [self reCaculate];
}

-(void) insertString:(NSString*) string atIndex:(NSUInteger) index
{
    [_currentInputString insertString:string atIndex:index];
    [self reCaculate];
}

-(NSString*) substringFromIndex:(NSUInteger) index
{
    return [_currentInputString substringFromIndex:index];
}

-(void) reCaculate
{
    switch (_notation)
    {
        case DecNotation:
        {
            break;
        }
        case BinNotation:
        case OctNotation:
        case HexNotation:
        {
            break;
        }
        default:
        {
            break;
        }
    }

    if (_isNegative)
    {
        
    }
    else
    {
        _complementLength = 0;
    }
}

@end
