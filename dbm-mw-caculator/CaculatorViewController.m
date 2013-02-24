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
-(void) decorateDbmValueLabel;
-(void) decorateWattValueLabel;
-(void) decorateCaculatorButtons;
-(void) decorateFunctionButtons;
-(void) initSingleTapGestureRecognizer;
-(void) initDoubleTapGestureRecognizer;
-(void) initSwipeGestureRecognizers;
-(void) initLongPressGestureRecognizer;
-(void) switchWattUnit:(WattUnit) unit andInitStatus:(BOOL) isInInit;
-(void) switchWattUnit:(WattUnit) unit;
-(void) updateDbmValueLabelText:(NSString*) newString;
-(void) updateWattValueLabelText:(NSString*) newString;
-(void) caculateDbmAndWattPlusUpdateScreenLabels;

@end

@implementation CaculatorViewController

@synthesize caculatorModel = _caculatorModel;
@synthesize isDbm2WattMode;
@synthesize isUserInMiddleOfEnteringDigit;
@synthesize isNegativeStatus;

@synthesize currentWattUnit = _currentWattUnits;
@synthesize currentInputValueString = _currentInputValueString;

@synthesize screenView = _screenView;
@synthesize buttonsView = _buttonsView;
@synthesize dbmValueLabel = _dbmValueLabel;
@synthesize wattValueLabel = _wattValueLabel;

@synthesize switchButton = _switchButton;
@synthesize saveButton = _saveButton;
@synthesize historyButton = _historyButton;
@synthesize helpButton = _helpButton;

@synthesize digit9Button = _digit9Button;
@synthesize digit8Button = _digit8Button;
@synthesize digit7Button = _digit7Button;
@synthesize digit6Button = _digit6Button;
@synthesize digit5Button = _digit5Button;
@synthesize digit4Button = _digit4Button;
@synthesize digit3Button = _digit3Button;
@synthesize digit2Button = _digit2Button;
@synthesize digit1Button = _digit1Button;
@synthesize digit0Button = _digit0Button;

@synthesize dotButton = _dotButton;
@synthesize clearButton = _clearButton;
@synthesize negativeButton = _negativeButton;
@synthesize delButton = _delButton;

@synthesize caculatorButtons = _caculatorButtons;
@synthesize functionButtons = _functionButtons;
@synthesize wattUnitTextLabels = _wattUnitTextLabels;

@synthesize singleTapGestureRecognizer = _singleTapGestureRecognizer;
@synthesize doubleTapGestureRecognizer = _doubleTapGestureRecognizer;
@synthesize leftSwipeGestureRecognizer = _leftSwipeGestureRecognizer;
@synthesize rightSwipeGestureRecognizer = _rightSwipeGestureRecognizer;
@synthesize longPressGestureRecognizer = _longPressGestureRecognizer;
@synthesize downSwipeGestureRecognizer = _downSwipeGestureRecognizer;
@synthesize upSwipeGestureRecognizer = _upSwipeGestureRecognizer;

-(void) updateDbmValueLabelText:(NSString *)newString
{
    NSString* renderredString = [CaculatorModel renderValueStringWithThousandSeparator:newString];
    [self.dbmValueLabel setText:renderredString];
}

-(void) updateWattValueLabelText:(NSString *)newString
{
    NSString* renderredString = [CaculatorModel renderValueStringWithThousandSeparator:newString];
    [self.wattValueLabel setText:renderredString];
}

-(void) resetCaculatorStatus:(BOOL) status
{
    self.isDigitInDecimalPart = status;
    self.isUserInMiddleOfEnteringDigit = status;
}

-(void) decorateDbmValueLabel
{

}

-(void) decorateWattValueLabel
{

}

-(NSMutableArray *) caculatorButtons
{
    if (nil == _caculatorButtons)
    {
        _caculatorButtons = [NSMutableArray arrayWithCapacity:14];
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
        [_caculatorButtons addObject:self.delButton];
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

- (void) initSingleTapGestureRecognizer
{
    _singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureUpdated:)];
    _singleTapGestureRecognizer.delegate = self;
    _singleTapGestureRecognizer.numberOfTapsRequired = 1;
    _singleTapGestureRecognizer.numberOfTouchesRequired = 1;
//    [_singleTapGestureRecognizer requireGestureRecognizerToFail:_doubleTapGestureRecognizer];
    [self.screenView addGestureRecognizer:_singleTapGestureRecognizer];
}

