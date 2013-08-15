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
@property (nonatomic) BOOL isDigitInFractionalPart;
@property (nonatomic) BOOL isNegativeStatus;
@property (nonatomic, strong) NSMutableArray* caculatorButtons;
@property (nonatomic, strong) NSMutableArray* hexCaculatorButtons;
@property (nonatomic, strong) NSMutableArray* decCaculatorButtons;
@property (nonatomic, strong) NSMutableArray* specialCaculatorButtons;
@property (nonatomic, strong) NSMutableArray* functionButtons;
@property (nonatomic, strong) NSMutableArray* wattUnitTextLabels;

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

-(void) resetCaculatorStatus:(BOOL) status;

-(void) initSingleTapGestureRecognizer;
-(void) initDoubleTapGestureRecognizer;
-(void) initSwipeGestureRecognizers;
-(void) initLongPressGestureRecognizer;
-(void) switchWattUnit:(WattUnit) unit andInitStatus:(BOOL) isInInit;
-(void) switchWattUnit:(WattUnit) unit;
-(void) updateDbmValueLabelText:(NSString*) newString;
-(void) updateWattValueLabelText:(NSString*) newString;
-(void) caculateDbmAndWattPlusUpdateScreenLabels;
-(BOOL) appendCurrentInputString:(NSString*) string;

@end

@implementation CaculatorViewController

@synthesize caculatorResultModel = _caculatorResultModel;
@synthesize isDbm2WattMode;
@synthesize currentNotation = _currentNotation;
@synthesize isUserInMiddleOfEnteringDigit;
@synthesize isNegativeStatus;

@synthesize currentWattUnit = _currentWattUnits;
@synthesize currentInputValueObject = _currentInputValueObject;

@synthesize screenView = _screenView;
@synthesize buttonsView = _buttonsView;
@synthesize dbmValueLabel = _dbmValueLabel;
@synthesize wattValueLabel = _wattValueLabel;

@synthesize dbmTipLabel = _dbmTipLabel;
@synthesize wattTipLabel = _wattTipLabel;

@synthesize versionLabel = _versionLabel;

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
@synthesize notationButton = _formatButton;

@synthesize caculatorButtons = _caculatorButtons;
@synthesize hexCaculatorButtons = _hexCaculatorButtons;
@synthesize decCaculatorButtons = _decCaculatorButtons;
@synthesize specialCaculatorButtons = _specialCaculatorButtons;
@synthesize functionButtons = _functionButtons;
@synthesize wattUnitTextLabels = _wattUnitTextLabels;

@synthesize singleTapGestureRecognizer = _singleTapGestureRecognizer;
@synthesize doubleTapGestureRecognizer = _doubleTapGestureRecognizer;
@synthesize leftSwipeGestureRecognizer = _leftSwipeGestureRecognizer;
@synthesize rightSwipeGestureRecognizer = _rightSwipeGestureRecognizer;
@synthesize longPressGestureRecognizer = _longPressGestureRecognizer;
@synthesize downSwipeGestureRecognizer = _downSwipeGestureRecognizer;
@synthesize upSwipeGestureRecognizer = _upSwipeGestureRecognizer;

-(BOOL) appendCurrentInputString:(NSString *)string
{
    BOOL appendSuccess = FALSE;
    
    if (nil != string && string.length > 0)
    {
        NSInteger limit = 0;

        if (self.currentNotation == DecNotation)
        {
            limit = (self.isNegativeStatus) ? DecBitsLength + 1 : DecBitsLength; //TODO:
        }
        else
        {
            limit = 16;
        }
        
        if (limit > self.currentInputValueObject.length)
        {
            [self.currentInputValueObject appendString:string];
            appendSuccess = TRUE;
        }
    }
    
    return appendSuccess;
}

-(void) updateDbmValueLabelText:(NSString *)newString
{
    NSString* renderredString = [CaculatorResultModel renderValueStringWithThousandSeparator:newString];
    [self.dbmValueLabel setText:renderredString];
}

