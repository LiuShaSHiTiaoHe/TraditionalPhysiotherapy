//
//  SettingViewController.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/21.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingViewCell.h"
#import "MBProgressHUD.h"
#import "AddTechnician.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    contentView = [[SettingView alloc] init];
    contentView.settingListView.dataSource = self;
    contentView.settingListView.delegate = self;
//    contentView.delegate = self;
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [addProjectSectionView removeFromSuperview];
    [addProjectView removeFromSuperview];
//    [editProjectView removeFromSuperview];
    [gestureCodeView removeFromSuperview];
    
    [nav.view removeFromSuperview];
    [nav removeFromParentViewController];
    
    [editNav.view removeFromSuperview];
    [editNav removeFromParentViewController];
    
    contentView.contentScrollView.contentSize = CGSizeMake(UIScreenWidth-449, 1300.);

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 &&indexPath.row == 0)
    {
        addProjectSectionView = [[AddProjectSectionView alloc] init];
        [contentView addSubview:addProjectSectionView];
        [addProjectSectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(contentView.contentScrollView);
      
        }];
    }
    if (indexPath.section == 0 &&indexPath.row == 1)
    {
        addProjectView = [[AddProjrctView alloc] init];
        addProjectView.frame = CGRectMake(0,0, UIScreenWidth-449, 1300);

        [contentView.contentScrollView addSubview:addProjectView];

    }
    if(indexPath.section == 0 &&indexPath.row == 2)
    {
//        editProjectView = [[EditProject alloc] init];
//        [contentView addSubview:editProjectView];
//        [editProjectView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(contentView.contentScrollView);
//
//        }];
        [self loadEditProjectView];
    }
    if(indexPath.section == 1 &&indexPath.row == 0)
    {
        [self loadGestureCodeView];
    }
    if(indexPath.section == 1 &&indexPath.row == 1)
    {
        [self loadManageTechnician];
    }
}

#pragma mark UITableVieDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"ContactInfoTableViewCell";
    SettingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[SettingViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }

    if (indexPath.section == 0 &&indexPath.row == 0)
    {
        cell.titleLabel.text = @"添加类别";
        cell.iconImage.image = [UIImage imageNamed:@"111" imageBundle:@"Menu"];
    }
    if (indexPath.section == 0 &&indexPath.row == 1)
    {
        cell.titleLabel.text = @"添加项目";
        cell.iconImage.image = [UIImage imageNamed:@"222" imageBundle:@"Menu"];

    }
    if (indexPath.section == 0 &&indexPath.row == 2)
    {
        cell.titleLabel.text = @"编辑项目";
        cell.iconImage.image = [UIImage imageNamed:@"333" imageBundle:@"Menu"];

    }
    if (indexPath.section == 1 &&indexPath.row == 0)
    {
        cell.titleLabel.text = @"手势密码";
        cell.iconImage.image = [UIImage imageNamed:@"444" imageBundle:@"Menu"];
    }
    if (indexPath.section == 1 &&indexPath.row == 1)
    {
        cell.titleLabel.text = @"技师管理";
        cell.iconImage.image = [UIImage imageNamed:@"555" imageBundle:@"Menu"];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.;
}


#pragma mark 技师管理
-(void)loadManageTechnician
{
    SettingTechnicianViewController *vc = [[SettingTechnicianViewController alloc] init];
    nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.delegate = self;
    [self addChildViewController:nav];
    nav.view.frame = CGRectMake(0, 0, UIScreenWidth-449, UIScreenHeight-60);
    [contentView.contentScrollView addSubview:nav.view];
    contentView.contentScrollView.contentSize = CGSizeMake(UIScreenWidth-449, UIScreenHeight-60);
    
}

-(void)loadEditProjectView
{
    EditProjectViewController *vc = [[EditProjectViewController alloc] init];
    editNav = [[UINavigationController alloc] initWithRootViewController:vc];
//    vc.delegate = self;
    [self addChildViewController:editNav];
    editNav.view.frame = CGRectMake(0, 0, UIScreenWidth-449, UIScreenHeight-60);
    [contentView.contentScrollView addSubview:editNav.view];
    contentView.contentScrollView.contentSize = CGSizeMake(UIScreenWidth-449, UIScreenHeight-60);
}

