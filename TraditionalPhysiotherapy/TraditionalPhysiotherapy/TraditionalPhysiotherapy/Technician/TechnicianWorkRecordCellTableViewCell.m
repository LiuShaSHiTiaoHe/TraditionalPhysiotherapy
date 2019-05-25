//
//  TechnicianWorkRecordCellTableViewCell.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/31.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "TechnicianWorkRecordCellTableViewCell.h"

@implementation TechnicianWorkRecordCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        timeLabel= [[UILabel alloc] init];
        timeLabel.font = [UIFont systemFontOfSize:26];
        [timeLabel setTextColor:[UIColor darkGrayColor]];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        [timeLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:timeLabel];
        
        projectNameLabel = [[UILabel alloc] init];
        projectNameLabel.font = [UIFont systemFontOfSize:26];
        [projectNameLabel setTextColor:[UIColor lightGrayColor]];
        projectNameLabel.textAlignment = NSTextAlignmentCenter;
        [projectNameLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:projectNameLabel];
        
        priceLabel = [[UILabel alloc] init];
        priceLabel.font = [UIFont systemFontOfSize:26];
        [priceLabel setTextColor:[UIColor lightGrayColor]];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        [priceLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:priceLabel];
        
        userLabel = [[UILabel alloc] init];
        userLabel.font = [UIFont systemFontOfSize:26];
        [userLabel setTextColor:[UIColor lightGrayColor]];
        userLabel.textAlignment = NSTextAlignmentCenter;
        userLabel.adjustsFontSizeToFitWidth = YES;
        [userLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:userLabel];
        
        
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).offset(20);
//            make.right.equalTo(self.mas_right).offset(-400);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(80);
            make.width.equalTo(300);

        }];
        
        [projectNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(timeLabel.mas_right);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(180);
            make.width.equalTo(280);
        }];
        
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(180);
            make.left.equalTo(projectNameLabel.mas_right);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(80);
        }];
        
        [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(priceLabel.mas_right).offset(-30);
            make.right.equalTo(self.mas_right);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(80);
        }];
        
    }
    return self;
}

-(void)setProjectListInfo:(NSDictionary *)infoDic;
{
    timeLabel.text = [infoDic objectForKey:@"recordtime"];
    projectNameLabel.text = [infoDic objectForKey:@"projectname"];
    priceLabel.text = [infoDic objectForKey:@"projectprice"];
    userLabel.text = [infoDic objectForKey:@"username"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
