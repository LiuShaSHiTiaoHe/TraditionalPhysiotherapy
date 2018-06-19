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
    
    ContactsViewController *c2=[[ContactsViewController alloc]init];
    c2.tabBarItem.title=@"会员";
    [c2.tabBarItem setImage:[UIImage imageNamed:@"Contacts_g" imageBundle:@"main"]];
    [c2.tabBarItem setSelectedImage:[UIImage imageNamed:@"Contacts_b" imageBundle:@"main"]];
    [c2.tabBarItem setTitlePositionAdjustment:tabbarStringOffset];
    
    PaymentViewController *c3 = [[PaymentViewController alloc]init];
    c3.tabBarItem.title = @"结账";
    [c3.tabBarItem setImage:[UIImage imageNamed:@"Checkout_g" imageBundle:@"main"]];
    [c3.tabBarItem setSelectedImage:[UIImage imageNamed:@"Checkout_b" imageBundle:@"main"]];
    [c3.tabBarItem setTitlePositionAdjustment:tabbarStringOffset];
    
    SettingViewController *c4 = [[SettingViewController alloc]init];
    c4.tabBarItem.title = @"设置";
    [c4.tabBarItem setImage:[UIImage imageNamed:@"Setting_g" imageBundle:@"main"]];
    [c4.tabBarItem setSelectedImage:[UIImage imageNamed:@"Setting_b" imageBundle:@"main"]];
    [c4.tabBarItem setTitlePositionAdjustment:tabbarStringOffset];
    
    self.viewControllers=@[c1,c2,c3,c4];
    

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
