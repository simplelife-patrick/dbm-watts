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
@property (nonatomic, strong) NSMutableArray* caculatorButtons;
@property (nonatomic, strong) NSMutableArray* functionButtons;
@property (nonatomic, strong) NSMutableArray* wattUnitTextLabels;


-(void) resetCaculatorStatus:(BOOL) status;
-(void) enableNegativeButton:(BOOL) isEnabled;
-(void) decorateDbmValueLabel;
-(void) decorateMwValueLabel;
-(void) decorateCaculatorButtons;
-(void) decorateFunctionButtons;
-(void) initTapGestureRecognizer;
-(void) initSwipeGestureRecognizers;
-(void) switchWattUnit:(WattUnit) unit andInitStatus:(BOOL) isInInit;
-(void) switchWattUnit:(WattUnit) unit;

@end

@implementation CaculatorViewController

@synthesize caculatorModel = _caculatorModel;
@synthesize isDbm2MwMode;
@synthesize isUserInMiddleOfEnteringDigit;
@synthesize isNegativeStatus;
@synthesize caculatorButtons = _caculatorButtons;
@synthesize functionButtons = _functionButtons;
@synthesize tapGestureRecognizer = _tapGestureRecognizer;
@synthesize leftSwipeGestureRecognizer = _leftSwipeGestureRecognizer;
@synthesize rightSwipeGestureRecognizer = _rightSwipeGestureRecognizer;
@synthesize currentWattUnit = _currentWattUnits;
@synthesize wattUnitTextLabels = _wattUnitTextLabels;

-(void) enableNegativeButton:(BOOL)isEnabled
{
    [self.negativeButton setEnabled:isEnabled];
    if (isEnabled)
    {
        [self.negativeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else
    {
        [self.negativeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

-(void) resetCaculatorStatus:(BOOL) status
{
    self.isDigitInDecimalPart = status;
    self.isUserInMiddleOfEnteringDigit = status;
}

-(void) decorateDbmValueLabel
{

}

-(void) decorateMwValueLabel
{

}

-(NSMutableArray *) caculatorButtons
{
    if (nil == _caculatorButtons)
    {
        _caculatorButtons = [NSMutableArray arrayWithCapacity:13];
        [_caculatorButtons addObject:self.digit0Button];
        [_caculatorButtons addObject:self.digit1Button];
        [_caculatorButtons addObject:self.digit2Button];
        [_caculatorButtons addObject:self.digit3Button];
        [_caculatorButtons addObject:self.digit4Button];
        [_caculatorButtons addObject:self.digit5Button];
        [_caculatorButtons addObject:self.digit6Button];
        [_caculatorButtons addObject:self.digit7Button];
        [_caculatorButtons addObject:self.digit8Button];
        [_caculatorButtons addObject:self.digit9Button];
        [_caculatorButtons addObject:self.dotButton];
        [_caculatorButtons addObject:self.negativeButton];
        [_caculatorButtons addObject:self.clearButton];
    }
    
    return _caculatorButtons;
}

-(void) decorateCaculatorButtons
{

}

-(NSMutableArray *) functionButtons
{
    if (nil == _functionButtons)
    {
        _functionButtons = [NSMutableArray arrayWithCapacity:4];
        [_functionButtons addObject:self.switchButton];
        [_functionButtons addObject:self.saveButton];
        [_functionButtons addObject:self.historyButton];
        [_functionButtons addObject:self.helpButton];
    }
    
    return _functionButtons;
}

-(void) decorateFunctionButtons
{    

}

-(NSMutableArray *) wattUnitTextLabels
{
    if (nil == _wattUnitTextLabels)
    {
        _wattUnitTextLabels = [NSMutableArray arrayWithCapacity:4];
        [_wattUnitTextLabels addObject:self.kwTextLabel];
        [_wattUnitTextLabels addObject:self.wTextLabel];
        [_wattUnitTextLabels addObject:self.mwTextLabel];
        [_wattUnitTextLabels addObject:self.uwTextLabel];
    }
    
    return _wattUnitTextLabels;
}

-(void) playButtonClickSound
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"button" ofType:@"wav"];
    
    SystemSoundID soundID;
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
    
    AudioServicesPlaySystemSound(soundID);
    
    //    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void) initTapGestureRecognizer
{
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureUpdated:)];
    _tapGestureRecognizer.delegate = self;
    _tapGestureRecognizer.numberOfTapsRequired = 1;
    _tapGestureRecognizer.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:_tapGestureRecognizer];
}

- (void) initSwipeGestureRecognizers
{
    _leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeGestureUpdated:)];
    _leftSwipeGestureRecognizer.delegate = self;
    _leftSwipeGestureRecognizer.numberOfTouchesRequired = 1;
    _leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:_leftSwipeGestureRecognizer];

    _rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeGestureUpdated:)];
    _rightSwipeGestureRecognizer.delegate = self;
    _rightSwipeGestureRecognizer.numberOfTouchesRequired = 1;
    _rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:_rightSwipeGestureRecognizer];
}

