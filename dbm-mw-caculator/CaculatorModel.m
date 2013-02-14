//
//  CaculatorModel.m
//  dbm-mw-caculator
//
//  Created by Patrick Deng on 13-2-12.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorModel.h"

@implementation CaculatorModel

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

/*
 How to convert mW to dBm
 
 The power conversion of mW to dBm is given by the formula:
 P(dBm) = 10 · log10( P(mW) )
 
 So,
 1mW = 0dBm
 
 Example
 Convert 20mW to dBm:,
 P(dBm) = 10 · log10( 20mW ) = 13.0103dBm
 
 dBm to mW conversion table
 
 Power (dBm)	Power (mW)
 -40 dBm        0.0001 mW
 -30 dBm        0.0010 mW
 -20 dBm        0.0100 mW
 -10 dBm        0.1000 mW
 0 dBm          1.0000 mW
 1 dBm          1.2589 mW
 2 dBm          1.5849 mW
 3 dBm          1.9953 mW
 4 dBm          2.5119 mW
 5 dBm          3.1628 mW
 6 dBm          3.9811 mW
 7 dBm          5.0119 mW
 8 dBm          6.3096 mW
 9 dBm          7.9433 mW
 10 dBm         10.0000 mW
 20 dBm         100.0000 mW
 30 dBm         1000.0000 mW
 40 dBm         10000.0000 mW
 50 dBm         100000.0000 mW
 
 */
-(double) getDbmFromMw:(double)mwValue
{
    double dbmValue = 10 * log10(mwValue);
    
    return [self.class getRoundDoubleValue:dbmValue andRange:DECIMAL_ROUND_LENGTH];
}

/*
 How to convert dBm to mW
 
 The power conversion of dBm to mW is given by the formula:
 P(mW) = 10(P(dBm) / 10)
 
 So
 1dBm = 1.258925mW
 
 Example
 Convert 13dBm to milliwatts:
 P(mW) = 1mW · 10(13dBm / 10) = 19.95mW
 
 dBm to mW conversion table
 
 Power (dBm)	Power (mW)
 -40 dBm        0.0001 mW
 -30 dBm        0.0010 mW
 -20 dBm        0.0100 mW
 -10 dBm        0.1000 mW
 0 dBm          1.0000 mW
 1 dBm          1.2589 mW
 2 dBm          1.5849 mW
 3 dBm          1.9953 mW
 4 dBm          2.5119 mW
 5 dBm          3.1628 mW
 6 dBm          3.9811 mW
 7 dBm          5.0119 mW
 8 dBm          6.3096 mW
 9 dBm          7.9433 mW
 10 dBm         10.0000 mW
 20 dBm         100.0000 mW
 30 dBm         1000.0000 mW
 40 dBm         10000.0000 mW
 50 dBm         100000.0000 mW
 
 */
-(double) getMwFromDbm:(double)dbmValue
{
    double mwValue = 1 * pow(10, dbmValue / 10);
    
    return [self.class getRoundDoubleValue:mwValue andRange:DECIMAL_ROUND_LENGTH];
}

@end
