//
//  ViewController.h
//  dbm-mw-caculator
//
//  Created by Patrick Deng on 13-2-12.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

#import "CaculatorScreenLabel.h"
#import "CaculatorButton.h"
#import "CaculatorResultTableViewController.h"
#import "CaculatorHelpViewController.h"

#import "CaculatorResultModel.h"
#import "CaculatorResource.h"

@interface CaculatorViewController : UIViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *screenView;
@property (weak, nonatomic) IBOutlet UIView *buttonsView;

@property (weak, nonatomic) IBOutlet CaculatorScreenLabel *dbmValueLabel;
@property (weak, nonatomic) IBOutlet CaculatorScreenLabel *wattValueLabel;

@property (weak, nonatomic) IBOutlet CaculatorButton *switchButton;
@property (weak, nonatomic) IBOutlet CaculatorButton *saveButton;
@property (weak, nonatomic) IBOutlet CaculatorButton *historyButton;
@property (weak, nonatomic) IBOutlet CaculatorButton *helpButton;

@property (weak, nonatomic) IBOutlet CaculatorButton *digit9Button;
@property (weak, nonatomic) IBOutlet CaculatorButton *digit8Button;
@property (weak, nonatomic) IBOutlet CaculatorButton *digit7Button;
@property (weak, nonatomic) IBOutlet CaculatorButton *digit6Button;
@property (weak, nonatomic) IBOutlet CaculatorButton *digit5Button;
@property (weak, nonatomic) IBOutlet CaculatorButton *digit4Button;
@property (weak, nonatomic) IBOutlet CaculatorButton *digit3Button;
@property (weak, nonatomic) IBOutlet CaculatorButton *digit2Button;
@property (weak, nonatomic) IBOutlet CaculatorButton *digit1Button;
@property (weak, nonatomic) IBOutlet CaculatorButton *digit0Button;

@property (weak, nonatomic) IBOutlet CaculatorButton *dotButton;
@property (weak, nonatomic) IBOutlet CaculatorButton *clearButton;
@property (weak, nonatomic) IBOutlet CaculatorButton *negativeButton;
@property (weak, nonatomic) IBOutlet CaculatorButton *delButton;
@property (weak, nonatomic) IBOutlet CaculatorButton *notationButton;

@property (weak, nonatomic) IBOutlet UILabel *kwTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *wTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *mwTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *uwTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *dbmTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *wattTipLabel;

@property (strong, nonatomic) CaculatorResultModel *caculatorResultModel;
@property (nonatomic) BOOL isDbm2WattMode;
@property (nonatomic) Notation currentNotation;

@property (nonatomic) WattUnit currentWattUnit;
@property (strong, nonatomic) CaculatorValue* currentInputValueObject;

@property (strong, nonatomic) UITapGestureRecognizer* singleTapGestureRecognizer;
@property (strong, nonatomic) UITapGestureRecognizer* doubleTapGestureRecognizer;
@property (strong, nonatomic) UISwipeGestureRecognizer* leftSwipeGestureRecognizer;
@property (strong, nonatomic) UISwipeGestureRecognizer* rightSwipeGestureRecognizer;
@property (strong, nonatomic) UISwipeGestureRecognizer* downSwipeGestureRecognizer;
@property (strong, nonatomic) UISwipeGestureRecognizer* upSwipeGestureRecognizer;
@property (strong, nonatomic) UILongPressGestureRecognizer* longPressGestureRecognizer;

- (IBAction)onSwitchButtonClicked:(CaculatorButton *)sender;
- (IBAction)onSaveButtonClicked:(CaculatorButton *)sender;
- (IBAction)onHistoryButtonClicked:(CaculatorButton *)sender;
- (IBAction)onHelpButtonClicked:(CaculatorButton *)sender;
- (IBAction)onNotationButtonClicked:(CaculatorButton *)sender;

- (IBAction)onDigitButtonClicked:(CaculatorButton *)sender;
- (IBAction)onNegativeButtonClicked:(CaculatorButton *)sender;
- (IBAction)onDotButtonClicked:(CaculatorButton *)sender;
- (IBAction)onDelButtonClicked:(CaculatorButton *)sender;
- (IBAction)onClearButtonClicked:(CaculatorButton *)sender;

- (IBAction)playButtonClickSound:(CaculatorButton *)sender;

@end