- (void) initDoubleTapGestureRecognizer
{
    _doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestureUpdated:)];
    _doubleTapGestureRecognizer.delegate = self;
    _doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    [self.screenView addGestureRecognizer:_doubleTapGestureRecognizer];
}

- (void) initSwipeGestureRecognizers
{
    _leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeGestureUpdated:)];
    _leftSwipeGestureRecognizer.delegate = self;
    _leftSwipeGestureRecognizer.numberOfTouchesRequired = 1;
    _leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.screenView addGestureRecognizer:_leftSwipeGestureRecognizer];

    _rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeGestureUpdated:)];
    _rightSwipeGestureRecognizer.delegate = self;
    _rightSwipeGestureRecognizer.numberOfTouchesRequired = 1;
    _rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.screenView addGestureRecognizer:_rightSwipeGestureRecognizer];
    
    _downSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downSwipeGestureUpdated:)];
    _downSwipeGestureRecognizer.delegate = self;
    _downSwipeGestureRecognizer.numberOfTouchesRequired = 1;
    _downSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.screenView addGestureRecognizer:_downSwipeGestureRecognizer];
    
    _upSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upSwipeGestureUpdated:)];
    _upSwipeGestureRecognizer.delegate = self;
    _upSwipeGestureRecognizer.numberOfTouchesRequired = 1;
    _upSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [self.screenView addGestureRecognizer:_upSwipeGestureRecognizer];
}

- (void) initLongPressGestureRecognizer
{
    _longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureUpdated:)];
    _longPressGestureRecognizer.delegate = self;
    _longPressGestureRecognizer.minimumPressDuration = 0.5;
    [self.screenView addGestureRecognizer:_longPressGestureRecognizer];
}

