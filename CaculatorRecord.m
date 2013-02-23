//
//  CaculatorRecord.m
//  dbm-watt
//
//  Created by Patrick Deng on 13-2-23.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorRecord.h"

@implementation CaculatorRecord

@synthesize dbmValue;
@synthesize wattValue;
@synthesize wattUnit;
@synthesize isDbm2Watt;
@synthesize savedTime;

-(id) initWithDbmValue:(NSString*) dbm wattValue:(NSString*)watt wattUnit:(WattUnit) unit isDbm2Watt:(BOOL) dbm2watt
{
    self = [super init];
    
    if (self)
    {
        [self setDbmValue:dbm];
        [self setWattValue:watt];
        [self setWattUnit:unit];
        [self setIsDbm2Watt:dbm2watt];
    }
    
    return self;
}

@end
