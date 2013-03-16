//
//  CaculatorValue.h
//  dbm-watt
//
//  Created by Patrick Deng on 13-3-10.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {BinNotation, OctNotation, DecNotation, HexNotation} Notation;
typedef enum {BinByteBitsLength=8, BinWordBitsLength=16, BinDWordBitsLength=32, BinQWordBitsLength=64, DecBitsLength=19, HexByteBitsLength=2, HexWordBitsLength=4, HexDWordBitsLength=8, HexQWordBitsLength=16} BitsLength;
//typedef enum {DecByteValueMin=-128, DecWordValueMin=-32768, DecDWordValueMin=-2147483648, DecQWordValueMin=-9223372036854776000} DecNotationValueMinEdge;
//typedef enum {DecByteValueMax=127, DecWordValueMax=32767, DecDWordValueMax=2147483647, DecQWordValueMax=9223372036854775999} DecNotationValueMaxEdge;

@interface CaculatorValue : NSObject

@property (nonatomic) Notation notation;
@property (nonatomic) BitsLength bitsLength;
@property (nonatomic, readonly) BOOL isNegative;
@property (strong, nonatomic, readonly) NSString* valueString;
@property (strong, nonatomic) CaculatorValue* reversedObject;

-(NSInteger) length;
-(void) appendString:(NSString*) string;
-(double) doubleValue;
-(int) intValue;
-(NSInteger) integerValue;

-(void) replaceStringInRange:(NSRange) range withString:(NSString*) string;
-(void) setString:(NSString*) string;
-(void) deleteStringInRange:(NSRange) range;
-(void) insertString:(NSString*) string atIndex:(NSUInteger) index;
-(NSString*) substringFromIndex:(NSUInteger) index;

@end
