//
//  CaculatorButton.h
//  dbm-mw-caculator
//
//  Created by Patrick Deng on 13-2-13.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CaculatorButton : UIButton

@property (nonatomic) BOOL isEmphasized;

-(void) disableButton;
-(void) enableButton;

@end