- (void) switchWattUnit:(WattUnit)unit andInitStatus:(BOOL)isInInit
{
    if (!isInInit)
    {
        [self playButtonClickSound:self.switchButton];
    }
    
    if (self.currentWattUnit == unit)
    {
        return;
    }
    else
    {        
        if (self.isDbm2WattMode)
        {
            self.currentWattUnit = unit;
            NSNumber* dbmValue = [NSNumber numberWithDouble:self.currentInputValueString.doubleValue];
            double newWattValue = [CaculatorModel getWattValueFromDbmValue:dbmValue.doubleValue andUnit:self.currentWattUnit];
            NSString* rawString = [NSNumber numberWithDouble:newWattValue].stringValue;
            [self updateWattValueLabelText:rawString];
        }
        else
        {
            self.currentWattUnit = unit;
            NSNumber* wattValue = [NSNumber numberWithDouble:self.currentInputValueString.doubleValue];
            double dbmValue = [CaculatorModel getDbmValueFromWattValueWithUnit:wattValue.doubleValue andUnit:self.currentWattUnit];
            NSString* rawString = [NSNumber numberWithDouble:dbmValue].stringValue;
            [self updateDbmValueLabelText:rawString];
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
    self.isDbm2WattMode = FALSE;
    self.isNegativeStatus = FALSE;
    [self resetCaculatorStatus:FALSE];
    self.currentInputValueString = [NSMutableString stringWithCapacity:0];
    
    [self onSwitchButtonClicked:nil];
    
    [self decorateDbmValueLabel];
    [self decorateWattValueLabel];
    [self decorateFunctionButtons];
    [self decorateCaculatorButtons];

    [self initLongPressGestureRecognizer];
    [self initDoubleTapGestureRecognizer];
    [self initSingleTapGestureRecognizer];
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
    [self playButtonClickSound:sender];
    
    if ([self isDbm2WattMode])
    {
        self.isDbm2WattMode = FALSE;
        [sender setTitle:SWITCHMODE_WATT2DBM forState:UIControlStateNormal];
        
        self.dbmValueLabel.backgroundColor = [CaculatorUIStyle screenLabelBackgroundColor];
        self.wattValueLabel.backgroundColor = [CaculatorUIStyle focusedScreenLabelBackgroundColor];
    }
    else
    {
        self.isDbm2WattMode = TRUE;
        [sender setTitle:SWITCHMODE_DBM2WATT forState:UIControlStateNormal];

        self.dbmValueLabel.backgroundColor = [CaculatorUIStyle focusedScreenLabelBackgroundColor];
        self.wattValueLabel.backgroundColor = [CaculatorUIStyle screenLabelBackgroundColor];
    }
    
    [self onClearButtonClicked:nil];
}

- (IBAction)onSaveButtonClicked:(CaculatorButton *)sender
{
    [self playButtonClickSound:sender];
    
    CaculatorRecord* record = nil;
    
    if (self.isDbm2WattMode)
    {
        NSString* dbm = [NSNumber numberWithDouble:self.currentInputValueString.doubleValue].stringValue;
        NSString* renderredString = [CaculatorModel renderValueStringWithThousandSeparator:dbm];
        record = [[CaculatorRecord alloc] initWithDbmValue:renderredString wattValue:self.wattValueLabel.text wattUnit:self.currentWattUnit isDbm2Watt:self.isDbm2WattMode];
    }
    else
    {
        NSString* watt = [NSNumber numberWithDouble:self.currentInputValueString.doubleValue].stringValue;
        NSString* renderredString = [CaculatorModel renderValueStringWithThousandSeparator:watt];
        record = [[CaculatorRecord alloc] initWithDbmValue:self.dbmValueLabel.text wattValue:renderredString wattUnit:self.currentWattUnit isDbm2Watt:self.isDbm2WattMode];
    }

    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = [record toString];

    [self.caculatorModel addRecord:record];
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
    
    if (self.isDbm2WattMode)
    {
        if (self.isUserInMiddleOfEnteringDigit)
        {
            [self.currentInputValueString appendString:digit.stringValue];
            [self updateDbmValueLabelText:self.currentInputValueString];
        }
        else
        {
            if (0 != digit.doubleValue)
            {
                if (self.isNegativeStatus)
                {
                    [self.currentInputValueString replaceCharactersInRange:NSMakeRange(1, 1) withString:digit.stringValue];
                }
                else
                {
                    [self.currentInputValueString setString:digit.stringValue];                    
                }
                
                [self updateDbmValueLabelText:self.currentInputValueString];

                self.isUserInMiddleOfEnteringDigit = TRUE;
            }
        }
    }
    else
    {
        if (self.isUserInMiddleOfEnteringDigit)
        {
            [self.currentInputValueString appendString:digit.stringValue];
            [self updateWattValueLabelText:self.currentInputValueString];
        }
        else
        {
            [self.currentInputValueString setString:digit.stringValue];
            [self updateWattValueLabelText:self.currentInputValueString];
            
            if (0 != digit.intValue)
            {
                self.isUserInMiddleOfEnteringDigit = TRUE;
            }
        }
    }
    
    [self caculateDbmAndWattPlusUpdateScreenLabels];
}

- (IBAction)onNegativeButtonClicked:(CaculatorButton *)sender
{
    if (self.isDbm2WattMode)
    {
        if (self.isNegativeStatus)
        {
            NSRange deleteRange = NSMakeRange(0, 1);
            [self.currentInputValueString deleteCharactersInRange:deleteRange];
            [self updateDbmValueLabelText:self.currentInputValueString];
            
            self.isNegativeStatus = FALSE;
        }
        else
        {
            [self.currentInputValueString insertString:NEGATIVE_CHAR atIndex:0];
            [self updateDbmValueLabelText:self.currentInputValueString];
            
            self.isNegativeStatus = TRUE;
        }
        
        [self caculateDbmAndWattPlusUpdateScreenLabels];
    }
}

- (IBAction)onDotButtonClicked:(CaculatorButton *)sender
{
    if (!self.isDigitInDecimalPart)
    {
        [self.currentInputValueString appendString:DIGIT_DOT];
        if (self.isDbm2WattMode)
        {
            [self updateDbmValueLabelText:self.currentInputValueString];
        }
        else
        {
            [self updateWattValueLabelText:self.currentInputValueString];
        }

        [self resetCaculatorStatus:TRUE];
    }
}

- (IBAction)onDelButtonClicked:(CaculatorButton *)sender
{
    NSUInteger lengthBeforeDel = self.currentInputValueString.length;
    if (0 < lengthBeforeDel)
    {
        NSString* stringToBeDel = [self.currentInputValueString substringFromIndex:lengthBeforeDel - 1];
        if ([DIGIT_DOT isEqualToString: stringToBeDel])
        {
            self.isDigitInDecimalPart = FALSE;
        }
        
        [self.currentInputValueString deleteCharactersInRange:NSMakeRange(lengthBeforeDel - 1, 1)];

        NSUInteger lengthAfterDel = self.currentInputValueString.length;
        if (0 == lengthAfterDel)
        {
            [self onClearButtonClicked:self.clearButton];
            return;
        }
        else if (1 == lengthAfterDel)
        {
            if (self.isNegativeStatus)
            {
                [self onClearButtonClicked:self.clearButton];
                return;
            }
            
            if (self.isNegativeStatus || 0 == self.currentInputValueString.intValue)
            {
                self.isUserInMiddleOfEnteringDigit = FALSE;
            }
            
            self.isDigitInDecimalPart = FALSE;
        }
        else if (2 == lengthAfterDel)
        {
            if (self.isNegativeStatus)
            {
                self.isDigitInDecimalPart = FALSE;
                self.isUserInMiddleOfEnteringDigit = FALSE;
            }
        }
        
        if (self.isDbm2WattMode)
        {
            [self updateDbmValueLabelText:self.currentInputValueString];
        }
        else
        {
            [self updateWattValueLabelText:self.currentInputValueString];
        }
        
        [self caculateDbmAndWattPlusUpdateScreenLabels];
    }
}

- (void) caculateDbmAndWattPlusUpdateScreenLabels
{
    if (self.isDbm2WattMode)
    {
        NSNumber* newDbmValue = [NSNumber numberWithDouble:self.currentInputValueString.doubleValue];
        NSNumber* newWattValue = [NSNumber numberWithDouble:[CaculatorModel getWattValueFromDbmValue:newDbmValue.doubleValue andUnit:self.currentWattUnit]];
        [self updateWattValueLabelText:newWattValue.stringValue];
    }
    else
    {
        NSNumber* newWattValue = [NSNumber numberWithDouble:self.currentInputValueString.doubleValue];
        NSNumber* newDbmValue = [NSNumber numberWithDouble:[CaculatorModel getDbmValueFromWattValueWithUnit:newWattValue.doubleValue andUnit:self.currentWattUnit]];
        [self updateDbmValueLabelText:newDbmValue.stringValue];
    }
}

- (IBAction)onClearButtonClicked:(CaculatorButton *)sender
{
    if ([self isDbm2WattMode])
    {
        [self.currentInputValueString setString:DIGIT_0];
        [self updateDbmValueLabelText:self.currentInputValueString];

        double wattValue = [CaculatorModel getWattValueFromDbmValue:0 andUnit:self.currentWattUnit];
        [self updateWattValueLabelText:[NSNumber numberWithDouble:wattValue].stringValue];
    }
    else
    {
        [self.currentInputValueString setString:DIGIT_0];
        [self updateDbmValueLabelText:DIGIT_NEGATIVE_INFINITY];
        [self updateWattValueLabelText:self.currentInputValueString];
    }
    
    [self resetCaculatorStatus:FALSE];
    self.isNegativeStatus = FALSE;
}

- (IBAction)playButtonClickSound:(CaculatorButton *)sender
{
    if (nil == sender)
    {
        return;
    }
    else if (sender == self.switchButton)
    {
        [CaculatorResource playSwitchButtonClickSound];
    }
    else if (sender == self.saveButton)
    {
        [CaculatorResource playSaveButtonClickSound];
    }
    else if (sender == self.historyButton)
    {
        [CaculatorResource playHistoryButtonClickSound];
    }
    else if (sender == self.helpButton)
    {
        [CaculatorResource playHelpButtonClickSound];
    }
    else
    {
        [CaculatorResource playCaculatorButtonClickSound];
    }
}

- (void)singleTapGestureUpdated:(UITapGestureRecognizer *) recognizer
{
    CGPoint locationTouch = [recognizer locationInView:self.screenView];
    
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

- (void)doubleTapGestureUpdated:(UITapGestureRecognizer *) recognizer
{
    CGPoint locationTouch = [recognizer locationInView:self.screenView];
    
    if (CGRectContainsPoint(self.dbmValueLabel.frame, locationTouch))
    {
        if (!self.isDbm2WattMode)
        {
            [self onSwitchButtonClicked:self.switchButton];
        }
    }
    else if (CGRectContainsPoint(self.wattValueLabel.frame, locationTouch))
    {
        if (self.isDbm2WattMode)
        {
            [self onSwitchButtonClicked:self.switchButton];
        }
    }
}

- (void)leftSwipeGestureUpdated:(UISwipeGestureRecognizer *) recognizer
{
    CGPoint locationTouch = [recognizer locationInView:self.screenView];
    
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
    CGPoint locationTouch = [recognizer locationInView:self.screenView];
    
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

- (void)downSwipeGestureUpdated:(UISwipeGestureRecognizer *) recognizer
{
    CGPoint startLocation;
    CGPoint stopLocation;
    
    if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        startLocation = [recognizer locationInView:self.screenView];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        stopLocation = [recognizer locationInView:self.screenView];
    }
    
    if (CGRectContainsPoint(self.dbmValueLabel.frame, startLocation) && CGRectContainsPoint(self.wattValueLabel.frame, stopLocation))
    {
        // TODO:
    }
}

- (void)upSwipeGestureUpdated:(UISwipeGestureRecognizer *) recognizer
{
    CGPoint startLocation;
    CGPoint stopLocation;
    
    if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        startLocation = [recognizer locationInView:self.screenView];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        stopLocation = [recognizer locationInView:self.screenView];
    }
    
    if (CGRectContainsPoint(self.wattValueLabel.frame, startLocation) && CGRectContainsPoint(self.dbmValueLabel.frame, stopLocation))
    {
        // TODO:
    }
}

- (void)longPressGestureUpdated:(UILongPressGestureRecognizer *) recognizer
{    
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        CGPoint locationTouch = [recognizer locationInView:self.screenView];
        
        if ((CGRectContainsPoint(self.dbmValueLabel.frame, locationTouch)) || (CGRectContainsPoint(self.wattValueLabel.frame, locationTouch)))
        {
            [self onSaveButtonClicked:self.saveButton];
        }
    }
}

- (void)viewDidUnload
{
    [self setDbmValueLabel:nil];
    [self setWattValueLabel:nil];
    
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
    [self setDelButton:nil];
    [self setClearButton:nil];
    
    [self.screenView removeGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self setLeftSwipeGestureRecognizer:nil];
    [self.screenView removeGestureRecognizer:self.rightSwipeGestureRecognizer];
    [self setRightSwipeGestureRecognizer:nil];
    [self.screenView removeGestureRecognizer:self.singleTapGestureRecognizer];
    [self setSingleTapGestureRecognizer:nil];
    [self.screenView removeGestureRecognizer:self.longPressGestureRecognizer];
    [self setLongPressGestureRecognizer:nil];
    [self.screenView removeGestureRecognizer:self.downSwipeGestureRecognizer];
    [self setDownSwipeGestureRecognizer:nil];
    [self.screenView removeGestureRecognizer:self.upSwipeGestureRecognizer];
    [self setUpSwipeGestureRecognizer:nil];
    
    [self setCaculatorModel:nil];
    [self setCurrentInputValueString:nil];
    
    [self setScreenView:nil];
    [self setButtonsView:nil];
    [self setDelButton:nil];
    [super viewDidUnload];
}

@end
