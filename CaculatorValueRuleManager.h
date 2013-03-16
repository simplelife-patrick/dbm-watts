//
//  CaculatorStateManager.h
//  dbm-watt
//
//  Created by Patrick Deng on 13-3-15.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CaculatorValueRule.h"
#import "DecNotationValueRule.h"
#import "HexNotationValueRule.h"

@interface CaculatorValueRuleManager : NSObject
{
    @private
        CaculatorValueRule* rule;
        NSMutableArray* ruleList;
}

@property (strong, nonatomic) CaculatorValueRule* rule;
@property (strong, nonatomic) NSMutableArray* ruleList;

-(void) enableHexNotationValueRule;
-(void) enableDecNotationValueRule;

@end
