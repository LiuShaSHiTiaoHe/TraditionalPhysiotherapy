//
//  NewTechnicianSetViewController.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/12.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import "NewTechnicianSetViewController.h"
#import "TechnicianTableViewCell.h"
#import "TechnicianDao.h"
#import "TechnicianInfo.h"
#import "AddTechnician.h"
#import "TechnicianDetailViewController.h"

@interface NewTechnicianSetViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *settechnicianTable;
    NSMutableArray *technicianArray;
    NSMutableDictionary *imageDic;
    UIImage *maleImage;
    UIImage *femaleImage;
}

@end

@implementation NewTechnicianSetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    technicianArray = [NSMutableArray new];
    imageDic = [[NSMutableDictionary alloc] init];
    NSData *data = UIImageJPEGRepresentation([UIImage imageNamed:@"male" imageBundle:@"contact"], 0.1);
    maleImage = [UIImage imageWithData:data];
    data = UIImageJPEGRepresentation([UIImage imageNamed:@"female" imageBundle:@"contact"], 0.1);
    femaleImage= [UIImage imageWithData:data];
    
    [self getContacts];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:TechnicianDataBaseChange object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TechnicianDataBaseChange object:nil];
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
    titleLabel.text = @"人员管理";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:30];
    [myNavView addSubview:titleLabel];
    
    UIButton *addContactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addContactBtn setImage:[UIImage imageNamed:@"navAdd" imageBundle:@"Menu"] forState:UIControlStateNormal];
    [addContactBtn addTarget:self action:@selector(AddTechnicianAction) forControlEvents:UIControlEventTouchUpInside];
    [myNavView addSubview:addContactBtn];
    
    
    settechnicianTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    settechnicianTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    settechnicianTable.backgroundColor = [UIColor whiteColor];
    settechnicianTable.delegate = self;
    settechnicianTable.dataSource = self;
    [self.view addSubview:settechnicianTable];

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
    
    [addContactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(myNavView.mas_centerY).offset(20.);
        make.right.equalTo(myNavView.mas_right).offset(-30.);
        make.width.height.equalTo(50);
    }];
    
    [settechnicianTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNavView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        
    }];
}


-(void)backBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getContacts
{
    [technicianArray removeAllObjects];
    technicianArray = [[TechnicianDao shareInstanceTechnicianDao] getAllTechnichian];
    for (TechnicianInfo *info in technicianArray)
    {
        if (![NSObject isNullOrNilWithObject:info.technicianImage])
        {
            UIImage *tempImage = [UIImage imageWithContentsOfFile:info.technicianImage];
            UIImage *resultImage = [GlobalDataManager resizeImageByvImage:tempImage withScale:0.1];
            [imageDic setObject:resultImage forKey:info.technicianid];
        }
    }
    [settechnicianTable reloadData];
}


-(void)AddTechnicianAction
{
    AddTechnician *AddTechnicianView = [[AddTechnician alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    [self.view addSubview:AddTechnicianView];
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
    cell.nameLabel.text = info.technicianname;
    
    UIImage *headImage = [imageDic objectForKey:info.technicianid];
    if (headImage)
    {
        cell.headPic.image = headImage;
    }
    else
    {
        if ([info.technicianGender isEqualToString:@"male"])
        {
            cell.headPic.image = maleImage;
        }
        else
        {
            cell.headPic.image = femaleImage;
        }
        
    }
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


@end
