//
//  TechnicianDetailViewController.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/31.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "TechnicianDetailViewController.h"
#import "SelectShowStyleByDateViewController.h"
#import "TechnicainRecordDao.h"
#import "TechnicianWorkRecordCellTableViewCell.h"
#import "AddTechnician.h"

@interface TechnicianDetailViewController ()<SelectShowStyleByDateViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation TechnicianDetailViewController
@synthesize currentInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f3f3"];
//    self.view.backgroundColor = [UIColor redColor];
    
    
    UIView *myNavView = [[UIView alloc] init];
    myNavView.backgroundColor = [UIColor colorWithHexString:@"4977f1"];
    [self.view addSubview:myNavView];
    
    UIButton *addContactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addContactBtn setImage:[UIImage imageNamed:@"back" imageBundle:@"Menu"] forState:UIControlStateNormal];
    [addContactBtn addTarget:self action:@selector(BackAction) forControlEvents:UIControlEventTouchUpInside];
    [myNavView addSubview:addContactBtn];
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"技师详情";
    titleLabel.font = [UIFont systemFontOfSize:22];
    titleLabel.textColor = [UIColor whiteColor];
    [myNavView addSubview:titleLabel];
    
    UIButton *editContactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editContactBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editContactBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editContactBtn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    [myNavView addSubview:editContactBtn];
    
    
    
    headImage = [[UIImageView alloc] init];
    headImage.layer.masksToBounds = YES;
    headImage.layer.cornerRadius = 80/2;
    [self.view addSubview:headImage];
    
    nameLabel = [[UILabel alloc] init];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:20.];
    nameLabel.textColor = [UIColor grayColor];
    [self.view addSubview:nameLabel];
    
    telephone = [[UILabel alloc] init];
    telephone.textAlignment = NSTextAlignmentLeft;
    telephone.font = [UIFont systemFontOfSize:20.];
    telephone.textColor = [UIColor grayColor];
    [self.view addSubview:telephone];
    
    HWDownSelectedView *sectionTextfiled = [[HWDownSelectedView alloc] init];
//    sectionTextfiled.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    sectionTextfiled.layer.borderWidth = 1.f;
    sectionTextfiled.placeholder = @"按年显示";
    sectionTextfiled.backgroundColor = [UIColor whiteColor];
    sectionTextfiled.delegate = self;
    sectionTextfiled.listArray = @[@"按年显示",@"按月显示"];
    [self.view addSubview:sectionTextfiled];
    
    chooseDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseDateBtn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [chooseDateBtn setBackgroundColor:[UIColor colorWithHexString:@"4eccff"]];
    [chooseDateBtn setTitle:@"选择日期" forState:UIControlStateNormal];
//    chooseDateBtn.layer.cornerRadius = 10.;
//    chooseDateBtn.clipsToBounds = YES;
    [self.view addSubview:chooseDateBtn];
    
    settechnicianTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    settechnicianTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    settechnicianTable.backgroundColor = [UIColor whiteColor];
    settechnicianTable.delegate = self;
    settechnicianTable.dataSource = self;
    [self.view addSubview:settechnicianTable];
    
    
    [myNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(70.);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNavView.mas_top).offset(30.);
        make.centerX.equalTo(myNavView.mas_centerX);
        make.width.equalTo(100.);
        make.height.equalTo(30.);
        
    }];
    
    [addContactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(myNavView.mas_top).offset(30.);
        make.left.equalTo(myNavView.mas_left).offset(30);
        make.width.equalTo(30.);
        make.height.equalTo(30.);
    }];
    
    [editContactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(myNavView.mas_top).offset(30.);
        make.right.equalTo(myNavView.mas_right).offset(-20);
        make.width.equalTo(60.);
        make.height.equalTo(30.);
    }];
    
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNavView.mas_bottom).offset(20.);
        make.left.equalTo(self.view.mas_left).offset(20.);
        make.width.equalTo(@80.);
        make.height.equalTo(@80.);

    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@40.);
        make.top.equalTo(myNavView.mas_bottom).offset(20.);
        make.left.equalTo(headImage.mas_right).offset(10);
        make.right.equalTo(self.view.mas_right).offset(10);

    }];
    
    [telephone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@40.);
        make.top.equalTo(nameLabel.mas_bottom).offset(0.);
        make.left.equalTo(headImage.mas_right).offset(10);
        make.right.equalTo(self.view.mas_right).offset(10);

    }];
    
    
    [sectionTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@180.);
        make.height.equalTo(@40.);
        make.top.equalTo(telephone.mas_bottom).offset(10.);
        make.left.equalTo(self.view.mas_left).offset(20.);
    }];
    
    [chooseDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@180.);
        make.height.equalTo(@40.);
        make.top.equalTo(telephone.mas_bottom).offset(10.);
        make.right.equalTo(self.view.mas_right).offset(-20.);
    }];
    
    [settechnicianTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chooseDateBtn.mas_bottom).offset(20);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];
    
    nameLabel.text = [NSString stringWithFormat:@"姓名:  %@",currentInfo.technicianname];
    headImage.image = [UIImage imageWithContentsOfFile:currentInfo.technicianImage];
    telephone.text = [NSString stringWithFormat:@"电话:  %@",currentInfo.technicianPhone];
    viewMode = YES;
    currentArray = [[NSMutableArray alloc] init];
    [self loaddefultData];
}

