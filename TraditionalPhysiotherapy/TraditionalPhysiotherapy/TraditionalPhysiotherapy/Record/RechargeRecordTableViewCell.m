//
//  RechargeRecordTableViewCell.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/6/4.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "RechargeRecordTableViewCell.h"

@implementation RechargeRecordTableViewCell
@synthesize timeLabel,numLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        timeLabel = [[UILabel alloc] init];
        timeLabel.font = [UIFont systemFontOfSize:22];
        timeLabel.textColor = [UIColor colorWithHexString:@"1296db"];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:timeLabel];
        
        numLabel = [[UILabel alloc] init];
        numLabel.font = [UIFont systemFontOfSize:22];
        numLabel.textColor = [UIColor blackColor];
        numLabel.textAlignment = NSTextAlignmentRight;
        numLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:numLabel];
        
        
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).offset(40);
            make.centerY.equalTo(self.mas_centerY);
            make.width.equalTo(200.);
            make.height.equalTo(40.);
        }];
        
        [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(timeLabel.mas_right).offset(20.);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(40.);
            make.right.equalTo(self.mas_right).offset(-20);
        }];
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
