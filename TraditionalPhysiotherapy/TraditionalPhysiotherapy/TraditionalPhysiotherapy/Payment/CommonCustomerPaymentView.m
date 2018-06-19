//
//  CommonCustomerPaymentView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/12/28.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import "CommonCustomerPaymentView.h"
#import "OrderRecordInfo.h"
#import "PayMentRecordTableViewCell.h"
#import "ProjectInfo.h"

@implementation CommonCustomerPaymentView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (!self)
    {
        return nil;
    }
    
    aliPayImage = [[UIImageView alloc] init];
    aliPayImage.image = [UIImage imageNamed:@"aliPay" imageBundle:@"payment"];
    [self addSubview:aliPayImage];
    
    aliCode = [[UIImageView alloc] init];
    aliCode.image = [UIImage imageNamed:@"code" imageBundle:@"payment"];
    [self addSubview:aliCode];
    
    weChatPayImage = [[UIImageView alloc] init];
    weChatPayImage.image = [UIImage imageNamed:@"wechatPay" imageBundle:@"payment"];
    [self addSubview:weChatPayImage];
    
    weChatCode = [[UIImageView alloc] init];
    weChatCode.image = [UIImage imageNamed:@"code" imageBundle:@"payment"];
    [self addSubview:weChatCode];
    
    
    UIView *rBackView = [[UIView alloc] init];
    [self addSubview:rBackView];
    
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.image = [UIImage imageNamed:@"balance" imageBundle:@"payment"];
    [rBackView addSubview:iconImage];
    
    UILabel *balanceLabel = [[UILabel alloc] init];
    balanceLabel.text = @"消费金额";
    balanceLabel.font = [UIFont systemFontOfSize:20];
    balanceLabel.textColor = [UIColor grayColor];
    balanceLabel.textAlignment = NSTextAlignmentCenter;
    [rBackView addSubview:balanceLabel];
    
    balanceText = [[UILabel alloc] init];
    balanceText.text = @"299";
    balanceText.font = [UIFont systemFontOfSize:26];
    balanceText.textColor = [UIColor grayColor];
    balanceText.textAlignment = NSTextAlignmentCenter;
    [rBackView addSubview:balanceText];
    
    otherPay = [UIButton buttonWithType:UIButtonTypeCustom];
    otherPay.layer.cornerRadius = 10.;
    [otherPay setTitle:@"已付款" forState:UIControlStateNormal];
    [otherPay setBackgroundColor:[UIColor colorWithHexString:@"4eccff"]];
    [self addSubview:otherPay];
    
    
    [aliPayImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(50.);
        make.right.equalTo(self.mas_centerX).offset(-190.);
        make.left.equalTo(self.mas_left).offset(190);
        make.height.equalTo(50.);
        
    }];
    
    [aliCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aliPayImage.mas_bottom).offset(50.);
        make.right.equalTo(self.mas_centerX).offset(-100.);
        make.left.equalTo(self.mas_left).offset(100);
        make.height.equalTo(300.);
        
    }];
    
    
    [weChatPayImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(50.);
        make.right.equalTo(self.mas_right).offset(-190.);
        make.left.equalTo(self.mas_centerX).offset(170);
        make.height.equalTo(50.);
        
    }];
    
    [weChatCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weChatPayImage.mas_bottom).offset(50.);
        make.left.equalTo(self.mas_centerX).offset(100.);
        make.right.equalTo(self.mas_right).offset(-100);
        make.height.equalTo(300.);
        
    }];
    
    [rBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(30);
        make.height.equalTo(90.);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(200.);
    }];
    
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(rBackView.mas_left).offset(40);
        make.top.equalTo(rBackView.mas_top).offset(10.);
        make.width.equalTo(40.);
        make.height.equalTo(40.);
    }];
    
    [balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(iconImage.mas_right).offset(5.);
        make.top.equalTo(rBackView.mas_top).offset(10.);
        make.width.equalTo(90.);
        make.height.equalTo(40.);
    }];

    [balanceText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(rBackView.mas_left);
        make.top.equalTo(rBackView.mas_top).offset(50.);
        make.right.equalTo(rBackView.mas_right);
        make.height.equalTo(30.);
    }];
    
    [otherPay mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.mas_bottom).offset(-80);
        make.height.equalTo(40.);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(200.);
    }];
    
//    [self getTotalPrice];
    return self;
}

-(void)getTotalPrice
{
    NSMutableArray *arr = [OrderRecordInfo shareOrderRecordInfo].projectArray;
    NSInteger totalPrice = 0;
    for (NSMutableDictionary *dic in arr)
    {
        NSInteger count = [[dic objectForKey:@"count"] integerValue];
        ProjectInfo *info = [dic objectForKey:@"info"];
        NSInteger price = [info.projectprice integerValue];
        totalPrice = totalPrice + count * price;
    }
    balanceText.text = [NSString stringWithFormat:@"%ld 元",totalPrice];
}


@end
