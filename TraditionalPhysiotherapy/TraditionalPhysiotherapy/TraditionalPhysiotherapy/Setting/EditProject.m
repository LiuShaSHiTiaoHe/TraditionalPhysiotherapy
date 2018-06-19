//
//  EditProject.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/30.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "EditProject.h"
#import "ProjectDao.h"
#import "ProjectSectionInfo.h"
#import "ProjectInfo.h"
#import "EditProjectListCell.h"

@implementation EditProject
@synthesize editTableView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
    {
        return nil;
    }
    
    self.backgroundColor = [UIColor colorWithHexString:@"f0f3f3"];

    backView = [[UIView alloc] init];
    [self addSubview:backView];
    
    UIView *myNavView = [[UIView alloc] init];
    myNavView.backgroundColor = [UIColor colorWithHexString:@"4977f1"];
    [backView addSubview:myNavView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"编辑项目";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:24.];
    [myNavView addSubview:titleLabel];
    
    
    editTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    editTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    editTableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
//    editTableView.delegate = self;
//    editTableView.dataSource = self;
    [self addSubview:editTableView];
    
    commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [commitButton addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [commitButton setBackgroundColor:[UIColor colorWithHexString:@"4eccff"]];
    [commitButton setTitle:@"确定" forState:UIControlStateNormal];
//    [backView addSubview:commitButton];
    
   
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
    
    [myNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(backView.mas_top);
        make.left.equalTo(backView.mas_left);
        make.right.equalTo(backView.mas_right);
        make.height.equalTo(70.);
    }];
    
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(myNavView.mas_top);
        make.right.equalTo(myNavView.mas_right);
        make.left.equalTo(myNavView.mas_left);
        make.height.equalTo(70.);
    }];
    
    [editTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(myNavView.mas_bottom).offset(20.);
        make.right.equalTo(backView.mas_right).offset(-10.);
        make.left.equalTo(backView.mas_left).offset(10.);
        make.bottom.equalTo(backView.mas_bottom).offset(-70.);
        
    }];
    
//    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(backView.mas_centerX).offset(-20.);
//        make.top.equalTo(editTableView.mas_bottom).offset(70.);
//        make.width.equalTo(300.);
//        make.height.equalTo(50.);
//
//    }];
    
//    currentArray = [[NSMutableArray alloc] init];
//    [self initData];
    
    return self;
}

-(void)initData
{
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

#pragma mark UITableVieDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *projectArray = [[currentArray objectAtIndex:section] objectForKey:@"ProjectArray"];
    return projectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"ContactInfoTableViewCell";
    EditProjectListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[EditProjectListCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    NSMutableArray *projectArray = [[currentArray objectAtIndex:indexPath.section] objectForKey:@"ProjectArray"];
    ProjectInfo *info = [projectArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = info.projectname;
    if ([info.isdelete isEqualToString:@"0"])
    {
        [cell.mySwitch setOn:YES];
    }
    else
    {
        [cell.mySwitch setOn:NO];
    }
    [cell.mySwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return currentArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ProjectSectionInfo *info = [[currentArray objectAtIndex:section] objectForKey:@"SectionInfo"];
    return info.sectionname;
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