-(void) updateWattValueLabelText:(NSString *)newString
{
    NSString* renderredString = [CaculatorResultModel renderValueStringWithThousandSeparator:newString];
    [self.wattValueLabel setText:renderredString];
}

-(void) resetCaculatorStatus:(BOOL) status
{
    self.isDigitInFractionalPart = status;
    self.isUserInMiddleOfEnteringDigit = status;
}

-(NSMutableArray *) specialCaculatorButtons
{
    if (nil == _specialCaculatorButtons)
    {
        _specialCaculatorButtons = [NSMutableArray arrayWithCapacity:2];
        [_specialCaculatorButtons addObject:self.dotButton];
        [_specialCaculatorButtons addObject:self.negativeButton];
        [_specialCaculatorButtons addObject:self.delButton];
        self.delButton.isEmphasized = TRUE;
        [_specialCaculatorButtons addObject:self.clearButton];
        self.clearButton.isEmphasized = TRUE;
    }
    
    return _specialCaculatorButtons;
}

-(NSMutableArray *) decCaculatorButtons
{
    if (nil == _decCaculatorButtons)
    {
        _decCaculatorButtons = [NSMutableArray arrayWithCapacity:10];
        [_decCaculatorButtons addObject:self.digit0Button];
        [_decCaculatorButtons addObject:self.digit1Button];
        [_decCaculatorButtons addObject:self.digit2Button];
        [_decCaculatorButtons addObject:self.digit3Button];
        [_decCaculatorButtons addObject:self.digit4Button];
        [_decCaculatorButtons addObject:self.digit5Button];
        [_decCaculatorButtons addObject:self.digit6Button];
        [_decCaculatorButtons addObject:self.digit7Button];
        [_decCaculatorButtons addObject:self.digit8Button];
        [_decCaculatorButtons addObject:self.digit9Button];
    }
    
    return _decCaculatorButtons;
}

-(NSMutableArray *) hexCaculatorButtons
{
    if (nil == _hexCaculatorButtons)
    {
        _hexCaculatorButtons = [NSMutableArray arrayWithCapacity:6];
    }
    
    return _hexCaculatorButtons;
}

-(NSMutableArray *) caculatorButtons
{
    if (nil == _caculatorButtons)
    {
        _caculatorButtons = [NSMutableArray arrayWithCapacity:20];
        
        [_caculatorButtons addObjectsFromArray:self.decCaculatorButtons];
        [_caculatorButtons addObjectsFromArray:self.hexCaculatorButtons];
        [_caculatorButtons addObjectsFromArray:self.specialCaculatorButtons];
    }
    
    return _caculatorButtons;
}