-(void)loaddefultData
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *yearStr = [dateFormatter stringFromDate:[NSDate date]];
    [currentArray removeAllObjects];
    currentArray = [[TechnicainRecordDao shareInstanceTechnicainRecordDao] getTechNicianRecordById:currentInfo.technicianid andByYear:yearStr andByMonth:@""];

    [settechnicianTable reloadData];

}

-(void)BackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)editAction
{
    AddTechnician *AddTechnicianView = [[AddTechnician alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    [AddTechnicianView initUIwithInfo:currentInfo];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    if (rootViewController == nil) {
        window = [UIApplication sharedApplication].windows[0];
        rootViewController = window.rootViewController;
    }
    [rootViewController.view addSubview:AddTechnicianView];
}

-(void)confirmBtnAction
{
    SelectShowStyleByDateViewController *menuVC = [[SelectShowStyleByDateViewController alloc] init];
    menuVC.viewMode = viewMode;
    menuVC.delegate = self;
    popOver = [[UIPopoverController alloc] initWithContentViewController:menuVC];
    [popOver presentPopoverFromRect:chooseDateBtn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
//    UIImage *image=[UIImage imageWithContentsOfFile:currentInfo.technicianImage];
//    NSArray *postItems=@[image];
//
//    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:postItems applicationActivities:nil];
//
//    // Change Rect to position Popover
//    popOver = [[UIPopoverController alloc] initWithContentViewController:controller];
//    [popOver presentPopoverFromRect:chooseDateBtn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

-(void)selectedDay:(NSString *)dateString
{
    NSArray *dateArray = [dateString componentsSeparatedByString:@"-"];
    NSString *yearStr = [dateArray objectAtIndex:0];
    NSString *monthStr = [dateArray objectAtIndex:1];
    [currentArray removeAllObjects];
    
    if (viewMode)
    {
        currentArray = [[TechnicainRecordDao shareInstanceTechnicainRecordDao] getTechNicianRecordById:currentInfo.technicianid andByYear:yearStr andByMonth:@""];
    }
    else
    {
        currentArray = [[TechnicainRecordDao shareInstanceTechnicainRecordDao] getTechNicianRecordById:currentInfo.technicianid andByYear:yearStr andByMonth:monthStr];

    }
    [settechnicianTable reloadData];
    [popOver dismissPopoverAnimated:YES];
}

-(void)dismissSelectShowStyleByDateView
{
    [popOver dismissPopoverAnimated:YES];
}
#pragma mark 选择类别
- (void)downSelectedView:(HWDownSelectedView *)selectedView didSelectedAtIndex:(NSIndexPath *)indexPath;
{
//    currentSelectedSectionInfo = [sectionArray objectAtIndex:indexPath.row];
    if (indexPath.row == 0)
    {
        viewMode = YES;
    }
    else
    {
        viewMode = NO;
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return currentArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifer = @"ContactIdentifer";
    TechnicianWorkRecordCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    
    if (cell == nil)
    {
        cell = [[TechnicianWorkRecordCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    NSDictionary *dic = [currentArray objectAtIndex:indexPath.row];
    [cell setProjectListInfo:dic];
    return cell;
    
    
    
}

#pragma mark - UITableViewDelegate


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * backView = [UIView new];
    backView.backgroundColor = [UIColor colorWithHexString:@"fbf1d7"];
    
    UILabel * deptLabel = [UILabel new];
    deptLabel.font = [UIFont systemFontOfSize:17];
    deptLabel.text = @"记录详情";
    deptLabel.textColor = [UIColor colorWithHexString:@"bda486"];
    [backView addSubview:deptLabel];
    
    [deptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(20);
        make.centerY.equalTo(backView.mas_centerY);
        make.height.equalTo(@40);
    }];
    
    
    return backView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30.;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
