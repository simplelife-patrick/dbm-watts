//
//  CaculatorRecord.h
//  dbm-watt
//
//  Created by Patrick Deng on 13-2-23.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaculatorRecord : NSObject <NSCoding>

@property (strong, nonatomic) NSString* dbmValue;
@property (strong, nonatomic) NSString* wattValue;
@property (nonatomic) WattUnit wattUnit;
@property (nonatomic) BOOL isDbm2Watt;
@property (strong, nonatomic) NSDate* savedTime;

-(id) initWithDbmValue:(NSString*) dbm wattValue:(NSString*)watt wattUnit:(WattUnit) unit isDbm2Watt:(BOOL) dbm2watt;

@end
