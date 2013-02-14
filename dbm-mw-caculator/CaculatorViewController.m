//
//  ViewController.m
//  dbm-mw-caculator
//
//  Created by Patrick Deng on 13-2-12.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorViewController.h"

@interface CaculatorViewController ()

@property (nonatomic) BOOL isUserInMiddleOfEnteringDigit;
@property (nonatomic) BOOL isDigitInDecimalPart;
@property (nonatomic) BOOL isNegativeStatus;

-(void) resetCaculatorStatus:(BOOL) status;

@end

@implementation CaculatorViewController

@synthesize caculatorModel = _caculatorModel;
@synthesize isDbm2MwMode;
@synthesize isUserInMiddleOfEnteringDigit;
@synthesize isNegativeStatus;

-(void) resetCaculatorStatus:(BOOL) status
{
    self.isDigitInDecimalPart = status;
    self.isUserInMiddleOfEnteringDigit = status;
}

- (CaculatorModel *) caculatorModel
{
    if (nil == _caculatorModel)
    {
        _caculatorModel = [[CaculatorModel alloc] init];
    }
    
    return _caculatorModel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.isDbm2MwMode = TRUE;
    self.isNegativeStatus = FALSE;
    [self resetCaculatorStatus:FALSE];
    [self onClearButtonClicked:self.clearButton];
    
    self.dbmValueLabel.adjustsFontSizeToFitWidth = YES;
    self.mwValueLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSwitchButtonClicked:(CaculatorButton *)sender
{
    if ([self isDbm2MwMode])
    {
        self.isDbm2MwMode = FALSE;
        [sender setTitle:SWITCHMODE_MW2DBM forState:UIControlStateNormal];
    }
    else
    {
        self.isDbm2MwMode = TRUE;
        [sender setTitle:SWITCHMODE_DBM2MW forState:UIControlStateNormal];
    }
    
    [self onClearButtonClicked:self.clearButton];
}

- (IBAction)onSaveButtonClicked:(CaculatorButton *)sender
{
    
}

- (IBAction)onHistoryButtonClicked:(CaculatorButton *)sender
{
    
}

- (IBAction)onHelpButtonClicked:(CaculatorButton *)sender
{
    
}

- (IBAction)onDigitButtonClicked:(CaculatorButton *)sender
{
    NSNumber* digit = [NSNumber numberWithDouble:sender.currentTitle.doubleValue];
    
    if (self.isDbm2MwMode)
    {
        if (self.isUserInMiddleOfEnteringDigit)
        {
            NSString* newValue = [self.dbmValueLabel.text stringByAppendingString:digit.stringValue];
            [self.dbmValueLabel setText:newValue];
        }
        else
        {
            if (0 != digit.doubleValue)
            {
                [self.dbmValueLabel setText:[self.dbmValueLabel.text stringByReplacingOccurrencesOfString:DIGIT_0 withString:digit.stringValue]];
                self.isUserInMiddleOfEnteringDigit = TRUE;
            }
        }

        NSNumber* newDbmValue = [NSNumber numberWithDouble:self.dbmValueLabel.text.doubleValue];
        NSNumber* newMwValue = [NSNumber numberWithDouble:[self.caculatorModel getMwFromDbm:newDbmValue.doubleValue]];
        [self.mwValueLabel setText:newMwValue.stringValue];
    }
    else
    {
        if (self.isUserInMiddleOfEnteringDigit)
        {
            NSString* newValue = [self.mwValueLabel.text stringByAppendingString:digit.stringValue];
            [self.mwValueLabel setText:newValue];
        }
        else
        {
            [self.mwValueLabel setText:digit.stringValue];
            if (0 != digit.intValue)
            {
                self.isUserInMiddleOfEnteringDigit = TRUE;
            }
        }
        
        NSNumber* newMwValue = [NSNumber numberWithDouble:self.mwValueLabel.text.doubleValue];
        NSNumber* newDbmValue = [NSNumber numberWithDouble:[self.caculatorModel getDbmFromMw:newMwValue.doubleValue]];
        [self.dbmValueLabel setText:newDbmValue.stringValue];
    }
}


- (IBAction)onNegativeButtonClicked:(CaculatorButton *)sender
{
    if (self.isDbm2MwMode)
    {
        if (self.isNegativeStatus)
        {
            NSMutableString* mutableStr = [NSMutableString stringWithString:self.dbmValueLabel.text];
            NSRange deleteRange = NSMakeRange(0, 1);
            [mutableStr deleteCharactersInRange:deleteRange];
            [self.dbmValueLabel setText:mutableStr];
            
            self.isNegativeStatus = FALSE;
        }
        else
        {
            NSMutableString* mutableStr = [NSMutableString stringWithString:self.dbmValueLabel.text];
            [mutableStr insertString:NEGATIVE_CHAR atIndex:0];
            [self.dbmValueLabel setText:mutableStr];
            
            self.isNegativeStatus = TRUE;
        }
        
        NSNumber* currentDbmValue = [NSNumber numberWithDouble:self.dbmValueLabel.text.doubleValue];
        NSNumber* newMwValue = [NSNumber numberWithDouble:[self.caculatorModel getMwFromDbm:currentDbmValue.doubleValue]];
        [self.mwValueLabel setText:newMwValue.stringValue];
    }
}

- (IBAction)onDotButtonClicked:(CaculatorButton *)sender
{
    if (!self.isDigitInDecimalPart)
    {
        if (self.isDbm2MwMode)
        {
            if ([NEGATIVE_CHAR isEqualToString:self.dbmValueLabel.text])
            {
                self.dbmValueLabel.text = [self.dbmValueLabel.text stringByAppendingString:DIGIT_0];
            }
            
            self.dbmValueLabel.text = [self.dbmValueLabel.text stringByAppendingString:DIGIT_DOT];
        }
        else
        {
            self.mwValueLabel.text = [self.mwValueLabel.text stringByAppendingString:DIGIT_DOT];
        }
        
        [self resetCaculatorStatus:TRUE];
    }
}

- (IBAction)onClearButtonClicked:(CaculatorButton *)sender
{
    if ([self isDbm2MwMode])
    {
        [self.dbmValueLabel setText:DIGIT_0];
        [self.mwValueLabel setText:DIGIT_1];
    }
    else
    {
        [self.dbmValueLabel setText:DIGIT_NEGATIVE_INFINITY];
        [self.mwValueLabel setText:DIGIT_0];
    }
    
    [self resetCaculatorStatus:FALSE];
    self.isNegativeStatus = FALSE;
}

@end
