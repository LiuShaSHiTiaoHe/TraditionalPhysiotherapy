//
//  NewAddRecordViewController.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/18.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import "NewAddRecordViewController.h"
#import "NewAddRecordContent.h"
#import "ContactInfo.h"
#import "RecordInfo.h"

@interface NewAddRecordViewController ()
{
    NewAddRecordContent *content;
}

@end

@implementation NewAddRecordViewController
@synthesize curentInfo,currentRecordInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI
{
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f3f3"];
    
    UIView *backView = [[UIView alloc] init];
    [self.view addSubview:backView];
    
    UIView *myNavView = [[UIView alloc] init];
    myNavView.backgroundColor = [UIColor colorWithHexString:@"4977f1"];
    [backView addSubview:myNavView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back" imageBundle:@"Project"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [myNavView addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    if (currentRecordInfo)
    {
        titleLabel.text = @"编辑记录";
    }
    else
    {
        titleLabel.text = @"添加记录";
    }
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:30];
    [myNavView addSubview:titleLabel];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];
    
    [myNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(backView.mas_top);
        make.left.equalTo(backView.mas_left);
        make.right.equalTo(backView.mas_right);
        make.height.equalTo(100.);
    }];
    
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNavView.mas_top).offset(40.);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(UIScreenWidth);
        make.height.equalTo(50.);
        
    }];
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(myNavView.mas_centerY).offset(20.);
        make.left.equalTo(myNavView.mas_left).offset(30.);
        make.width.height.equalTo(50);
    }];
    
    content = [[NewAddRecordContent alloc] init];
    content.curentContactInfo = curentInfo;
    if (currentRecordInfo)
    {
        content.currentRecordInfo = currentRecordInfo;
    }
    [self addChildViewController:content];
    [self.view addSubview:content.view];
    [content didMoveToParentViewController:self];
    
    [content.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(myNavView.mas_bottom);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(UIScreenWidth);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
}

-(void)dealloc
{
    NSLog(@"dealloc NewAddRecordViewController");
}

-(void)backBtnAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        [content willMoveToParentViewController:nil];
        [content.view removeFromSuperview];
        [content removeFromParentViewController];
        
    }];
}

@end
