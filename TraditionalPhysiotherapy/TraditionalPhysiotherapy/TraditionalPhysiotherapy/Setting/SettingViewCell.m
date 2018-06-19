//
//  SettingViewCell.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/6.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "SettingViewCell.h"

@implementation SettingViewCell
@synthesize titleLabel,contentLabel,iconImage;
@synthesize accView;
- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithHexString:@"fefefe"];
        [self initUI];
        
    }
    return self;
}
//50
-(void)initUI
{
    
    iconImage = [[UIImageView alloc] init];
    iconImage.image = [UIImage imageNamed:@"news_image09"];
    [self addSubview:iconImage];
    
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:16.];
    titleLabel.textColor = [UIColor grayColor];
    [self addSubview:titleLabel];
    
    contentLabel = [[UILabel alloc] init];
    contentLabel.textAlignment = NSTextAlignmentRight;
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textColor = [UIColor grayColor];
    [self addSubview:contentLabel];
    
    accView = [[UIImageView alloc] init];
    accView.image = [UIImage imageNamed:@"arrow_left01" imageBundle:@"contact"];
    [self addSubview:accView];
    
    
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(30.);
        make.height.equalTo(30.);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(10.);
    }];
    
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(100.);
        make.left.equalTo(iconImage.mas_right).offset(10);
        make.height.equalTo(30.);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(titleLabel.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-20.);
        make.height.equalTo(30.);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [accView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-6);
        make.height.equalTo(12.);
        make.width.equalTo(9);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
