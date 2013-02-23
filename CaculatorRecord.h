//
//  CaculatorRecord.h
//  dbm-watt
//
//  Created by Patrick Deng on 13-2-23.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CaculatorModel.h"

@interface CaculatorRecord : NSObject

@property (strong, nonatomic) NSString* dbmValue;
@property (strong, nonatomic) NSString* wattValue;
@property (nonatomic) WattUnit wattUnit;
@property (nonatomic) BOOL isDbm2Watt;

@end
