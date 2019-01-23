//
//  MainViewController.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/11/26.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import "MainViewController.h"
#import "ContactsViewController.h"
#import "PaymentViewController.h"
#import "MenuViewController.h"
#import "SettingViewController.h"
#import "NewSettingViewController.h"
#import "NewContactsViewController.h"
#import "NewPaymentViewController.h"

@interface MainViewController ()<UITabBarControllerDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    
    
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    UIOffset tabbarStringOffset = UIOffsetMake(0, 0);
    
    MenuViewController *c1=[[MenuViewController alloc]init];
    c1.tabBarItem.title=@"菜单";
    [c1.tabBarItem setImage:[UIImage imageNamed:@"menu_g" imageBundle:@"main"]];
    [c1.tabBarItem setSelectedImage:[UIImage imageNamed:@"menu_b" imageBundle:@"main"]];
    [c1.tabBarItem setTitlePositionAdjustment:tabbarStringOffset];
    
//    ContactsViewController *c2=[[ContactsViewController alloc]init];
    NewContactsViewController *c2=[[NewContactsViewController alloc]init];
    c2.tabBarItem.title=@"会员";
    [c2.tabBarItem setImage:[UIImage imageNamed:@"Contacts_g" imageBundle:@"main"]];
    [c2.tabBarItem setSelectedImage:[UIImage imageNamed:@"Contacts_b" imageBundle:@"main"]];
    [c2.tabBarItem setTitlePositionAdjustment:tabbarStringOffset];
    
//    PaymentViewController *c3 = [[PaymentViewController alloc]init];
    NewPaymentViewController *c3 = [[NewPaymentViewController alloc]init];
    c3.tabBarItem.title = @"结账";
    [c3.tabBarItem setImage:[UIImage imageNamed:@"Checkout_g" imageBundle:@"main"]];
    [c3.tabBarItem setSelectedImage:[UIImage imageNamed:@"Checkout_b" imageBundle:@"main"]];
    [c3.tabBarItem setTitlePositionAdjustment:tabbarStringOffset];
    
    NewSettingViewController *c4 = [[NewSettingViewController alloc]init];
    c4.tabBarItem.title = @"设置";
    [c4.tabBarItem setImage:[UIImage imageNamed:@"Setting_g" imageBundle:@"main"]];
    [c4.tabBarItem setSelectedImage:[UIImage imageNamed:@"Setting_b" imageBundle:@"main"]];
    [c4.tabBarItem setTitlePositionAdjustment:tabbarStringOffset];
    
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self.class]];
    
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica" size:20.0f],NSFontAttributeName,nil] forState:UIControlStateNormal];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"4977f1"], NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica" size:26.0f],NSFontAttributeName,nil] forState:UIControlStateSelected];

//    //未选中字体颜色
//    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:20]} forState:UIControlStateNormal];
//
//    //选中字体颜色
//    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"4977f1"],NSFontAttributeName:[UIFont systemFontOfSize:26]} forState:UIControlStateSelected];
    
    self.viewControllers=@[c1,c2,c3,c4];
    
    [self setSelectedIndex:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
