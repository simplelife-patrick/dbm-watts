//
//  CaculatorState.m
//  dbm-watt
//
//  Created by Patrick Deng on 13-3-15.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorValueRule.h"

@implementation CaculatorValueRule

-(void) onBitLengthChanged:(BitsLength) length
{
    
}

-(void) onValueReset
{
    
}

-(BOOL) canValueBeAppended:(NSString*) value
{
    return FALSE;    
}

-(BOOL) canValueBeSet:(NSString*) value
{
    return FALSE;
}

-(BOOL) canValueBeDeletedInRange:(NSRange) range
{
    return FALSE;
}

-(BOOL) canValueBeInserted:(NSString*) value atIndex:(NSUInteger) index
{
    return FALSE;
}

-(BOOL) canValueBeNegative
{
    return FALSE;
}

-(BOOL) canValueBeFractional
{
    return FALSE;
}

-(BOOL) canValueBeSaved
{
    return FALSE;
}

-(void) onInputModeChanged:(NSString*) mode
{
    
}

@end
