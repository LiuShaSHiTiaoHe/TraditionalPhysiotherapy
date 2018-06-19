//
//  SettingTechnicianViewController.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/6.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "SettingTechnicianViewController.h"
#import "TechnicianDao.h"
#import "TechnicianInfo.h"
#import "TechnicianTableViewCell.h"
#import "TechnicianDetailViewController.h"

@interface SettingTechnicianViewController ()

@end

@implementation SettingTechnicianViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    //设置导航条标题字体和颜色
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.200 alpha:1.000]}];
////    UINavigationBar *navigationBar = self.navigationController.navigationBar;
////    //设置透明的背景图，便于识别底部线条有没有被隐藏
////    [navigationBar setBackgroundImage:[[UIImage alloc] init]
////                       forBarPosition:UIBarPositionAny
////                           barMetrics:UIBarMetricsDefault];
////    //此处使底部线条失效
////    [navigationBar setShadowImage:[UIImage new]];

    contentView = [[SettingTechnicianView alloc] init];
    contentView.delegate  = self;
    contentView.settechnicianTable.dataSource = self;
    contentView.settechnicianTable.delegate = self;
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:TechnicianDataBaseChange object:nil];
    
    technicianArray = [NSMutableArray new];
    
    [self getContacts];
}

-(void)getContacts
{
    [technicianArray removeAllObjects];
    technicianArray = [[TechnicianDao shareInstanceTechnicianDao] getAllTechnichian];
    [contentView.settechnicianTable reloadData];
}


-(void)addTechnician
{
    if (delegate)
    {
        [delegate addTechnicianToVC];
    }
}


-(void)refreshTableView
{
    [self getContacts];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TechnicianDetailViewController *vc = [[TechnicianDetailViewController alloc] init];
    TechnicianInfo *info = [technicianArray objectAtIndex:indexPath.row];
    vc.currentInfo = info;
//    [vc setcurrentInfo:info];
    vc.view.frame = CGRectMake(0, 0, UIScreenWidth-449, UIScreenHeight-60);;
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return technicianArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"TableViewCell";
    TechnicianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[TechnicianTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
   
    TechnicianInfo *info = [technicianArray objectAtIndex:indexPath.row];
    [cell configWithEntity:info];
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.;
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
