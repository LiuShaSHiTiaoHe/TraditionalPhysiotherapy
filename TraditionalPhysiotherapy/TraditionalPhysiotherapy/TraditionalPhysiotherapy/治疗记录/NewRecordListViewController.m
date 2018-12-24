//
//  NewRecordListViewController.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/17.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import "NewRecordListViewController.h"
#import "NewAddRecordViewController.h"

#import "RecordListCell.h"
#import "NewRecordListCell.h"
#import "ReViewPhotoView.h"
#import "RecordDao.h"
#import "AddRecordView.h"
#import "EditRecordView.h"

@interface NewRecordListViewController ()<UITableViewDelegate,UITableViewDataSource,NewRecordListCellDelegate>
{
    UITableView *infoTableView;
    NSMutableArray *curentArray;
}

@end

@implementation NewRecordListViewController
@synthesize curentInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    curentArray = [NSMutableArray new];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initData];

}

-(void)initData
{
    [curentArray removeAllObjects];
    curentArray =  [[RecordDao shareInstanceRecordDao] getRecordByUserId:curentInfo.userId];
    [infoTableView reloadData];
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
    titleLabel.text = [NSString stringWithFormat:@"%@的记录",curentInfo.userName];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:30];
    [myNavView addSubview:titleLabel];
    
    UIButton *addContactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addContactBtn setImage:[UIImage imageNamed:@"navAdd" imageBundle:@"Menu"] forState:UIControlStateNormal];
    [addContactBtn addTarget:self action:@selector(AddNewRecord) forControlEvents:UIControlEventTouchUpInside];
    [myNavView addSubview:addContactBtn];
    
    infoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    infoTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    infoTableView.dataSource = self;
    infoTableView.delegate = self;
    [self.view addSubview:infoTableView];
    
    
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
    
    
    [infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNavView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        
    }];
    
}

-(void)backBtnAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)AddNewRecord
{
//    AddRecordView *bview = [[AddRecordView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
//    [bview setAddRecordViewInfo:curentInfo];
//    [self.view addSubview:bview];
    NewAddRecordViewController *temp = [[NewAddRecordViewController alloc] init];
    temp.curentInfo = curentInfo;
    [self presentViewController:temp animated:YES completion:^{
        
    }];
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    RecordInfo *info = [curentArray objectAtIndex:indexPath.row];
//    EditRecordView *bview = [[EditRecordView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
//    [bview setAddRecordViewInfo:curentInfo];
//    [bview setEditRecordInfo:info];
//    [self.view addSubview:bview];
    
    NewAddRecordViewController *temp = [[NewAddRecordViewController alloc] init];
    temp.curentInfo = curentInfo;
    temp.currentRecordInfo = info;
    [self presentViewController:temp animated:YES completion:^{
        
    }];
    
}

#pragma mark UITableVieDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return curentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"ContactInfoTableViewCell";
    NewRecordListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[NewRecordListCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    [cell recordListCellSetRecordInfo:[curentArray objectAtIndex:indexPath.row]];
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordInfo *info = [curentArray objectAtIndex:indexPath.row];
    float height = 280.;
    
    if (info.recordimage.count > 0)
    {
        
        height = height + (420/3)*(info.recordimage.count/3);
        if (info.recordimage.count%3>0)
        {
            height = height +(410/3);
        }
    }
    return height;
}



-(void)RecordListCellSelectImage:(NSString *)imagePath
{
    ReViewPhotoView *review = [[ReViewPhotoView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight) Photo:[UIImage imageWithContentsOfFile:imagePath]];
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionReveal;
    transition.duration = 0.5;
    [review.layer addAnimation:transition forKey:nil];
    [self.view addSubview:review];
}
@end
