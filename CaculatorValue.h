//
//  CaculatorValue.h
//  dbm-watt
//
//  Created by Patrick Deng on 13-3-10.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {BinNotation, OctNotation, DecNotation, HexNotation} Notation;
typedef enum {BinByte=8, BinWord=16, BinDWord=32, BinQWord=64, OctByte=3, OctWord=6, OctDword=12, OctQword=24, Dec=19, HexByte=2, HexWord=4, HexDWord=8, HexQWord=16} BitsLength;

@interface CaculatorValue : NSObject

@property (nonatomic) Notation notation;
@property (nonatomic) BitsLength bitsLength;
@property (nonatomic, readonly) BOOL isNegative;
@property (strong, nonatomic, readonly) NSString* valueString;
@property (strong, nonatomic, readonly) CaculatorValue* reversedObject;

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
