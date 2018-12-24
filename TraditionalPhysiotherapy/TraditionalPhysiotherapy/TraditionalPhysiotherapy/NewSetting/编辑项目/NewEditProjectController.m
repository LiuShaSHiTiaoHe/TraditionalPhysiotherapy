//
//  NewEditProjectController.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/12.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import "NewEditProjectController.h"
#import "ProjectDao.h"
#import "ProjectSectionInfo.h"
#import "ProjectInfo.h"
#import "NewEditProjectContentViewController.h"

@interface NewEditProjectController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *editTableView;
    NSMutableArray *currentArray;

}
@end

@implementation NewEditProjectController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    
    currentArray = [NSMutableArray new];
    [self initData];
}

-(void)initData
{
    [currentArray removeAllObjects];
    NSMutableArray *sectionArray = [[ProjectDao shareInstanceProjectDao] getAllSection];
    for (ProjectSectionInfo *info in sectionArray)
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        NSMutableArray *projectArray = [[ProjectDao shareInstanceProjectDao] getProjectWithId:info.sectionid];
        [dic setObject:projectArray forKey:@"ProjectArray"];
        [dic setObject:info forKey:@"SectionInfo"];
        [currentArray addObject:dic];
    }
    [editTableView reloadData];
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
    titleLabel.text = @"编辑项目";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:30];
    [myNavView addSubview:titleLabel];
    
    editTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    editTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    editTableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    editTableView.delegate = self;
    editTableView.dataSource = self;
    editTableView.tableFooterView = [UIView new];
    [self.view addSubview:editTableView];
    
    
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
    
    
    [editTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(myNavView.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];

}

-(void)backBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark UITableVieDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *projectArray = [[currentArray objectAtIndex:section] objectForKey:@"ProjectArray"];
    return projectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"ContactInfoTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    NSMutableArray *projectArray = [[currentArray objectAtIndex:indexPath.section] objectForKey:@"ProjectArray"];
    ProjectInfo *info = [projectArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = info.projectname;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:30];
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"4977f1"];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"info" imageBundle:@"Project"]];
//    if ([info.isdelete isEqualToString:@"0"])
//    {
//        [cell.mySwitch setOn:YES];
//    }
//    else
//    {
//        [cell.mySwitch setOn:NO];
//    }
//    [cell.mySwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return currentArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ProjectSectionInfo *info = [[currentArray objectAtIndex:section] objectForKey:@"SectionInfo"];
    return info.sectionname;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableArray *projectArray = [[currentArray objectAtIndex:indexPath.section] objectForKey:@"ProjectArray"];
    ProjectInfo *info = [projectArray objectAtIndex:indexPath.row];
    NewEditProjectContentViewController *temp = [[NewEditProjectContentViewController alloc] init];
    temp.currentInfo = info;
    [self.navigationController pushViewController:temp animated:YES];
}

- (void)switchAction:(id)sender
{
    //获取点击按钮对应的cell
    UISwitch *switchInCell = (UISwitch *)sender;
    //UISwitch的superview就是cell
    UITableViewCell * cell = (UITableViewCell*) switchInCell.superview;
    NSIndexPath * indexPath = [editTableView indexPathForCell:cell];
    NSMutableArray *projectArray = [[currentArray objectAtIndex:indexPath.section] objectForKey:@"ProjectArray"];
    ProjectInfo *info = [projectArray objectAtIndex:indexPath.row];
    NSString *isdelete = @"0";
    if (!switchInCell.isOn)
    {
        isdelete = @"1";
    }
    [[ProjectDao shareInstanceProjectDao] updateProject:info.projectid andState:isdelete];
}

@end
