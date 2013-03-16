//
//  CaculatorResult.m
//  dbm-watt
//
//  Created by Patrick Deng on 13-2-23.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorResult.h"

@implementation CaculatorResult

@synthesize dbmValue;
@synthesize wattValue;
@synthesize wattUnit;
@synthesize isDbm2Watt;
@synthesize savedTime;

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.dbmValue forKey:CODING_KEY_DBM];
    [aCoder encodeObject:self.wattValue forKey:CODING_KEY_WATT];
    [aCoder encodeInt:self.wattUnit forKey:CODING_KEY_WATTUNIT];
    [aCoder encodeBool:self.isDbm2Watt forKey:CODING_KEY_ISDBM2WATT];
    [aCoder encodeObject:self.savedTime forKey:CODING_KEY_SAVEDTIME];
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init])
    {
        self.dbmValue = [aDecoder decodeObjectForKey:CODING_KEY_DBM];
        self.wattValue = [aDecoder decodeObjectForKey:CODING_KEY_WATT];
        self.wattUnit = [aDecoder decodeIntForKey:CODING_KEY_WATTUNIT];
        self.isDbm2Watt = [aDecoder decodeBoolForKey:CODING_KEY_ISDBM2WATT];
        self.savedTime = [aDecoder decodeObjectForKey:CODING_KEY_SAVEDTIME];
    }
    return self;
}

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

-(NSString*) description
{
    NSMutableString* string = [NSMutableString stringWithCapacity:0];
    
    if (self.isDbm2Watt)
    {
        [string appendString:self.dbmValue];
        [string appendString:DBM];
        [string appendString:EQUAL_CHAR];
        [string appendString:self.wattValue];
        [string appendString:[CaculatorUIStyle wattUnitString:self.wattUnit]];
    }
    else
    {
        [string appendString:self.wattValue];
        [string appendString:[CaculatorUIStyle wattUnitString:self.wattUnit]];
        [string appendString:EQUAL_CHAR];
        [string appendString:self.dbmValue];
        [string appendString:DBM];
    }
    
    return string;
}

@end
