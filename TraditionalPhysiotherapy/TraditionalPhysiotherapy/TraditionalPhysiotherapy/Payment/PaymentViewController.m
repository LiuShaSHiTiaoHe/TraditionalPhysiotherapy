//
//  PaymentViewController.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/12/28.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import "PaymentViewController.h"

@interface PaymentViewController ()

@end

@implementation PaymentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    contentView = [[PaymentView alloc] init];
    contentView.delegate = self;
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

-(void)PaymentMethod:(NSInteger)method//0 会员  1普通客户 扫码支付
{
    if (method==0)
    {

        commonView.hidden = YES;
        
        if (!vipView)
        {
            vipView = [[VIPCustomerPaymentView alloc] init];
            [self.view addSubview:vipView];
            
            [vipView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(self.view.mas_top).offset(64.);
                make.left.equalTo(self.view.mas_left);
                make.right.equalTo(self.view.mas_right);
                make.bottom.equalTo(self.view.mas_bottom);

            }];
        }
        else
        {
            vipView.hidden = NO;
        }
        [vipView refreshData];

    }
    else
    {
        vipView.hidden = YES;
        
        if (!commonView)
        {
            commonView = [[CommonCustomerPaymentView alloc] init];
            [self.view addSubview:commonView];
            
            [commonView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(self.view.mas_top).offset(64.);
                make.left.equalTo(self.view.mas_left);
                make.right.equalTo(self.view.mas_right);
                make.bottom.equalTo(self.view.mas_bottom);
                
            }];
        }
        else
        {
            commonView.hidden = NO;
        }
        [commonView getTotalPrice];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self PaymentMethod:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
