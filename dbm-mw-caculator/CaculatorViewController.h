//
//  ViewController.h
//  dbm-mw-caculator
//
//  Created by Patrick Deng on 13-2-12.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CaculatorModel.h"

#define SWITCHMODE_DBM2MW @"dbm"
#define SWITCHMODE_MW2DBM @"mw"

#define DIGIT_DOT @"."
#define DIGIT_0 @"0"
#define DIGIT_1 @"1"
#define DIGIT_INFINITY @"Inf"
#define DIGIT_NEGATIVE_INFINITY @"-Inf"

@interface CaculatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *dbmValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *mwValueLabel;

@property (weak, nonatomic) IBOutlet UIButton *switchButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *historyButton;
@property (weak, nonatomic) IBOutlet UIButton *helpButton;

@property (weak, nonatomic) IBOutlet UIButton *digit9Button;
@property (weak, nonatomic) IBOutlet UIButton *digit8Button;
@property (weak, nonatomic) IBOutlet UIButton *digit7Button;
@property (weak, nonatomic) IBOutlet UIButton *digit6Button;
@property (weak, nonatomic) IBOutlet UIButton *digit5Button;
@property (weak, nonatomic) IBOutlet UIButton *digit4Button;
@property (weak, nonatomic) IBOutlet UIButton *digit3Button;
@property (weak, nonatomic) IBOutlet UIButton *digit2Button;
@property (weak, nonatomic) IBOutlet UIButton *digit1Button;
@property (weak, nonatomic) IBOutlet UIButton *digit0Button;

@property (weak, nonatomic) IBOutlet UIButton *dotButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;


@property (strong, nonatomic) CaculatorModel *caculatorModel;
@property (nonatomic) BOOL isDbm2MwMode;

- (IBAction)onSwitchButtonClicked:(UIButton *)sender;
- (IBAction)onSaveButtonClicked:(UIButton *)sender;
- (IBAction)onHistoryButtonClicked:(UIButton *)sender;
- (IBAction)onHelpButtonClicked:(UIButton *)sender;

- (IBAction)onDigitButtonClicked:(UIButton *)sender;

- (IBAction)onDotButtonClicked:(UIButton *)sender;
- (IBAction)onClearButtonClicked:(UIButton *)sender;

@end
