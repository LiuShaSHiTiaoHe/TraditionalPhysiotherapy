//
//  RechargeView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/5.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "RechargeView.h"
#import "ContactInfo.h"
#import "ContactsDao.h"
#import "RecordDao.h"

@implementation RechargeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
    {
        return nil;
    }
    
    maskView = [UIView new];
    maskView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];;
    [self addSubview:maskView];
    
    contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 20.;
    contentView.clipsToBounds = YES;
    [self addSubview:contentView];
    
    titleView = [[UIImageView alloc] init];
    titleView.userInteractionEnabled = YES;
    titleView.backgroundColor = [UIColor colorWithHexString:@"4977f1"];
    [contentView addSubview:titleView];
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"充值";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:22];
    titleLabel.textColor = [UIColor whiteColor];
    [titleView addSubview:titleLabel];
    
    
    headPic = [[UIImageView alloc] init];
    headPic.layer.masksToBounds = YES;
    headPic.layer.cornerRadius = 60/2;
    headPic.image = [UIImage imageNamed:@"unselectUser" imageBundle:@"contact"];
    [contentView addSubview:headPic];
    
    nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor lightGrayColor];
    nameLabel.font = [UIFont systemFontOfSize:18];
    [contentView addSubview:nameLabel];
    
    balanceLabel = [[UILabel alloc] init];
    balanceLabel.textColor = [UIColor lightGrayColor];
    balanceLabel.font = [UIFont systemFontOfSize:18];
    [contentView addSubview:balanceLabel];
    
    rechargeTF = [[UITextField alloc] init];
    rechargeTF.placeholder = @"请输入充值金额";
    rechargeTF.keyboardType = UIKeyboardTypeNumberPad;
    [contentView addSubview:rechargeTF];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithHexString:@"dadada"];
    [contentView addSubview:line];
    
    cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setImage:[UIImage imageNamed:@"cancle" imageBundle:@"contact"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:cancleBtn];
    
    commiteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commiteBtn addTarget:self action:@selector(commiteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [commiteBtn setBackgroundColor:[UIColor colorWithHexString:@"44e6cd"]];
    [commiteBtn setTitle:@"确定" forState:UIControlStateNormal];
    [contentView addSubview:commiteBtn];
    
    
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
    
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(80.);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(400.);
        make.height.equalTo(400.);
        
    }];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(contentView.mas_left);
        make.top.equalTo(contentView.mas_top);
        make.right.equalTo(contentView.mas_right);
        make.height.equalTo(60.);
        
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(titleView.mas_centerY);
        make.centerX.equalTo(titleView.mas_centerX);
        make.width.equalTo(160.);
        make.height.equalTo(30.);
    }];
    
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(titleView.mas_right).offset(-20.);
        make.centerY.equalTo(titleView.mas_centerY);
        make.width.equalTo(80/3);
        make.height.equalTo(80/3);
    }];
    
    [headPic mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(contentView.mas_left).offset(30);
        make.top.equalTo(titleView.mas_bottom).offset(20.);
        make.width.equalTo(60);
        make.height.equalTo(60.);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(headPic.mas_right).offset(30.);
        make.centerY.equalTo(headPic.mas_centerY);
        make.right.equalTo(contentView.mas_right).offset(-20);
        make.height.equalTo(30.);
    }];
    
     [balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(contentView.mas_left).offset(30);
        make.right.equalTo(contentView.mas_right).offset(-20);
        make.height.equalTo(40.);
        make.top.equalTo(headPic.mas_bottom).offset(20);
    }];
    
    [rechargeTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(contentView.mas_left).offset(30);
        make.right.equalTo(contentView.mas_right).offset(-20);
        make.height.equalTo(40.);
        make.top.equalTo(balanceLabel.mas_bottom).offset(20);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(contentView.mas_left).offset(30);
        make.right.equalTo(contentView.mas_right).offset(-20);
        make.height.equalTo(1.);
        make.top.equalTo(rechargeTF.mas_bottom).offset(1);
    }];
    
    [commiteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(contentView.mas_bottom).offset(-40);
        make.left.equalTo(contentView.mas_left);
        make.right.equalTo(contentView.mas_right);
        make.bottom.equalTo(contentView.mas_bottom);
    }];
    

    
    return self;
    
}

-(void)setViewContactInfo:(ContactInfo *)info
{
    curentInfo = info;
    if (![NSObject isNullOrNilWithObject:info.userImage])
    {
        headPic.image = [GlobalDataManager resizeImageByvImage:[UIImage imageWithContentsOfFile:info.userImage]];
    }
    nameLabel.text = info.userName;
    balanceLabel.text = [NSString stringWithFormat:@"余额:     %@ 元",info.userAccountBalance];
}

-(void)cancleBtnAction
{
    [self removeFromSuperview];
}

-(void)commiteBtnAction
{
    NSInteger prebalance = [curentInfo.userAccountBalance integerValue];
    NSInteger recharge = [rechargeTF.text integerValue];
    NSInteger total = prebalance +recharge;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[NSString stringWithFormat:@"%ld",recharge] forKey:@"rechargeNum"];
    [dic setObject:curentInfo.userId forKey:@"userId"];
    [dic setObject:[dateFormatter stringFromDate:[NSDate date]] forKey:@"rechargeDate"];
    [dic setObject:[NSString stringWithFormat:@"%ld",total] forKey:@"totalNum"];

    [[RecordDao shareInstanceRecordDao] addnewRechargeRecord:dic];
    [[ContactsDao shareInstanceContactDao] updateUserBalance:curentInfo.userId andBalance:[NSString stringWithFormat:@"%ld",total]];
    [[NSNotificationCenter defaultCenter] postNotificationName:UserDataBaseChanged object:nil];

    [self removeFromSuperview];

}





@end
