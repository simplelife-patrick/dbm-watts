//
//  CaculatorButton.m
//  dbm-mw-caculator
//
//  Created by Patrick Deng on 13-2-13.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorButton.h"

@interface CaculatorButton()

@end

@implementation CaculatorButton

@synthesize isEmphasized = _isEmphasized;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        //   [notes addTarget:self action:@selector(sb) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
- (void)drawRect:(CGRect)rect
{
    // Self drawing codes
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = UI_CACULATOR_BUTTON_BORDERWIDTH;
    self.layer.cornerRadius = UI_CACULATOR_BUTTON_CORNERRADIUS;

    self.layer.backgroundColor = [CaculatorUIStyle caculatorButtonNormalBackgroundColor].CGColor;

    [self setExclusiveTouch:TRUE];
    
    // Super class drawing codes
    [super drawRect:rect];
}
//*/

-(void) disableButton
{
    self.enabled = FALSE;
}

-(void) enableButton
{
    self.enabled = TRUE;
}

-(void) emphasizeButton
{
    self.titleLabel.textColor = [UIColor redColor];
}

-(void) setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (highlighted)
    {
        [self setBackgroundColor:[UIColor darkGrayColor]];
    }
    else
    {
        [self setBackgroundColor:[CaculatorUIStyle caculatorButtonNormalBackgroundColor]];
    }
}

@end
