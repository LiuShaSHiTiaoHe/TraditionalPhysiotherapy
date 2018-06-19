//
//  TechnicianTableViewCell.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/25.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "TechnicianTableViewCell.h"
#import "TechnicianInfo.h"

@implementation TechnicianTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
//        self.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        headPic = [[UIImageView alloc] init];
        headPic.layer.masksToBounds = YES;
        headPic.layer.cornerRadius = 60/2;
        [self addSubview:headPic];
        
        nameLabel= [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:18];
        [nameLabel setTextColor:[UIColor darkGrayColor]];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:nameLabel];
        
        
        arrowImage = [[UIImageView alloc] init];
        arrowImage.image = [UIImage imageWithContentsOfFile:@"arrow_left01@2x"
                                                imageBundle:@"contact"];
        [self addSubview:arrowImage];
        
        
        [headPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(20.);
            make.width.equalTo(@60.);
            make.height.equalTo(@60.);
            
        }];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(headPic.mas_right).offset(25.);
            make.width.equalTo(@100.);
            make.height.equalTo(@30.);
            
        }];
        
        
        [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-17.);
            make.width.equalTo(@(8.));
            make.height.equalTo(@(10.));
            
        }];
        
    }
    return self;
}


-(void)configWithEntity:(TechnicianInfo *)entity
{
    self.textLabel.textColor = [UIColor darkGrayColor];
    self.textLabel.font = [UIFont systemFontOfSize:16];
    if ([NSObject isNullOrNilWithObject:entity.technicianImage])
    {
        if ([entity.technicianGender isEqualToString:@"male"])
        {
            headPic.image = [UIImage imageNamed:@"male" imageBundle:@"contact"];
        }
        else
        {
            headPic.image = [UIImage imageNamed:@"female" imageBundle:@"contact"];
        }
    }
    else
    {
        headPic.image = [UIImage imageWithContentsOfFile:entity.technicianImage];
    }
    
    nameLabel.text = entity.technicianname;
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
