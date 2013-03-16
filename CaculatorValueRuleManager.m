//
//  CaculatorStateManager.m
//  dbm-watt
//
//  Created by Patrick Deng on 13-3-15.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorValueRuleManager.h"

@interface CaculatorValueRuleManager()

@end

@implementation CaculatorValueRuleManager

@synthesize rule = _valueState;
@synthesize ruleList = _valueStateList;

CaculatorValueRule* decNotationValueState;
CaculatorValueRule* hexNotationValueState;

-(id) init
{
    if (self = [super init])
    {
        decNotationValueState = [[DecNotationValueRule alloc] init];
        hexNotationValueState = [[HexNotationValueRule alloc] init];
        _valueStateList = [NSMutableArray arrayWithObjects:decNotationValueState, hexNotationValueState, nil];
    }
    
    return self;
}

-(void) enableHexNotationValueRule
{
    [self setRule:hexNotationValueState];
}

-(void) enableDecNotationValueRule
{
    [self setRule:decNotationValueState];
}

@end
