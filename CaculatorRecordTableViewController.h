//
//  CaculatorRecordTableViewController.h
//  dbm-watt
//
//  Created by Patrick Deng on 13-2-24.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CaculatorModel.h"

#import "CaculatorViewController.h"

@interface CaculatorRecordTableViewController : UITableViewController

@property (strong, nonatomic) CaculatorModel* caculatorModel;

@end
