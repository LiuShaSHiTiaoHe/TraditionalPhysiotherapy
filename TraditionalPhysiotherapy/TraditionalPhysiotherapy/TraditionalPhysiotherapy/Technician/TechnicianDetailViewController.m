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

@interface TechnicianDetailViewController ()<SelectShowStyleByDateViewControllerDelegate,UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate,UIScrollViewDelegate>
{
    SelectShowStyleByDateViewController *menuVC;
}
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
    
//    UIButton *addContactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addContactBtn setImage:[UIImage imageNamed:@"back" imageBundle:@"Menu"] forState:UIControlStateNormal];
//    [addContactBtn addTarget:self action:@selector(BackAction) forControlEvents:UIControlEventTouchUpInside];
//    [myNavView addSubview:addContactBtn];
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"技师详情";
    titleLabel.font = [UIFont systemFontOfSize:30];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [myNavView addSubview:titleLabel];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back" imageBundle:@"Project"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(BackAction) forControlEvents:UIControlEventTouchUpInside];
    [myNavView addSubview:backButton];
    
    UIButton *editContactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editContactBtn setTitle:@"编辑" forState:UIControlStateNormal];
    editContactBtn.titleLabel.font = [UIFont systemFontOfSize:28];
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
    sectionTextfiled.font = [UIFont systemFontOfSize:28];
    sectionTextfiled.placeholder = @"按年显示";
    sectionTextfiled.backgroundColor = [UIColor whiteColor];
    sectionTextfiled.delegate = self;
    sectionTextfiled.listArray = @[@"按年显示",@"按月显示"];
    [self.view addSubview:sectionTextfiled];
    
    chooseDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseDateBtn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [chooseDateBtn setBackgroundColor:[UIColor colorWithHexString:@"4eccff"]];
    [chooseDateBtn setTitle:@"选择日期" forState:UIControlStateNormal];
    chooseDateBtn.titleLabel.font = [UIFont systemFontOfSize:28];
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
        make.height.equalTo(100.);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(myNavView.mas_top).offset(40.);
        make.centerX.equalTo(myNavView.mas_centerX);
        make.width.equalTo(UIScreenWidth);
        make.height.equalTo(50.);
        
    }];
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(myNavView.mas_centerY).offset(20.);
        make.left.equalTo(myNavView.mas_left).offset(30.);
        make.width.height.equalTo(50);
    }];
    
//    [addContactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.centerY.equalTo(myNavView.mas_centerY).offset(20.);
//        make.right.equalTo(myNavView.mas_right).offset(-30.);
//        make.width.height.equalTo(50);
//    }];
    
//    [addContactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(myNavView.mas_top).offset(30.);
//        make.left.equalTo(myNavView.mas_left).offset(30);
//        make.width.equalTo(30.);
//        make.height.equalTo(30.);
//    }];
    
    [editContactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.top.equalTo(myNavView.mas_top).offset(30.);
//        make.right.equalTo(myNavView.mas_right).offset(-20);
//        make.width.equalTo(60.);
//        make.height.equalTo(30.);
        
        make.centerY.equalTo(myNavView.mas_centerY).offset(20.);
        make.right.equalTo(myNavView.mas_right).offset(-30.);
        make.height.equalTo(50);
        make.width.equalTo(120);
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
        
        make.width.equalTo(@280.);
        make.height.equalTo(@60.);
        make.top.equalTo(telephone.mas_bottom).offset(10.);
        make.left.equalTo(self.view.mas_left).offset(20.);
    }];
    
    [chooseDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@280.);
        make.height.equalTo(@60.);
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
    if ([NSObject isNullOrNilWithObject:currentInfo.technicianImage])
    {
        if ([currentInfo.technicianGender isEqualToString:@"male"])
        {
            headImage.image = [UIImage imageNamed:@"male" imageBundle:@"contact"];
        }
        else
        {
            headImage.image = [UIImage imageNamed:@"female" imageBundle:@"contact"];
        }
        
    }
    else
    {
        headImage.image = [GlobalDataManager resizeImageByvImage:[UIImage imageWithContentsOfFile:currentInfo.technicianImage]];
    }
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
    menuVC = [[SelectShowStyleByDateViewController alloc] init];
    menuVC.viewMode = viewMode;
    menuVC.delegate = self;
    menuVC.modalPresentationStyle = UIModalPresentationPopover;
    menuVC.preferredContentSize = CGSizeMake(400, 300);