-(NSMutableArray *) functionButtons
{
    if (nil == _functionButtons)
    {
        _functionButtons = [NSMutableArray arrayWithCapacity:5];
        [_functionButtons addObject:self.switchButton];
        [_functionButtons addObject:self.notationButton];
        [_functionButtons addObject:self.saveButton];
        [_functionButtons addObject:self.historyButton];
        [_functionButtons addObject:self.helpButton];
    }
    
    return _functionButtons;
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
            NSNumber* dbmValue = [NSNumber numberWithDouble:self.currentInputValueObject.doubleValue];
            double newWattValue = [CaculatorResultModel getWattValueFromDbmValue:dbmValue.doubleValue andUnit:self.currentWattUnit];
            NSString* rawString = [CaculatorUIStyle formatDoubleToString:newWattValue];
            [self updateWattValueLabelText:rawString];
        }
        else
        {
            self.currentWattUnit = unit;
            NSNumber* wattValue = [NSNumber numberWithDouble:self.currentInputValueObject.doubleValue];
            double dbmValue = [CaculatorResultModel getDbmValueFromWattValueWithUnit:wattValue.doubleValue andUnit:self.currentWattUnit];
            NSString* rawString = [CaculatorUIStyle formatDoubleToString:dbmValue];
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

- (CaculatorResultModel *) caculatorResultModel
{
    if (nil == _caculatorResultModel)
    {
        _caculatorResultModel = [[CaculatorResultModel alloc] init];
    }
    
    return _caculatorResultModel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:TRUE];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.isDbm2WattMode = FALSE;
    self.isNegativeStatus = FALSE;
    self.currentNotation = DecNotation;
    [self resetCaculatorStatus:FALSE];
    self.currentInputValueObject = [[CaculatorValue alloc] init];
    
    [self initLongPressGestureRecognizer];
    [self initDoubleTapGestureRecognizer];
    [self initSingleTapGestureRecognizer];
    [self initSwipeGestureRecognizers];

    [self onSwitchButtonClicked:nil];
    [self switchWattUnit:mW andInitStatus:TRUE];
    
    NSString* versionStr = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"];
    _versionLabel.text = versionStr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSwitchButtonClicked:(CaculatorButton *)sender
{
    if ([self isDbm2WattMode])
    {
        self.isDbm2WattMode = FALSE;
        [sender setTitle:SWITCHMODE_DBM2WATT forState:UIControlStateNormal];
        self.dbmValueLabel.backgroundColor = [CaculatorUIStyle screenLabelBackgroundColor];
        self.wattValueLabel.backgroundColor = [CaculatorUIStyle focusedScreenLabelBackgroundColor];
        [self.negativeButton disableButton];
        
        [_dbmTipLabel setHidden:YES];
        [_wattTipLabel setHidden:NO];
    }
    else
    {
        self.isDbm2WattMode = TRUE;
        [sender setTitle:SWITCHMODE_WATT2DBM forState:UIControlStateNormal];
        self.dbmValueLabel.backgroundColor = [CaculatorUIStyle focusedScreenLabelBackgroundColor];
        self.wattValueLabel.backgroundColor = [CaculatorUIStyle screenLabelBackgroundColor];
        [self.negativeButton enableButton];
        
        [_dbmTipLabel setHidden:NO];
        [_wattTipLabel setHidden:YES];
    }
    
    [self onClearButtonClicked:nil];
}

- (IBAction)onSaveButtonClicked:(CaculatorButton *)sender
{
    CaculatorResult* record = nil;
    
    if (self.isDbm2WattMode)
    {
        NSString* str = self.currentInputValueObject.valueString;
        NSString* dbm = [CaculatorUIStyle formatDoubleToString:str.doubleValue];
        
        NSString* renderredString = [CaculatorResultModel renderValueStringWithThousandSeparator:dbm];
        record = [[CaculatorResult alloc] initWithDbmValue:renderredString wattValue:self.wattValueLabel.text wattUnit:self.currentWattUnit isDbm2Watt:self.isDbm2WattMode];
    }
    else
    {
        NSString* watt = self.currentInputValueObject.valueString;
        NSString* renderredString = [CaculatorResultModel renderValueStringWithThousandSeparator:watt];
        record = [[CaculatorResult alloc] initWithDbmValue:self.dbmValueLabel.text wattValue:renderredString wattUnit:self.currentWattUnit isDbm2Watt:self.isDbm2WattMode];
    }

    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = [record description];

    [self.caculatorResultModel addRecord:record];
}

- (IBAction)onHistoryButtonClicked:(CaculatorButton *)sender
{
    
}

- (IBAction)onHelpButtonClicked:(CaculatorButton *)sender
{
    
}

- (IBAction)onNotationButtonClicked:(CaculatorButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:NOTATION_HEX])
    {
        [self setCurrentNotation:HexNotation];
        [sender setTitle:NOTATION_DEC forState:UIControlStateNormal];
    }
    else if ([sender.titleLabel.text isEqualToString:NOTATION_DEC])
    {
        [self setCurrentNotation:DecNotation];
        [sender setTitle:NOTATION_HEX forState:UIControlStateNormal];
    }
}

