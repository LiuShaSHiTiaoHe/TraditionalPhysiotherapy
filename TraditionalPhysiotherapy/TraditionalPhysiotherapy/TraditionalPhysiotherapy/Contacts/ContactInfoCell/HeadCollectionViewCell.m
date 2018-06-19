//
//  HeadCollectionViewCell.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/12/14.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import "HeadCollectionViewCell.h"

@implementation HeadCollectionViewCell
@synthesize headImage,userName;
@synthesize editButton,editBlock;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code NewCharCheckMember@3x
        [self setUserInteractionEnabled:YES];
        self.backgroundColor = [UIColor clearColor];
        
        backImageView = [[UIImageView alloc] init];
//        backImageView.image = [UIImage boxblurImage:[UIImage imageNamed:@"wdbg" imageBundle:@"contact"] withBlurNumber:0.1f];
        backImageView.image = [UIImage imageNamed:@"wdbg" imageBundle:@"contact"];
        [self addSubview:backImageView];
        
        headImage = [[UIImageView alloc] init];
        headImage.backgroundColor = [UIColor clearColor];
        headImage.layer.cornerRadius = 40.;
        headImage.clipsToBounds = YES;
        [self addSubview:headImage];
        
        userName = [[UILabel alloc] init];
        userName.textAlignment = NSTextAlignmentCenter;
        userName.font = [UIFont systemFontOfSize:20];
        userName.textColor = [UIColor whiteColor];
        [self addSubview:userName];
        
        editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [editButton setImage:[UIImage imageNamed:@"edit" imageBundle:@"contact"] forState:UIControlStateNormal];
        [editButton addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:editButton];
//        editButton.hidden = YES;
        
        [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.right.equalTo(self.mas_right);
            make.left.equalTo(self.mas_left);
            make.height.equalTo(150.);
            
        }];
        
        [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(30.);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(80.);
            make.height.equalTo(80.);
            
        }];
        
        [userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headImage.mas_bottom).offset(5.);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(100.);
            make.height.equalTo(30.);
            
        }];
        
        [editButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(50.);
            make.right.equalTo(self.mas_right).offset(-30.);
            make.width.equalTo(30.);
            make.height.equalTo(30.);
            
        }];
        
    }
    return self;
}

-(void)editAction
{
    editBlock();
}

@end
