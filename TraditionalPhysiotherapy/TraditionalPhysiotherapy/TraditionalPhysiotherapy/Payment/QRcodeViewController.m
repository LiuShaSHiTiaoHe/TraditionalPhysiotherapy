//
//  QRcodeViewController.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/4/26.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "QRcodeViewController.h"

@interface QRcodeViewController ()

@end

@implementation QRcodeViewController
@synthesize commiteBlock;
@synthesize costString;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    balanceText = [[UILabel alloc] init];
    balanceText.text = [NSString stringWithFormat:@"消费金额：%@元",costString];
    balanceText.font = [UIFont systemFontOfSize:26];
    balanceText.textColor = [UIColor grayColor];
    balanceText.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:balanceText];
    
    aliPayImage = [[UIImageView alloc] init];
    aliPayImage.image = [UIImage imageNamed:@"aliPay" imageBundle:@"payment"];
    [self.view addSubview:aliPayImage];
    
    aliCode = [[UIImageView alloc] init];
//    aliCode.image = [UIImage imageNamed:@"code" imageBundle:@"payment"];
    [self.view addSubview:aliCode];
    
    weChatPayImage = [[UIImageView alloc] init];
    weChatPayImage.image = [UIImage imageNamed:@"wechatPay" imageBundle:@"payment"];
    [self.view addSubview:weChatPayImage];
    
    weChatCode = [[UIImageView alloc] init];
//    weChatCode.image = [UIImage imageNamed:@"code" imageBundle:@"payment"];
    [self.view addSubview:weChatCode];
    
    
    commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitButton addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [commitButton setBackgroundColor:[UIColor colorWithHexString:@"4eccff"]];
    [commitButton setTitle:@"确定" forState:UIControlStateNormal];
    commitButton.layer.cornerRadius = 10.;
    commitButton.clipsToBounds = YES;
    [self.view addSubview:commitButton];
    
    cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleButton addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [cancleButton setBackgroundColor:[UIColor colorWithHexString:@"44e6cd"]];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    cancleButton.layer.cornerRadius = 10.;
    cancleButton.clipsToBounds = YES;
    [self.view addSubview:cancleButton];
    
    
    [balanceText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20.);
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.left.equalTo(self.view.mas_left).offset(50);
        make.height.equalTo(40.);
        
    }];
    
    [aliPayImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(50.);
        make.right.equalTo(self.view.mas_centerX).offset(-190.);
        make.left.equalTo(self.view.mas_left).offset(190);
        make.height.equalTo(50.);
        
    }];
    
    [aliCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aliPayImage.mas_bottom).offset(50.);
        make.right.equalTo(self.view.mas_centerX).offset(-100.);
        make.left.equalTo(self.view.mas_left).offset(100);
        make.height.equalTo(300.);
        
    }];
    
    
    [weChatPayImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(50.);
        make.right.equalTo(self.view.mas_right).offset(-190.);
        make.left.equalTo(self.view.mas_centerX).offset(170);
        make.height.equalTo(50.);
        
    }];
    
    [weChatCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weChatPayImage.mas_bottom).offset(50.);
        make.left.equalTo(self.view.mas_centerX).offset(100.);
        make.right.equalTo(self.view.mas_right).offset(-100);
        make.height.equalTo(300.);
        
    }];
    
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_centerX).offset(-20.);
        make.bottom.equalTo(self.view.mas_bottom).offset(-70.);
        make.left.equalTo(self.view.mas_left).offset(20.);
        make.height.equalTo(50.);
        
    }];
    
    [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX).offset(20.);
        make.bottom.equalTo(self.view.mas_bottom).offset(-70.);
        make.right.equalTo(self.view.mas_right).offset(-20.);
        make.height.equalTo(50.);
        
    }];
}


-(void)confirmBtnAction
{
    commiteBlock();
    [self.view removeFromSuperview];
}


-(void)cancleBtnAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
