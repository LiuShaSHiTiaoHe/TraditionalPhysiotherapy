//
//  BillDetailPayMentCell.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/4/26.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "BillDetailPayMentCell.h"
#import "ProjectInfo.h"
#import "OrderRecordInfo.h"
#import "TechnicianInfo.h"
@implementation BillDetailPayMentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        nameLabel= [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:18];
        [nameLabel setTextColor:[UIColor darkGrayColor]];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:nameLabel];
        
        priceLabel = [[UILabel alloc] init];
        priceLabel.font = [UIFont systemFontOfSize:16];
        [priceLabel setTextColor:[UIColor lightGrayColor]];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        [priceLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:priceLabel];
        
        countLabel = [[UILabel alloc] init];
        countLabel.font = [UIFont systemFontOfSize:16];
        [countLabel setTextColor:[UIColor lightGrayColor]];
        countLabel.textAlignment = NSTextAlignmentLeft;
        [countLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:countLabel];
        
        technicianLabel = [[UILabel alloc] init];
        technicianLabel.font = [UIFont systemFontOfSize:16];
        [technicianLabel setTextColor:[UIColor lightGrayColor]];
        technicianLabel.textAlignment = NSTextAlignmentLeft;
        [technicianLabel setBackgroundColor:[UIColor clearColor]];
        technicianLabel.text = @"选择技师";
        [self addSubview:technicianLabel];
        technicianLabel.hidden = YES;
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).offset(20);
            make.right.equalTo(self.mas_right).offset(-250);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(40);
            
        }];
        
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(nameLabel.mas_right);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(40);
            make.width.equalTo(60);
        }];
        
        [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(80);
            make.left.equalTo(priceLabel.mas_right);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(40);
        }];
        
        [technicianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(countLabel.mas_right);
            make.right.equalTo(self.mas_right);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(40);
        }];
        
    }
    return self;
}

-(void)setProjectListInfo:(NSMutableDictionary *)infoDic;
{
    ProjectInfo *info = [infoDic objectForKey:@"info"];
    nameLabel.text = info.projectname;
    priceLabel.text = [NSString stringWithFormat:@"￥%@",info.vipprice];
    countLabel.text = [NSString stringWithFormat:@"×%@",[infoDic objectForKey:@"count"]];
//    technicianLabel.text = @"";
//    if ([[[OrderRecordInfo shareOrderRecordInfo].technicianDic allKeys] containsObject:info.projectid])
//    {
//        TechnicianInfo *technicianinfo = [[OrderRecordInfo shareOrderRecordInfo].technicianDic objectForKey:info.projectid];
//        technicianLabel.text = technicianinfo.technicianname;
//    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
