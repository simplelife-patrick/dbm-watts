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

-(void) resetCaculatorStatus:(BOOL) status;

@end

@implementation CaculatorViewController

@synthesize caculatorModel = _caculatorModel;
@synthesize isDbm2MwMode;
@synthesize isUserInMiddleOfEnteringDigit;

-(void) resetCaculatorStatus:(BOOL) status
{
    [self setIsDigitInDecimalPart:status];
    [self setIsUserInMiddleOfEnteringDigit:status];
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
    [self setIsDbm2MwMode:TRUE];
    [self resetCaculatorStatus:FALSE];
    [self onClearButtonClicked:self.clearButton];
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
        [self setIsDbm2MwMode:FALSE];
        [sender setTitle:SWITCHMODE_MW2DBM forState:UIControlStateNormal];
    }
    else
    {
        [self setIsDbm2MwMode:TRUE];
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
    NSString* sDigit = [sender currentTitle];
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    NSNumber* digit = [formatter numberFromString:sDigit];
    
    if (self.isDbm2MwMode)
    {
        if (self.isUserInMiddleOfEnteringDigit)
        {
            NSString* newValue = [self.dbmValueLabel.text stringByAppendingString:digit.stringValue];
            [self.dbmValueLabel setText:newValue];
        }
        else
        {
            [self.dbmValueLabel setText:digit.stringValue];
            if (0 != digit.intValue)
            {
                self.isUserInMiddleOfEnteringDigit = TRUE;
            }
        }

        NSNumber* newDbmValue = [formatter numberFromString:self.dbmValueLabel.text];
        NSNumber* newMwValue = [[NSNumber alloc] initWithDouble:[self.caculatorModel getMwFromDbm:newDbmValue.doubleValue]];
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
        
        NSNumber* newMwValue = [formatter numberFromString:self.mwValueLabel.text];
        NSNumber* newDbmValue = [[NSNumber alloc] initWithDouble:[self.caculatorModel getDbmFromMw:newMwValue.doubleValue]];
        [self.dbmValueLabel setText:newDbmValue.stringValue];
    }
}

- (IBAction)onDotButtonClicked:(CaculatorButton *)sender
{
    if (!self.isDigitInDecimalPart)
    {
        if (self.isDbm2MwMode)
        {
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
}

@end
