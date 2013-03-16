//
//  CaculatorResultTableViewCell.m
//  dbm-watt
//
//  Created by Patrick Deng on 13-3-2.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorResultTableViewCell.h"

@interface CaculatorResultTableViewCell()

@property (strong, nonatomic) UILabel* dbmValueLabel;
@property (strong, nonatomic) UILabel* wattValueLabel;
@property (strong, nonatomic) UIView* cellContentView;

-(void) updateDbmValue:(NSString*) dbm;
-(void) updateWattValue:(NSString*) watt andWattUnit:(WattUnit) unit;

@end

@implementation CaculatorResultTableViewCell

@synthesize dbmValueLabel = _dbmValueLabel;
@synthesize wattValueLabel = _wattValueLabel;

- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        _dbmValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 310, 30)];
        _dbmValueLabel.textAlignment = NSTextAlignmentLeft;
        _wattValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 35, 310, 30)];
        _wattValueLabel.textAlignment = NSTextAlignmentRight;
        
        _dbmValueLabel.font = [UIFont systemFontOfSize:UI_TABLECELL_FONT_SIZE];
        _wattValueLabel.font = [UIFont systemFontOfSize:UI_TABLECELL_FONT_SIZE];
        
        _dbmValueLabel.adjustsFontSizeToFitWidth = TRUE;
        _wattValueLabel.adjustsFontSizeToFitWidth = TRUE;

        _dbmValueLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _dbmValueLabel.layer.borderWidth = 1;
        _dbmValueLabel.layer.cornerRadius = 3;
        
        _wattValueLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _wattValueLabel.layer.borderWidth = 1;
        _wattValueLabel.layer.cornerRadius = 3;
        
        [self.contentView addSubview:_dbmValueLabel];
        [self.contentView addSubview:_wattValueLabel];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    CGRect rect = self.contentView.bounds;
    UIView* view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:[CaculatorUIStyle caculatorButtonNormalBackgroundColor]];
    [self setSelectedBackgroundView:view];
}

-(void) updateCellWithResult:(CaculatorResult *)result
{
    if (nil != result)
    {
        [self updateDbmValue:result.dbmValue];
        [self updateWattValue:result.wattValue andWattUnit:result.wattUnit];
        
        if (result.isDbm2Watt)
        {
            [self.dbmValueLabel setBackgroundColor:[CaculatorUIStyle focusedScreenLabelBackgroundColor]];
            [self.wattValueLabel setBackgroundColor:[CaculatorUIStyle screenLabelBackgroundColor]];
        }
        else
        {
            [self.dbmValueLabel setBackgroundColor:[CaculatorUIStyle screenLabelBackgroundColor]];
            [self.wattValueLabel setBackgroundColor:[CaculatorUIStyle focusedScreenLabelBackgroundColor]];
        }
    }
}

-(void) updateDbmValue:(NSString*) dbm
{
    NSMutableString* text = [NSMutableString stringWithString:dbm];
    [text appendString:SPACE_CHAR];
    [text appendString:DBM];
    [self.dbmValueLabel setText:text];
}

-(void) updateWattValue:(NSString*) watt andWattUnit:(WattUnit) unit
{
    NSMutableString* text = [NSMutableString stringWithString:watt];
    [text appendString:SPACE_CHAR];
    [text appendString:[CaculatorUIStyle wattUnitString:unit]];
    [self.wattValueLabel setText:text];
}

@end