//    popOver = [[UIPopoverController alloc] initWithContentViewController:menuVC];
//    [popOver presentPopoverFromRect:chooseDateBtn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    
    
    UIPopoverPresentationController *pop = menuVC.popoverPresentationController;
//    pop.barButtonItem = self.navigationItem.rightBarButtonItem;
    pop.sourceView = chooseDateBtn;
    pop.sourceRect = CGRectMake(chooseDateBtn.frame.size.width / 2, chooseDateBtn.frame.size.height, 0, 0);
    pop.permittedArrowDirections = UIPopoverArrowDirectionUp;
    pop.backgroundColor = [UIColor whiteColor];
    pop.delegate = self;
    [self presentViewController:menuVC animated:YES completion:^{
        
    }];
    
    
}

#pragma mark- UIPopoverPresentationControllerDelegate
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
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
//    [popOver dismissPopoverAnimated:YES];
    [menuVC dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)dismissSelectShowStyleByDateView
{
//    [popOver dismissPopoverAnimated:YES];
    [menuVC dismissViewControllerAnimated:YES completion:nil];

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
    deptLabel.font = [UIFont systemFontOfSize:26];
    deptLabel.text = @"记录详情";
    deptLabel.textAlignment = NSTextAlignmentCenter;

    deptLabel.textColor = [UIColor colorWithHexString:@"bda486"];
    [backView addSubview:deptLabel];
    
    UILabel * projectNameLabel = [UILabel new];
    projectNameLabel.font = [UIFont systemFontOfSize:26];
    projectNameLabel.text = @"项目名称";
    projectNameLabel.textAlignment = NSTextAlignmentCenter;

    projectNameLabel.textColor = [UIColor colorWithHexString:@"bda486"];
    [backView addSubview:projectNameLabel];
    
    UILabel * priceLabel = [UILabel new];
    priceLabel.font = [UIFont systemFontOfSize:26];
    priceLabel.text = @"价格";
    priceLabel.textAlignment = NSTextAlignmentCenter;

    priceLabel.textColor = [UIColor colorWithHexString:@"bda486"];
    [backView addSubview:priceLabel];
    
    UILabel * vipLabel = [UILabel new];
    vipLabel.font = [UIFont systemFontOfSize:26];
    vipLabel.text = @"会员";
    vipLabel.textAlignment = NSTextAlignmentCenter;

    vipLabel.textColor = [UIColor colorWithHexString:@"bda486"];
    [backView addSubview:vipLabel];
    
    
    [deptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(backView.mas_left).offset(20);
        make.width.equalTo(300);
        make.centerY.equalTo(backView.mas_centerY);
        make.height.equalTo(80);
        
    }];
    
    [projectNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(deptLabel.mas_right);
        make.centerY.equalTo(backView.mas_centerY);
        make.height.equalTo(80);
        make.width.equalTo(280);
    }];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(180);
        make.left.equalTo(projectNameLabel.mas_right);
        make.centerY.equalTo(backView.mas_centerY);
        make.height.equalTo(80);
    }];
    
    [vipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(priceLabel.mas_right).offset(-30);
        make.right.equalTo(backView.mas_right);
        make.centerY.equalTo(backView.mas_centerY);
        make.height.equalTo(80);
    }];
    
    
    return backView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
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
    return 120;
    
}
//固定头部视图
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 80;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
