//
//  SelectContactCell.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/4.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "SelectContactCell.h"
#import "ContactInfo.h"
#import "TechnicianInfo.h"

@implementation SelectContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
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
        arrowImage.image = [UIImage imageWithContentsOfFile:@"unselected"
                                                imageBundle:@"contact"];
//        arrowImage.backgroundColor = [UIColor redColor];
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
            make.right.equalTo(self.mas_right).offset(-100);
            make.height.equalTo(@30.);
            
        }];
        
        
        [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-30);
            make.width.equalTo(@(30.));
            make.height.equalTo(@(30.));
            
        }];
        
    }
    return self;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)configWithEntity:(NSDictionary *)entity;
{
    self.textLabel.textColor = [UIColor darkGrayColor];
    self.textLabel.font = [UIFont systemFontOfSize:16];
    
    ContactInfo *info = [entity objectForKey:@"info"];
    NSString *selected = [entity objectForKey:@"select"];
    
    if ([NSObject isNullOrNilWithObject:info.userImage])
    {
        if ([info.userGender isEqualToString:@"male"])
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
        headPic.image = [GlobalDataManager resizeImageByvImage:[UIImage imageWithContentsOfFile:info.userImage]];
    }

    nameLabel.text = info.userName;
    if ([selected isEqualToString:@"yes"])
    {
        arrowImage.image = [UIImage imageNamed:@"selected"
                                                imageBundle:@"contact"];
    }
    else
    {
        arrowImage.image = [UIImage imageNamed:@"unselected"
                                                imageBundle:@"contact"];
    }

}

-(void)configWithTechnicianEntity:(NSDictionary *)entity
{
    self.textLabel.textColor = [UIColor darkGrayColor];
    self.textLabel.font = [UIFont systemFontOfSize:16];
    
    TechnicianInfo *info = [entity objectForKey:@"info"];
    NSString *selected = [entity objectForKey:@"select"];
    
    if ([NSObject isNullOrNilWithObject:info.technicianImage])
    {
        if ([info.technicianGender isEqualToString:@"male"])
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
        headPic.image = [GlobalDataManager resizeImageByvImage:[UIImage imageWithContentsOfFile:info.technicianImage]];
    }
    
    nameLabel.text = info.technicianname;
    if ([selected isEqualToString:@"yes"])
    {
        arrowImage.image = [UIImage imageNamed:@"selected"
                                   imageBundle:@"contact"];
    }
    else
    {
        arrowImage.image = [UIImage imageNamed:@"unselected"
                                   imageBundle:@"contact"];
    }
}

@end
