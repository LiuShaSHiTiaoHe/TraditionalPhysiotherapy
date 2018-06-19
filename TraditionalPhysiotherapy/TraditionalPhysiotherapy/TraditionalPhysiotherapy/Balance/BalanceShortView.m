//
//  BalanceShortView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/12/21.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import "BalanceShortView.h"
#import "ContactInfo.h"

@implementation BalanceShortView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
    {
        return nil;
    }
    
    self.backgroundColor = [UIColor clearColor];
    
    backGroundView = [[UIView alloc] init];
    backGroundView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];;
    [self addSubview:backGroundView];
    
    whiteBackView = [[UIView alloc] init];
    whiteBackView.backgroundColor = [UIColor whiteColor];
    whiteBackView.layer.cornerRadius = 20.;
    whiteBackView.clipsToBounds = YES;
    [self addSubview:whiteBackView];
    
    iconImageView = [[UIImageView alloc] init];
    iconImageView.backgroundColor = [UIColor clearColor];
    iconImageView.image = [UIImage imageNamed:@"balance_2" imageBundle:@"contact"];
    [self addSubview:iconImageView];
  
    balanceLabel = [[UILabel alloc] init];
    balanceLabel.text = @"余额";
    balanceLabel.font = [UIFont systemFontOfSize:24];
    balanceLabel.textColor = [UIColor grayColor];
    balanceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:balanceLabel];
    
    balanceText = [[UILabel alloc] init];
//    balanceText.text = @"2999";
    balanceText.font = [UIFont systemFontOfSize:28];
    balanceText.textColor = [UIColor grayColor];
    balanceText.textAlignment = NSTextAlignmentCenter;
    [self addSubview:balanceText];
    
    rechargeRecordbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rechargeRecordbtn addTarget:self action:@selector(showRechargeRecord) forControlEvents:UIControlEventTouchUpInside];
    [rechargeRecordbtn setTitleColor:[UIColor colorWithHexString:@"1296db"] forState:UIControlStateNormal];
    [rechargeRecordbtn setTitle:@"充值记录" forState:UIControlStateNormal];
    rechargeRecordbtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [whiteBackView addSubview:rechargeRecordbtn];

    confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [confirmBtn setBackgroundImage:[UIImage imageNamed:@"delete_ico1" imageBundle:@"home2"] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setBackgroundColor:[UIColor colorWithHexString:@"4eccff"]];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [whiteBackView addSubview:confirmBtn];
    
    rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rechargeBtn setBackgroundImage:[UIImage imageNamed:@"delete_ico1" imageBundle:@"home2"] forState:UIControlStateNormal];
    [rechargeBtn addTarget:self action:@selector(rechargeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [rechargeBtn setBackgroundColor:[UIColor colorWithHexString:@"44e6cd"]];
    [rechargeBtn setTitle:@"去充值" forState:UIControlStateNormal];

    [whiteBackView addSubview:rechargeBtn];
    
    
    
    [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
    
    [whiteBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
//        make.centerY.equalTo(self.mas_centerY);
        make.top.equalTo(self.mas_top).offset(150.);
        make.width.equalTo(600.);
        make.height.equalTo(300.);
        
    }];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(whiteBackView.mas_top).offset(50);
        make.width.equalTo(100.);
        make.height.equalTo(100.);
        
    }];

    [rechargeRecordbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(whiteBackView.mas_right).offset(-30);
        make.width.equalTo(100);
        make.height.equalTo(30.);
        make.top.equalTo(whiteBackView.mas_top).offset(10);
    }];
    
    [balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImageView.mas_bottom).offset(20);
//        make.left.equalTo(whiteBackView.mas_left).offset(100);
//        make.width.equalTo(100.);
        make.left.equalTo(whiteBackView.mas_left);
        make.right.equalTo(whiteBackView.mas_right);
        make.height.equalTo(40.);
        
    }];
    
    [balanceText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(balanceLabel.mas_bottom).offset(30);
//        make.left.equalTo(whiteBackView.mas_left).offset(100);
        make.width.equalTo(200.);
        make.centerX.equalTo(whiteBackView.mas_centerX);
        make.height.equalTo(30.);
        
    }];
    
    
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteBackView.mas_left);
        make.bottom.equalTo(whiteBackView.mas_bottom);
        make.width.equalTo(300.);
        make.height.equalTo(50.);
        
    }];
    
    [rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(whiteBackView.mas_right);
        make.bottom.equalTo(whiteBackView.mas_bottom);
        make.width.equalTo(300.);
        make.height.equalTo(50.);
        
    }];
    
    
    return self;
}

-(void)setContactInfo:(ContactInfo *)info
{
    currentInfo = info;
    balanceText.text = info.userAccountBalance;
}

-(void)confirmBtnAction
{
//    [[MJPopTool sharedInstance] closeAnimated:YES];
    [self removeFromSuperview];
}

-(void)showRechargeRecord
{
    if (delegate)
    {
        [delegate BalanceShortViewShowRechargeRecord];
    }
    
    [self removeFromSuperview];

}

-(void)rechargeBtnAction
{
    if (delegate)
    {
        [delegate BalanceShortViewRecharge];
    }
    [self removeFromSuperview];

//    [[MJPopTool sharedInstance] closeAnimated:YES];

}


@end
