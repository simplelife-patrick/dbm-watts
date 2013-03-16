//
//  CaculatorResultTableViewCell.h
//  dbm-watt
//
//  Created by Patrick Deng on 13-3-2.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CaculatorResult.h"

@interface CaculatorResultTableViewCell : UITableViewCell

-(void) updateCellWithResult:(CaculatorResult*) result;

@end
