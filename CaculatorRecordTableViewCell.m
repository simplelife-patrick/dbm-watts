//
//  CaculatorRecordTableViewCell.m
//  dbm-watt
//
//  Created by Patrick Deng on 13-3-2.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorRecordTableViewCell.h"

@interface CaculatorRecordTableViewCell()

@property (strong, nonatomic) UILabel* dbmValueLabel;
@property (strong, nonatomic) UILabel* wattValueLabel;
@property (strong, nonatomic) UIView* cellContentView;

-(void) updateDbmValue:(NSString*) dbm;
-(void) updateWattValue:(NSString*) watt andWattUnit:(WattUnit) unit;

@end

@implementation CaculatorRecordTableViewCell

@synthesize dbmValueLabel = _dbmValueLabel;
@synthesize wattValueLabel = _wattValueLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code

        _dbmValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 310, 50)];
        _dbmValueLabel.textAlignment = NSTextAlignmentLeft;
        _wattValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 55, 310, 50)];
        _wattValueLabel.textAlignment = NSTextAlignmentRight;
        
        _dbmValueLabel.font = [UIFont boldSystemFontOfSize:26];
        _wattValueLabel.font = [UIFont boldSystemFontOfSize:26];
        
        _dbmValueLabel.adjustsFontSizeToFitWidth = TRUE;
        _wattValueLabel.adjustsFontSizeToFitWidth = TRUE;

        _dbmValueLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _dbmValueLabel.layer.borderWidth = 1;
        _dbmValueLabel.layer.cornerRadius = 4;
        
        _wattValueLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _wattValueLabel.layer.borderWidth = 1;
        _wattValueLabel.layer.cornerRadius = 4;
        
        [self.contentView addSubview:_dbmValueLabel];
        [self.contentView addSubview:_wattValueLabel];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    UIView* view = [[UIView alloc] initWithFrame:self.contentView.bounds];
    [view setBackgroundColor:[CaculatorUIStyle caculatorButtonBackgroundColor]];
    [self setSelectedBackgroundView:view];
    
    if (selected)
    {
        [self.dbmValueLabel setBackgroundColor:[CaculatorUIStyle caculatorButtonBackgroundColor]];
        [self.wattValueLabel setBackgroundColor:[CaculatorUIStyle caculatorButtonBackgroundColor]];
    }
}

-(void) updateCellWithRecord:(CaculatorRecord *)record
{
    if (nil != record)
    {
        [self updateDbmValue:record.dbmValue];
        [self updateWattValue:record.wattValue andWattUnit:record.wattUnit];
        
        if (record.isDbm2Watt)
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
