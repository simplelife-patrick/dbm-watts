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

        _dbmValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 310, 50)];
        _wattValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 50, 310, 50)];
        
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
//
//    // Configure the view for the selected state
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

-(void) updateCellWithRecord:(CaculatorRecord *)record
{
    if (nil != record)
    {
        [self updateDbmValue:record.dbmValue];
        [self updateWattValue:record.wattValue andWattUnit:record.wattUnit];
        
//        if (record.isDbm2Watt)
//        {
//            [self.dbmValueLabel setBackgroundColor:[CaculatorUIStyle focusedScreenLabelBackgroundColor]];
//            [self.wattValueLabel setBackgroundColor:[CaculatorUIStyle screenLabelBackgroundColor]];
//        }
//        else
//        {
//            [self.dbmValueLabel setBackgroundColor:[CaculatorUIStyle screenLabelBackgroundColor]];
//            [self.wattValueLabel setBackgroundColor:[CaculatorUIStyle focusedScreenLabelBackgroundColor]];
//        }
        
        [self.dbmValueLabel setBackgroundColor:[CaculatorUIStyle caculatorButtonBackgroundColor]];
        [self.wattValueLabel setBackgroundColor:[CaculatorUIStyle caculatorButtonBackgroundColor]];
    }
}

-(void) updateDbmValue:(NSString*) dbm
{
    NSMutableString* text = [NSMutableString stringWithString:DBM];
    [text appendString:COLON_CHAR];
    [text appendString:dbm];
    [self.dbmValueLabel setText:text];
}

-(void) updateWattValue:(NSString*) watt andWattUnit:(WattUnit) unit
{
    NSMutableString* text = [NSMutableString stringWithString:[CaculatorUIStyle wattUnitString:unit]];
    [text appendString:COLON_CHAR];
    [text appendString:watt];
    [self.wattValueLabel setText:text];
}

@end
