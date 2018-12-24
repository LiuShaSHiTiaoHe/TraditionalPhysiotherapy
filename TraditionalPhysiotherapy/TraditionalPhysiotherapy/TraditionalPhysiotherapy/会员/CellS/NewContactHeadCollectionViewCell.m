//
//  NewContactHeadCollectionViewCell.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/17.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import "NewContactHeadCollectionViewCell.h"

@implementation NewContactHeadCollectionViewCell
@synthesize headImage,userName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code NewCharCheckMember@3x
        [self setUserInteractionEnabled:YES];
        self.backgroundColor = [UIColor clearColor];
        
        backImageView = [[UIImageView alloc] init];
        backImageView.image = [UIImage imageNamed:@"wdbg" imageBundle:@"contact"];
        [self addSubview:backImageView];
        
        headImage = [[UIImageView alloc] init];
        headImage.backgroundColor = [UIColor clearColor];
        headImage.layer.cornerRadius = 40.;
        headImage.clipsToBounds = YES;
        [self addSubview:headImage];
        
        userName = [[UILabel alloc] init];
        userName.textAlignment = NSTextAlignmentCenter;
        userName.font = [UIFont systemFontOfSize:26];
        userName.textColor = [UIColor whiteColor];
        [self addSubview:userName];
        
       
        
        [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.right.equalTo(self.mas_right);
            make.left.equalTo(self.mas_left);
            make.bottom.equalTo(self.mas_bottom);
            
        }];
        
        [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.mas_top).offset(30.);
            make.centerY.equalTo(backImageView.mas_centerY).offset(-20);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(80.);
            make.height.equalTo(80.);
            
        }];
        
        [userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headImage.mas_bottom).offset(15.);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(100.);
            make.height.equalTo(30.);
            
        }];
        
       
        
    }
    return self;
}

@end
