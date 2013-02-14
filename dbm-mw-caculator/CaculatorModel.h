//
//  CaculatorModel.h
//  dbm-mw-caculator
//
//  Created by Patrick Deng on 13-2-12.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DECIMAL_ROUND_LENGTH 10

@interface CaculatorModel : NSObject

+(double) getRoundDoubleValue:(double) rawValue andRange:(int) rangeValue;

-(double) getDbmFromMw:(double) mwValue;
-(double) getMwFromDbm:(double) dbmValue;

@end