- (void) switchWattUnit:(WattUnit)unit andInitStatus:(BOOL)isInInit
{
    if (!isInInit)
    {
        [CaculatorResource playButtonClickSound];
    }
    
    if (self.currentWattUnit == unit)
    {
        return;
    }
    else
    {
        if (self.isDbm2MwMode)
        {
            self.currentWattUnit = unit;
            NSNumber* dbmValue = [NSNumber numberWithDouble:self.dbmValueLabel.text.doubleValue];
            
            double newWattValue = [self.caculatorModel getWattValueFromDbmValue:dbmValue.doubleValue andUnit:self.currentWattUnit];
            [self.wattValueLabel setText:[NSNumber numberWithDouble:newWattValue].stringValue];
        }
        else
        {
            WattUnit oldUnit = self.currentWattUnit;
            NSNumber* oldWatt = [NSNumber numberWithDouble:self.wattValueLabel.text.doubleValue];
            double oldMWValue = [self.caculatorModel.class getMWValueFromWattValueWithUnit:oldWatt.doubleValue andUnit:oldUnit];
            
            self.currentWattUnit = unit;
            double newWattValueWithUnit = [self.caculatorModel.class getWattValueFromMWValue:oldMWValue andUnit:self.currentWattUnit];
            [self.wattValueLabel setText:[NSNumber numberWithDouble:newWattValueWithUnit].stringValue];
        }
    }
    
    UILabel* selectedLabel = nil;
    
    switch (unit)
    {
        case kW:
        {
            selectedLabel = self.kwTextLabel;
            break;
        }
        case W:
        {
            selectedLabel = self.wTextLabel;
            break;
        }
        case mW:
        {
            selectedLabel = self.mwTextLabel;
            break;
        }
        case uW:
        {
            selectedLabel = self.uwTextLabel;
            break;
        }
        default:
        {
            break;
        }
    }
    
    for (UILabel* label in self.wattUnitTextLabels)
    {
        if (label == selectedLabel)
        {
            label.textColor = [UIColor blackColor];
        }
        else
        {
            label.textColor = [UIColor lightGrayColor];
        }
    }
}

-(void) switchWattUnit:(WattUnit)unit
{
    [self switchWattUnit:unit andInitStatus:FALSE];
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
    self.isDbm2MwMode = FALSE;
    self.isNegativeStatus = FALSE;
    [self resetCaculatorStatus:FALSE];
    
    [self onSwitchButtonClicked:self.switchButton];
    
    [self decorateDbmValueLabel];
    [self decorateMwValueLabel];
    [self decorateFunctionButtons];
    [self decorateCaculatorButtons];
    
    [self initTapGestureRecognizer];
    [self initSwipeGestureRecognizers];
    
    [self switchWattUnit:mW andInitStatus:TRUE];
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
        
        [self enableNegativeButton:FALSE];
        
        self.dbmValueLabel.backgroundColor = [CaculatorUIStyle screenLabelBackgroundColor];
        self.wattValueLabel.backgroundColor = [CaculatorUIStyle focusedScreenLabelBackgroundColor];
    }
    else
    {
        self.isDbm2MwMode = TRUE;
        [sender setTitle:SWITCHMODE_DBM2MW forState:UIControlStateNormal];
        
        [self enableNegativeButton:TRUE];

        self.dbmValueLabel.backgroundColor = [CaculatorUIStyle focusedScreenLabelBackgroundColor];
        self.wattValueLabel.backgroundColor = [CaculatorUIStyle screenLabelBackgroundColor];
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
        NSNumber* newWattValue = [NSNumber numberWithDouble:[self.caculatorModel getWattValueFromDbmValue:newDbmValue.doubleValue andUnit:self.currentWattUnit]];
        [self.wattValueLabel setText:newWattValue.stringValue];
    }
    else
    {
        if (self.isUserInMiddleOfEnteringDigit)
        {
            NSString* newValue = [self.wattValueLabel.text stringByAppendingString:digit.stringValue];
            [self.wattValueLabel setText:newValue];
        }
        else
        {
            [self.wattValueLabel setText:digit.stringValue];
            if (0 != digit.intValue)
            {
                self.isUserInMiddleOfEnteringDigit = TRUE;
            }
        }
        
        NSNumber* newWattValue = [NSNumber numberWithDouble:self.wattValueLabel.text.doubleValue];
        
        NSNumber* newDbmValue = [NSNumber numberWithDouble:[self.caculatorModel getDbmValueFromWattValueWithUnit:newWattValue.doubleValue andUnit:self.currentWattUnit]];
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
        NSNumber* newWattValue = [NSNumber numberWithDouble:[self.caculatorModel getWattValueFromDbmValue:currentDbmValue.doubleValue andUnit:self.currentWattUnit]];
        [self.wattValueLabel setText:newWattValue.stringValue];
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
            self.wattValueLabel.text = [self.wattValueLabel.text stringByAppendingString:DIGIT_DOT];
        }
        
        [self resetCaculatorStatus:TRUE];
    }
}

