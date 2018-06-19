//
//  PaySucceedView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/5.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "PaySucceedView.h"
#import "ContactInfo.h"

@implementation PaySucceedView
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
    iconImageView.image = [UIImage imageNamed:@"paySucceed" imageBundle:@"contact"];
    [self addSubview:iconImageView];
    
    balanceLabel = [[UILabel alloc] init];
    balanceLabel.text = @"支付成功!";
    balanceLabel.font = [UIFont systemFontOfSize:20];
    balanceLabel.textColor = [UIColor grayColor];
    balanceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:balanceLabel];
    
 
    
    
    confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [confirmBtn setBackgroundImage:[UIImage imageNamed:@"delete_ico1" imageBundle:@"home2"] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setBackgroundColor:[UIColor colorWithHexString:@"4eccff"]];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [whiteBackView addSubview:confirmBtn];
    
    rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rechargeBtn addTarget:self action:@selector(rechargeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [rechargeBtn setBackgroundColor:[UIColor colorWithHexString:@"44e6cd"]];
    [rechargeBtn setTitle:@"去记录" forState:UIControlStateNormal];
    
    [whiteBackView addSubview:rechargeBtn];
    
    
    
    [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
    
    [whiteBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(300.);
        make.height.equalTo(200.);
        
    }];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(whiteBackView.mas_top).offset(50);
        make.width.equalTo(100.);
        make.height.equalTo(100.);
        
    }];
    
    [balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImageView.mas_bottom).offset(10);
        make.left.equalTo(whiteBackView.mas_left).offset(100);
        make.width.equalTo(100.);
        make.height.equalTo(30.);
        
    }];
    

    
    
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteBackView.mas_left);
        make.bottom.equalTo(whiteBackView.mas_bottom);
        make.width.equalTo(150.);
        make.height.equalTo(50.);
        
    }];
    
    [rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(whiteBackView.mas_right);
        make.bottom.equalTo(whiteBackView.mas_bottom);
        make.width.equalTo(150.);
        make.height.equalTo(50.);
        
    }];
    
    
    return self;
}
-(void)setPaySucceedViewInfo:(ContactInfo *)info
{
    currentInfo = info;
}


-(void)confirmBtnAction
{
    [[MJPopTool sharedInstance] closeAnimated:YES];
}

-(void)rechargeBtnAction
{

//    [[MJPopTool sharedInstance] closeAnimated:YES];
    if (delegate)
    {
        [delegate PaySucceedViewRecord];
    }
    
}






@end
