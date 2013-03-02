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
#import "CaculatorRecordTableViewCell.h"

@interface CaculatorRecordTableViewController : UITableViewController <UITableViewDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) CaculatorModel* caculatorModel;

@end
