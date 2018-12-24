//
//  NewContactsCollectionViewCell.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/14.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import "NewContactsCollectionViewCell.h"

@implementation NewContactsCollectionViewCell
@synthesize imageView;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = NO;
        self.layer.shadowOffset = CGSizeMake(0, 3);
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 3;
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        
        self.layer.cornerRadius = 10;
        self.layer.borderWidth = 4;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        
        imageView = [[UIImageView alloc] init];
        imageView.layer.cornerRadius = 50.;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        
        nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:30];
        nameLabel.textColor = [UIColor lightGrayColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:nameLabel];
        
        phoneLabel = [[UILabel alloc] init];
        phoneLabel.font = [UIFont systemFontOfSize:26];
        phoneLabel.textColor = [UIColor lightGrayColor];
        phoneLabel.adjustsFontSizeToFitWidth = YES;
        phoneLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:phoneLabel];
        
//        lastTimeLabel = [[UILabel alloc] init];
//        lastTimeLabel.font = [UIFont systemFontOfSize:30];
//        lastTimeLabel.textColor = [UIColor lightGrayColor];
//        lastTimeLabel.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:lastTimeLabel];
//
//        countLabel = [[UILabel alloc] init];
//        countLabel.font = [UIFont systemFontOfSize:30];
//        countLabel.textColor = [UIColor lightGrayColor];
//        countLabel.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:countLabel];
        
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).offset(30.);
            make.centerX.equalTo(self.mas_centerX);
            make.height.equalTo(100);
            make.width.equalTo(100);
        }];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.mas_bottom).offset(-70);
            make.left.equalTo(self.mas_left).offset(10.);
            make.right.equalTo(self.mas_right).offset(-10.);
            make.height.equalTo(50);
        }];
        
        [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.mas_bottom).offset(-20);
            make.left.equalTo(self.mas_left).offset(10.);
            make.right.equalTo(self.mas_right).offset(-10.);
            make.height.equalTo(50);
        }];
        
//        [lastTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.equalTo(phoneLabel.mas_bottom);
//            make.left.equalTo(self.mas_left).offset(10.);
//            make.right.equalTo(self.mas_right).offset(-10.);
//            make.height.equalTo(50);
//        }];
//
//        [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.equalTo(lastTimeLabel.mas_bottom);
//            make.left.equalTo(self.mas_left).offset(10.);
//            make.right.equalTo(self.mas_right).offset(-10.);
//            make.height.equalTo(50);
//        }];
        
        
    }
    return self;
}

-(void)configWithEntity:(ContactInfo *)info
{

//    if ([NSObject isNullOrNilWithObject:info.userImage])
//    {
//        if ([info.userGender isEqualToString:@"male"])
//        {
//            imageView.image = [UIImage imageNamed:@"male" imageBundle:@"contact"];
//        }
//        else
//        {
//            imageView.image = [UIImage imageNamed:@"female" imageBundle:@"contact"];
//        }
//    }
//    else
//    {
//        imageView.image = [UIImage imageWithContentsOfFile:info.userImage];
//    }
    
    nameLabel.text = info.userName;
    phoneLabel.text = info.userPhone;
}
@end
