//
//  NewEditProjectContentViewController.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/12.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import "NewEditProjectContentViewController.h"
#import "NewEditProjectContentForm.h"
#import "ProjectDao.h"

@interface NewEditProjectContentViewController ()

@end

@implementation NewEditProjectContentViewController
@synthesize currentInfo;

- (void)viewDidLoad {
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
 
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setImage:[UIImage imageNamed:@"delete" imageBundle:@"Project"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [myNavView addSubview:deleteButton];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = currentInfo.projectname;
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
    
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(myNavView.mas_centerY).offset(20.);
        make.right.equalTo(myNavView.mas_right).offset(-30.);
        make.width.height.equalTo(50);
    }];
    
    NewEditProjectContentForm *content = [[NewEditProjectContentForm alloc] init];
    content.projectInfo = currentInfo;
    [self.view addSubview:content.view];
    
    [content.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(myNavView.mas_bottom);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(UIScreenWidth);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [self addChildViewController:content];
}

-(void)backBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)deleteButtonAction
{
//    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"提示" message:@"确定删除该项目吗？"];
//    alertView.alertViewWidth = 400;
//    alertView.contentViewSpace = 40;
//    alertView.buttonSpace = 60;
//    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
//        NSLog(@"%@",action.title);
//    }]];
//
//    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
//
//        [[ProjectDao shareInstanceProjectDao] updateProject:currentInfo.projectid andState:@"1"];
//
//    }]];
//
//    // first way to show ,use UIView Category
////    [alertView showInWindowWithOriginY:200 backgoundTapDismissEnable:YES];
//    [alertView showInController:self preferredStyle:TYAlertControllerStyleAlert backgoundTapDismissEnable:NO];
    
    CKAlertViewController *alertVC = [CKAlertViewController alertControllerWithTitle:@"提示" message:@"确定删除该项目吗？" ];
    
    CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"取消" handler:^(CKAlertAction *action) {
        NSLog(@"点击了 %@ 按钮",action.title);
    }];
    
    CKAlertAction *sure = [CKAlertAction actionWithTitle:@"确定" handler:^(CKAlertAction *action) {
        NSLog(@"点击了 %@ 按钮",action.title);
        
        [[ProjectDao shareInstanceProjectDao] updateProject:currentInfo.projectid andState:@"1"];
        
    }];
    
    [alertVC addAction:cancel];
    [alertVC addAction:sure];
    
    [self presentViewController:alertVC animated:NO completion:nil];
    
}

@end
