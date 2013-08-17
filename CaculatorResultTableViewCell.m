//
//  CaculatorResultTableViewCell.m
//  dbm-watt
//
//  Created by Patrick Deng on 13-3-2.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorResultTableViewCell.h"

@interface CaculatorResultTableViewCell()
{
    UIView* _selectedBackgroundView;
}

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
        
        if (nil == _selectedBackgroundView)
        {
            CGRect rect = self.contentView.bounds;
            _selectedBackgroundView = [[UIView alloc] initWithFrame:rect];
            [_selectedBackgroundView setBackgroundColor:[UIColor whiteColor]];
        }
        [self setSelectedBackgroundView:_selectedBackgroundView];
        
        _wattValueLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _dbmValueLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    _dbmValueLabel.frame = CGRectMake(0.0f, 0.0f, self.contentRect.size.width, self.contentRect.size.height); // Adjust as needed
//    _wattValueLabel.frame = CGRectMake(0.0f, 0.0f, self.contentRect.size.width, self.contentRect.size.height); // Adjust as needed
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected)
    {
        [_dbmValueLabel setBackgroundColor:[CaculatorUIStyle caculatorButtonNormalBackgroundColor]];
        [_wattValueLabel setBackgroundColor:[CaculatorUIStyle caculatorButtonNormalBackgroundColor]];

        [self setSelectedBackgroundView:_selectedBackgroundView];
    }
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
