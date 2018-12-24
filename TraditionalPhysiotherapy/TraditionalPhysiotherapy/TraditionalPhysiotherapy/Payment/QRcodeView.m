//
//  QRcodeView.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/4/26.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "QRcodeView.h"

@implementation QRcodeView
@synthesize commiteBlock;
@synthesize costString;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
    {
        return nil;
    }
    
    self.backgroundColor = [UIColor clearColor];
    
    maskView = [UIView new];
    maskView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];;
    [self addSubview:maskView];
    
    contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 20.;
    contentView.clipsToBounds = YES;
    [self addSubview:contentView];
    
    balanceText = [[UILabel alloc] init];
    balanceText.font = [UIFont systemFontOfSize:26];
    balanceText.textColor = [UIColor grayColor];
    balanceText.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:balanceText];
    
    aliPayImage = [[UIImageView alloc] init];
    aliPayImage.image = [UIImage imageNamed:@"aliPay" imageBundle:@"payment"];
    [contentView addSubview:aliPayImage];
    
    aliCode = [[UIImageView alloc] init];
        aliCode.image = [UIImage imageNamed:@"AliPayCode" imageBundle:@"payment"];
    [contentView addSubview:aliCode];
    
    weChatPayImage = [[UIImageView alloc] init];
    weChatPayImage.image = [UIImage imageNamed:@"wechatPay" imageBundle:@"payment"];
    [contentView addSubview:weChatPayImage];
    
    weChatCode = [[UIImageView alloc] init];
        weChatCode.image = [UIImage imageNamed:@"WeChat" imageBundle:@"payment"];
    [contentView addSubview:weChatCode];
    
    
    commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitButton addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [commitButton setBackgroundColor:[UIColor colorWithHexString:@"4eccff"]];
    [commitButton setTitle:@"确定" forState:UIControlStateNormal];
    commitButton.layer.cornerRadius = 10.;
    commitButton.clipsToBounds = YES;
    [contentView addSubview:commitButton];
    
    cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleButton addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [cancleButton setBackgroundColor:[UIColor colorWithHexString:@"44e6cd"]];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    cancleButton.layer.cornerRadius = 10.;
    cancleButton.clipsToBounds = YES;
    [contentView addSubview:cancleButton];
    
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
    
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(120.);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(800.);
        make.height.equalTo(500.);
        
    }];
    
    [balanceText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top).offset(10.);
        make.right.equalTo(contentView.mas_right).offset(-50);
        make.left.equalTo(contentView.mas_left).offset(50);
        make.height.equalTo(40.);
        
    }];
    
    [aliPayImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top).offset(50.);
//        make.right.equalTo(contentView.mas_centerX).offset(-70.);
        make.left.equalTo(contentView.mas_left).offset(30);
        make.width.equalTo(200);
        make.height.equalTo(50.);
        
    }];
    
    [aliCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aliPayImage.mas_bottom).offset(50.);
        make.right.equalTo(contentView.mas_centerX).offset(-100.);
//        make.left.equalTo(contentView.mas_left).offset(100);
        make.height.equalTo(250.);
        make.width.equalTo(250.);

    }];
    
    
    [weChatPayImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top).offset(50.);
//        make.right.equalTo(contentView.mas_right).offset(-70.);
        make.left.equalTo(contentView.mas_centerX).offset(30);
        make.height.equalTo(50.);
        make.width.equalTo(200);

        
    }];
    
    [weChatCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weChatPayImage.mas_bottom).offset(50.);
        make.left.equalTo(contentView.mas_centerX).offset(30.);
//        make.right.equalTo(contentView.mas_right).offset(-10);
        make.height.equalTo(250.);
        make.width.equalTo(250.);

    }];
    
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView.mas_centerX).offset(-20.);
        make.bottom.equalTo(contentView.mas_bottom).offset(-20.);
        make.left.equalTo(contentView.mas_left).offset(20.);
        make.height.equalTo(50.);
        
    }];
    
    [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_centerX).offset(20.);
        make.bottom.equalTo(contentView.mas_bottom).offset(-20.);
        make.right.equalTo(contentView.mas_right).offset(-20.);
        make.height.equalTo(50.);
        
    }];
    
    return self;
}


-(void)setCostString:(NSString *)costString
{
    balanceText.text = [NSString stringWithFormat:@"消费金额：%@元",costString];
}

-(void)confirmBtnAction
{
    commiteBlock();
    [self removeFromSuperview];
}


-(void)cancleBtnAction
{
    [self removeFromSuperview];
}

@end