#pragma mark 设置手势密码
-(void)loadGestureCodeView
{
    
    for (UIView *subview in contentView.contentScrollView.subviews)
    {
        [subview removeFromSuperview];
    }
    
    gestureCodeView = nil;
    
    if (!gestureCodeView)
    {
        gestureCodeView = [[SetGestureCodeView alloc] init];
        
        gestureCodeView.lockView.delegate = self;
        [contentView addSubview:gestureCodeView];
        
        [gestureCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(contentView.contentScrollView);
        }];
        
        
        
        [gestureCodeView.commiteButton addTarget:self action:@selector(commiteAction) forControlEvents:UIControlEventTouchUpInside];
        [gestureCodeView.switchButton addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
        gestureCodeView.commiteButton.hidden = YES;//进入设置页面  确认按钮先隐藏
        enterTimes = 0;//设置手势密码时，输入的次数
        tmpPath = @"";//记录第一次输入的密码
        
        if (gestureCodeView.switchButton.isOn == YES)
        {
            gestureCodeView.backView.hidden = YES;
        }
        else
        {
            gestureCodeView.backView.hidden = NO;
        }
        
    }
}

- (void)switchClick:(UISwitch *)switchBtn
{
    if ([GlobalDataManager getGestureCode].length > 0)
    {
        if (switchBtn.on == YES)
        {
            gestureCodeView.backView.hidden = YES;
            gestureCodeView.commiteButton.hidden = YES;
        }
        else
        {
            [GlobalDataManager setOpenGestureCode:NO];
            [GlobalDataManager setGestureCode:@""];
            gestureCodeView.backView.hidden = NO;
            enterTimes = 0;
            tmpPath = @"";
            [self clearDraw];
        }
    }
}


-(void)commiteAction
{
    [GlobalDataManager setOpenGestureCode:YES];
    [GlobalDataManager setGestureCode:tmpPath];
    [self clearDraw];
    [gestureCodeView.switchButton setOn:YES];
    gestureCodeView.backView.hidden = YES;
    gestureCodeView.commiteButton.hidden = YES;
}


#pragma mark 手势密码代理

-(void)beginTouch:(BOOL)isbegan
{
    [gestureCodeView.switchButton setOn:YES];
}

-(void)clearDraw
{
    [gestureCodeView resetLockView];
    gestureCodeView.lockView.delegate = self;
}

-(void)lockPath:(NSString *)path
{
    MBProgressHUD *my_hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    NSLog(@"gestureCode Path Is %@\r\n",path);
    
    if (enterTimes==0)
    {
        if (path.length < 4)
        {
            my_hud.mode = MBProgressHUDModeText;
            my_hud.labelText = @"请至少链接四个点!";
            [my_hud show:YES];
            [self.view addSubview:my_hud];
            [my_hud hide:YES afterDelay:2];
            [self clearDraw];
        }
        else
        {
            gestureCodeView.processLabel.text = @"再次绘制手势密码";
            enterTimes ++;
            tmpPath = path;
            [self clearDraw];
            
        }
    }
    else
    {
        if ([tmpPath isEqualToString:path])
        {
            gestureCodeView.processLabel.text  = @"";
            my_hud.mode = MBProgressHUDModeText;
            my_hud.labelText = @"绘制手势密码成功!";
            [my_hud show:YES];
            [self.view addSubview:my_hud];
            [my_hud hide:YES afterDelay:1];
            
            gestureCodeView.commiteButton.hidden = NO;
            
            
        }
        else
        {
            my_hud.mode = MBProgressHUDModeText;
            my_hud.labelText = @"两次绘制密码不一致,请重新绘制!";
            [my_hud show:YES];
            [self.view addSubview:my_hud];
            [my_hud hide:YES afterDelay:2];
            
            enterTimes = 0;
            tmpPath = @"";
            gestureCodeView.processLabel.text = @"绘制手势密码";
            [self clearDraw];
        }
        
    }
    
}


#pragma mark 添加技师信息代理
-(void)addTechnicianToVC
{
    AddTechnician *AddTechnicianView = [[AddTechnician alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    [self.view addSubview:AddTechnicianView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