- (IBAction)onDigitButtonClicked:(CaculatorButton *)sender
{
    NSNumber* digit = [NSNumber numberWithDouble:sender.currentTitle.intValue];
    
    if (self.isDbm2WattMode)
    {
        if (self.isUserInMiddleOfEnteringDigit)
        {
            BOOL appendSuccess = [self appendCurrentInputString:digit.stringValue];
            if (appendSuccess)
            {
                [self updateDbmValueLabelText:self.currentInputValueObject.valueString];
            }
        }
        else
        {
            if (0 != digit.doubleValue)
            {
                if (self.isNegativeStatus)
                {
                    [self.currentInputValueObject replaceStringInRange:NSMakeRange(1, 1) withString:digit.stringValue];
                }
                else
                {
                    [self.currentInputValueObject setString:digit.stringValue];
                }
                [self updateDbmValueLabelText:self.currentInputValueObject.valueString];
                self.isUserInMiddleOfEnteringDigit = TRUE;
            }
        }
    }
    else
    {
        if (self.isUserInMiddleOfEnteringDigit)
        {
            BOOL appendSuccess = [self appendCurrentInputString:digit.stringValue];
            if (appendSuccess)
            {
                [self updateWattValueLabelText:self.currentInputValueObject.valueString];
            }
        }
        else
        {
            [self.currentInputValueObject setString:digit.stringValue];
            [self updateWattValueLabelText:self.currentInputValueObject.valueString];
            
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
            [self.currentInputValueObject deleteStringInRange:deleteRange];
            [self updateDbmValueLabelText:self.currentInputValueObject.valueString];
            
            self.isNegativeStatus = FALSE;
        }
        else
        {
            [self.currentInputValueObject insertString:NEGATIVE_CHAR atIndex:0];
            [self updateDbmValueLabelText:self.currentInputValueObject.valueString];
            
            self.isNegativeStatus = TRUE;
        }
        
        [self caculateDbmAndWattPlusUpdateScreenLabels];
    }
}

- (IBAction)onDotButtonClicked:(CaculatorButton *)sender
{
    if (!self.isDigitInFractionalPart)
    {
        BOOL appendSuccess = [self appendCurrentInputString:DIGIT_DOT];
        if (self.isDbm2WattMode)
        {
            [self updateDbmValueLabelText:self.currentInputValueObject.valueString];
        }
        else
        {
            [self updateWattValueLabelText:self.currentInputValueObject.valueString];
        }
        
        [self resetCaculatorStatus:appendSuccess];
    }
}

- (IBAction)onDelButtonClicked:(CaculatorButton *)sender
{
    NSUInteger lengthBeforeDel = self.currentInputValueObject.length;
    if (0 < lengthBeforeDel)
    {
        NSString* stringToBeDel = [self.currentInputValueObject substringFromIndex:lengthBeforeDel - 1];
        if ([DIGIT_DOT isEqualToString: stringToBeDel])
        {
            self.isDigitInFractionalPart = FALSE;
        }
        
        [_currentInputValueObject deleteStringInRange:NSMakeRange(lengthBeforeDel - 1, 1)];
        
        NSUInteger lengthAfterDel = self.currentInputValueObject.length;
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
            if (self.isNegativeStatus || 0 == self.currentInputValueObject.intValue)
            {
                self.isUserInMiddleOfEnteringDigit = FALSE;
            }
            self.isDigitInFractionalPart = FALSE;
        }
        else if (2 == lengthAfterDel)
        {
            if (self.isNegativeStatus)
            {
                self.isDigitInFractionalPart = FALSE;
                self.isUserInMiddleOfEnteringDigit = FALSE;
            }
        }
        
        if (self.isDbm2WattMode)
        {
            [self updateDbmValueLabelText:self.currentInputValueObject.valueString];
        }
        else
        {
            [self updateWattValueLabelText:self.currentInputValueObject.valueString];
        }
        
        [self caculateDbmAndWattPlusUpdateScreenLabels];
    }
}

