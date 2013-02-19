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
@property (nonatomic, weak) NSMutableArray* caculatorButtons;
@property (nonatomic, weak) NSMutableArray* functionButtons;

-(void) resetCaculatorStatus:(BOOL) status;
-(void) enableNegativeButton:(BOOL) isEnabled;
-(void) decorateDbmValueLabel;
-(void) decorateMwValueLabel;
-(void) decorateCaculatorButtons;
-(void) decorateFunctionButtons;
-(void) initTapGestureRecognizer;
-(void) initSwipeGestureRecognizers;

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
        self.caculatorButtons = [NSMutableArray arrayWithCapacity:13];
        [self.caculatorButtons addObject:self.digit0Button];
        [self.caculatorButtons addObject:self.digit1Button];
        [self.caculatorButtons addObject:self.digit2Button];
        [self.caculatorButtons addObject:self.digit3Button];
        [self.caculatorButtons addObject:self.digit4Button];
        [self.caculatorButtons addObject:self.digit5Button];
        [self.caculatorButtons addObject:self.digit6Button];
        [self.caculatorButtons addObject:self.digit7Button];
        [self.caculatorButtons addObject:self.digit8Button];
        [self.caculatorButtons addObject:self.digit9Button];
        [self.caculatorButtons addObject:self.dotButton];
        [self.caculatorButtons addObject:self.negativeButton];
        [self.caculatorButtons addObject:self.clearButton];
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
        self.functionButtons = [NSMutableArray arrayWithCapacity:4];
        [self.functionButtons addObject:self.switchButton];
        [self.functionButtons addObject:self.saveButton];
        [self.functionButtons addObject:self.historyButton];
        [self.functionButtons addObject:self.helpButton];
    }
    
    return _functionButtons;
}

-(void) decorateFunctionButtons
{    

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
        self.mwValueLabel.backgroundColor = [CaculatorUIStyle focusedScreenLabelBackgroundColor];
    }
    else
    {
        self.isDbm2MwMode = TRUE;
        [sender setTitle:SWITCHMODE_DBM2MW forState:UIControlStateNormal];
        
        [self enableNegativeButton:TRUE];

        self.dbmValueLabel.backgroundColor = [CaculatorUIStyle focusedScreenLabelBackgroundColor];
        self.mwValueLabel.backgroundColor = [CaculatorUIStyle screenLabelBackgroundColor];
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

- (IBAction)playButtonClickSound:(CaculatorButton *)sender
{
    [CaculatorResource playButtonClickSound];
}

- (void)tapGestureUpdated:(UITapGestureRecognizer *) recognizer
{
    CGPoint locationTouch = [self.tapGestureRecognizer locationInView:self.view];
    
    if (CGRectContainsPoint(self.dbmValueLabel.frame, locationTouch))
    {
        NSLog(@"Tap DBM Label.");
    }
    else if (CGRectContainsPoint(self.mwValueLabel.frame, locationTouch))
    {
        NSLog(@"Tap MW Label.");
    }
}

- (void)leftSwipeGestureUpdated:(UISwipeGestureRecognizer *) recognizer
{
    CGPoint locationTouch = [recognizer locationInView:self.view];
    
    if (CGRectContainsPoint(self.dbmValueLabel.frame, locationTouch))
    {
        NSLog(@"LeftSwipe DBM Label.");
    }
    else if (CGRectContainsPoint(self.mwValueLabel.frame, locationTouch))
    {
        NSLog(@"LeftSwipe MW Label.");        
    }
}

- (void)rightSwipeGestureUpdated:(UISwipeGestureRecognizer *) recognizer
{
    CGPoint locationTouch = [recognizer locationInView:self.view];
    
    if (CGRectContainsPoint(self.dbmValueLabel.frame, locationTouch))
    {
        NSLog(@"RightSwipe DBM Label.");        
    }
    else if (CGRectContainsPoint(self.mwValueLabel.frame, locationTouch))
    {
        NSLog(@"RightSwipe MW Label.");        
    }
}


@end
