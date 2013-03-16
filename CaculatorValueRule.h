//
//  CaculatorState.h
//  dbm-watt
//
//  Created by Patrick Deng on 13-3-15.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaculatorValueRule : NSObject

-(void) onBitLengthChanged:(BitsLength) notation;
-(void) onValueReset;
-(BOOL) canValueBeAppended:(NSString*) value;
-(BOOL) canValueBeSet:(NSString*) value;
-(BOOL) canValueBeDeletedInRange:(NSRange) range;
-(BOOL) canValueBeInserted:(NSString*) value atIndex:(NSUInteger) index;
-(BOOL) canValueBeNegative;
-(BOOL) canValueBeFractional;
-(BOOL) canValueBeSaved;
-(void) onInputModeChanged:(NSString*) mode;

@end