- (void) caculateDbmAndWattPlusUpdateScreenLabels
{
    if (self.isDbm2WattMode)
    {
        NSNumber* newDbmValue = [NSNumber numberWithDouble:self.currentInputValueObject.doubleValue];
        double newWattValue = [CaculatorResultModel getWattValueFromDbmValue:newDbmValue.doubleValue andUnit:self.currentWattUnit];
        [self updateWattValueLabelText:[CaculatorUIStyle formatDoubleToString:newWattValue]];
    }
    else
    {
        NSNumber* newWattValue = [NSNumber numberWithDouble:self.currentInputValueObject.doubleValue];
        double newDbmValue = [CaculatorResultModel getDbmValueFromWattValueWithUnit:newWattValue.doubleValue andUnit:self.currentWattUnit];
        [self updateDbmValueLabelText:[CaculatorUIStyle formatDoubleToString:newDbmValue]];
    }
}

- (IBAction)onClearButtonClicked:(CaculatorButton *)sender
{
    if ([self isDbm2WattMode])
    {
        [self.currentInputValueObject setString:DIGIT_0];
        [self updateDbmValueLabelText:self.currentInputValueObject.valueString];
        
        double wattValue = [CaculatorResultModel getWattValueFromDbmValue:0 andUnit:self.currentWattUnit];
        [self updateWattValueLabelText:[CaculatorUIStyle formatDoubleToString:wattValue]];
    }
    else
    {
        [self.currentInputValueObject setString:DIGIT_0];
        [self updateDbmValueLabelText:DIGIT_NEGATIVE_INFINITY];
        [self updateWattValueLabelText:self.currentInputValueObject.valueString];
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
    else if (sender == self.notationButton)
    {
        [CaculatorResource playFormatButtonClickSound];
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
            [self playButtonClickSound:self.switchButton];
            [self onSwitchButtonClicked:self.switchButton];
        }
    }
    else if (CGRectContainsPoint(self.wattValueLabel.frame, locationTouch))
    {
        if (self.isDbm2WattMode)
        {
            [self playButtonClickSound:self.switchButton];
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
    
//    if (CGRectContainsPoint(self.dbmValueLabel.frame, startLocation) && CGRectContainsPoint(self.wattValueLabel.frame, stopLocation))
//    {
//        // TODO:
//    }
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
    
//    if (CGRectContainsPoint(self.wattValueLabel.frame, startLocation) && CGRectContainsPoint(self.dbmValueLabel.frame, stopLocation))
//    {
//        // TODO:
//    }
}

- (void)longPressGestureUpdated:(UILongPressGestureRecognizer *) recognizer
{    
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        CGPoint locationTouch = [recognizer locationInView:self.screenView];
        
        if ((CGRectContainsPoint(self.dbmValueLabel.frame, locationTouch)) || (CGRectContainsPoint(self.wattValueLabel.frame, locationTouch)))
        {
            [self playButtonClickSound:self.saveButton];
            [self onSaveButtonClicked:self.saveButton];
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[CaculatorResultTableViewController class]])
    {
        CaculatorResultTableViewController* recordTableViewController = segue.destinationViewController;
        [recordTableViewController setCaculatorResultModel:self.caculatorResultModel];
    }
    else if ([segue.destinationViewController isKindOfClass:[CaculatorHelpViewController class]])
    {
        
    }
}

-(void) setCurrentNotation:(Notation) notation
{
    _currentNotation = notation;

    for (CaculatorButton* button in self.caculatorButtons)
    {
        [button disableButton];
    }
    
    switch (notation)
    {
        case DecNotation:
        {
            for (CaculatorButton* button in self.decCaculatorButtons)
            {
                [button enableButton];
            }
            for (CaculatorButton* button in self.specialCaculatorButtons)
            {
                [button enableButton];
            }
            break;
        }
        case HexNotation:
        {
            for (CaculatorButton* button in self.caculatorButtons)
            {
                [button enableButton];
            }
            [self.negativeButton disableButton];
            [self.dotButton disableButton];
            break;
        }
        default:
        {
            break;
        }
    }
}

- (void)viewDidUnload
{
    [self setVersionLabel:nil];
    [self setDbmTipLabel:nil];
    [self setWattTipLabel:nil];
    [super viewDidUnload];
}

@end
