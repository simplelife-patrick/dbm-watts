//
//  CaculatorResultTableViewController.h
//  dbm-watt
//
//  Created by Patrick Deng on 13-2-24.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CaculatorResultModel.h"

#import "CaculatorViewController.h"
#import "CaculatorResultTableViewCell.h"

@interface CaculatorResultTableViewController : UITableViewController <UITableViewDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) CaculatorResultModel* caculatorResultModel;

@end