- (IBAction)onClearButtonClicked:(CaculatorButton *)sender
{
    if ([self isDbm2MwMode])
    {
        [self.dbmValueLabel setText:DIGIT_0];
        [self.wattValueLabel setText:DIGIT_1];
    }
    else
    {
        [self.dbmValueLabel setText:DIGIT_NEGATIVE_INFINITY];
        [self.wattValueLabel setText:DIGIT_0];
    }
    
    [self resetCaculatorStatus:FALSE];
    self.isNegativeStatus = FALSE;
}

- (IBAction)playButtonClickSound:(CaculatorButton *)sender
{
    [CaculatorResource playButtonClickSound];
}

- (void)tapGestureUpdated:(UITapGestureRecognizer *) recognizer
{
    CGPoint locationTouch = [self.tapGestureRecognizer locationInView:self.view];
    
//    if (CGRectContainsPoint(self.dbmValueLabel.frame, locationTouch))
//    {
//        NSLog(@"Tap DBM Value Label.");
//    }
//    else if (CGRectContainsPoint(self.mwValueLabel.frame, locationTouch))
//    {
//        NSLog(@"Tap MW Value Label.");
//    }
//    // User gesture will be captured by mwValueLabl firstly.
//    else
    if (CGRectContainsPoint(self.kwTextLabel.frame, locationTouch))
    {
        [self switchWattUnit:kW];
    }
    else if (CGRectContainsPoint(self.wTextLabel.frame, locationTouch))
    {
        [self switchWattUnit:W];
    }
    else if (CGRectContainsPoint(self.mwTextLabel.frame, locationTouch))
    {
        [self switchWattUnit:mW];
    }
    else if (CGRectContainsPoint(self.uwTextLabel.frame, locationTouch))
    {
        [self switchWattUnit:uW];
    }
}

- (void)leftSwipeGestureUpdated:(UISwipeGestureRecognizer *) recognizer
{
    CGPoint locationTouch = [recognizer locationInView:self.view];
    
    if (CGRectContainsPoint(self.dbmValueLabel.frame, locationTouch))
    {

    }
    else if (CGRectContainsPoint(self.wattValueLabel.frame, locationTouch))
    {
        if (self.currentWattUnit != kW)
        {
            [self switchWattUnit:self.currentWattUnit * WATT_UNIT_INDENT_LENGTH];
        }
        else
        {
            [self switchWattUnit:uW];
        }
    }
}

- (void)rightSwipeGestureUpdated:(UISwipeGestureRecognizer *) recognizer
{
    CGPoint locationTouch = [recognizer locationInView:self.view];
    
    if (CGRectContainsPoint(self.dbmValueLabel.frame, locationTouch))
    {
      
    }
    else if (CGRectContainsPoint(self.wattValueLabel.frame, locationTouch))
    {
        if (self.currentWattUnit != uW)
        {
            [self switchWattUnit:self.currentWattUnit / WATT_UNIT_INDENT_LENGTH];
        }
        else
        {
            [self switchWattUnit:kW];
        }
    }
}

- (void)viewDidUnload
{
    [self setDbmValueLabel:nil];
    
    [self setKwTextLabel:nil];
    [self setWTextLabel:nil];
    [self setMwTextLabel:nil];
    [self setUwTextLabel:nil];
    [self setWattValueLabel:nil];
    
    [self setSwitchButton:nil];
    [self setSaveButton:nil];
    [self setHistoryButton:nil];
    [self setHelpButton:nil];
    
    [self setDigit0Button:nil];
    [self setDigit1Button:nil];
    [self setDigit2Button:nil];
    [self setDigit3Button:nil];
    [self setDigit4Button:nil];
    [self setDigit5Button:nil];
    [self setDigit6Button:nil];
    [self setDigit7Button:nil];
    [self setDigit8Button:nil];
    [self setDigit9Button:nil];
    
    [self setDotButton:nil];
    [self setNegativeButton:nil];
    [self setClearButton:nil];
    
    [self setLeftSwipeGestureRecognizer:nil];
    [self setRightSwipeGestureRecognizer:nil];
    [self setTapGestureRecognizer:nil];
    
    [self setCaculatorModel:nil];
    
    [super viewDidUnload];
}
@end
