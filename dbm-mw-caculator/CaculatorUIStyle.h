//
//  CaculatorUIStyle.h
//  dbm-mw-caculator
//
//  Created by Patrick Deng on 13-2-17.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface CaculatorUIStyle : NSObject

+(UIColor*) caculatorButtonBackgroundColor;
+(UIColor*) screenLabelBackgroundColor;
+(UIColor*) focusedScreenLabelBackgroundColor;

+(NSString*) wattUnitString:(WattUnit) unit;

+(NSString*) formatDoubleToString:(double) value;
+(NSString*) formatIntToString:(int) value;

+(UINavigationBar*) createCustomNavigationBar;

@end
