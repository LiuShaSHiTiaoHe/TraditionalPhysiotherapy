//
//  EditProjectViewController.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/4/25.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "EditProjectViewController.h"
#import "ProjectDao.h"
#import "ProjectSectionInfo.h"
#import "ProjectInfo.h"
#import "EditProjectListCell.h"
#import "ProjectDetailViewController.h"

@interface EditProjectViewController ()

@end

@implementation EditProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;

    contentView = [[EditProject alloc] init];
//    contentView.delegate  = self;
    contentView.editTableView.dataSource = self;
    contentView.editTableView.delegate = self;
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
    
    currentArray = [[NSMutableArray alloc] init];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
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
    [contentView.editTableView reloadData];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectDetailViewController *vc = [[ProjectDetailViewController alloc] init];
    NSMutableArray *projectArray = [[currentArray objectAtIndex:indexPath.section] objectForKey:@"ProjectArray"];
    ProjectInfo *info = [projectArray objectAtIndex:indexPath.row];
    vc.currentInfo = info;
    vc.view.frame = CGRectMake(0, 0, UIScreenWidth-449, UIScreenHeight-60);;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)switchAction:(id)sender
{
    //获取点击按钮对应的cell
    UISwitch *switchInCell = (UISwitch *)sender;
    //UISwitch的superview就是cell
    UITableViewCell * cell = (UITableViewCell*) switchInCell.superview;
    NSIndexPath * indexPath = [contentView.editTableView indexPathForCell:cell];
    NSMutableArray *projectArray = [[currentArray objectAtIndex:indexPath.section] objectForKey:@"ProjectArray"];
    ProjectInfo *info = [projectArray objectAtIndex:indexPath.row];
    NSString *isdelete = @"0";
    if (!switchInCell.isOn)
    {
        isdelete = @"1";
    }
    [[ProjectDao shareInstanceProjectDao] updateProject:info.projectid andState:isdelete];
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
