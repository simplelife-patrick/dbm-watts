//
//  CaculatorScreenLabel.m
//  dbm-mw-caculator
//
//  Created by Patrick Deng on 13-2-13.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorScreenLabel.h"

@implementation CaculatorScreenLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
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
    self.adjustsFontSizeToFitWidth = YES;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = UI_SCREEN_LABEL_BORDERWIDTH;
    self.layer.cornerRadius = UI_SCREEN_LABEL_CORNERRADIUS;
    
    self.layer.backgroundColor = [CaculatorUIStyle screenLabelBackgroundColor].CGColor;
    
    // Super class drawing codes
    [super drawRect:rect];
}
//*/

@end
