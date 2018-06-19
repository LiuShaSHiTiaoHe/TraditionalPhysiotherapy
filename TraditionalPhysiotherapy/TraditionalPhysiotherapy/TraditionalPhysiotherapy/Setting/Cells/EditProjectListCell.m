//
//  EditProjectListCell.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/30.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "EditProjectListCell.h"

@implementation EditProjectListCell
@synthesize nameLabel,mySwitch;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
//        self.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
//        headPic = [[UIImageView alloc] init];
//        headPic.layer.masksToBounds = YES;
//        headPic.layer.cornerRadius = 60/2;
//        [self addSubview:headPic];
        
        nameLabel= [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:18];
        [nameLabel setTextColor:[UIColor darkGrayColor]];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:nameLabel];
        
        
        mySwitch = [[UISwitch alloc] init];
        [self addSubview:mySwitch];


        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(25.);
            make.right.equalTo(self.mas_right).offset(00.);
            make.height.equalTo(@30.);
            
        }];
        
        
        [mySwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-10.);
            make.width.equalTo(@(80));
            make.height.equalTo(@(30));
            
        }];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
