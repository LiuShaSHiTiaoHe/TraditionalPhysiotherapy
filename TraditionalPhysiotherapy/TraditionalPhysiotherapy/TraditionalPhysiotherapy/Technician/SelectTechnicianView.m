//
//  SelectTechnicianView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/27.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "SelectTechnicianView.h"
#import "SelectContactCell.h"
#import "TechnicianDao.h"
#import "OrderRecordInfo.h"
#import "ProjectInfo.h"
#import "TechnicianInfo.h"

@implementation SelectTechnicianView
@synthesize delegate;
@synthesize indexPath;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
    {
        return nil;
    }
    
    maskView = [UIView new];
    maskView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];;
    [self addSubview:maskView];
    
    contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 20.;
    contentView.clipsToBounds = YES;
    [self addSubview:contentView];
    
    titleView = [[UIImageView alloc] init];
    titleView.userInteractionEnabled = YES;
    titleView.backgroundColor = [UIColor colorWithHexString:@"4977f1"];
    [contentView addSubview:titleView];
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"选择技师";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:22];
    titleLabel.textColor = [UIColor whiteColor];
    [titleView addSubview:titleLabel];
    
    cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setImage:[UIImage imageNamed:@"cancle" imageBundle:@"contact"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:cancleBtn];
    
    
    infoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    infoTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    infoTableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    infoTableView.dataSource = self;
    infoTableView.delegate = self;
    [contentView addSubview:infoTableView];
    
    commiteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commiteBtn addTarget:self action:@selector(commiteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [commiteBtn setBackgroundColor:[UIColor colorWithHexString:@"44e6cd"]];
    [commiteBtn setTitle:@"确定" forState:UIControlStateNormal];
    [contentView addSubview:commiteBtn];
    
    
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
    
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(60.);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(400.);
        make.height.equalTo(600.);
        
    }];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(contentView.mas_left);
        make.top.equalTo(contentView.mas_top);
        make.right.equalTo(contentView.mas_right);
        make.height.equalTo(60.);
        
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(titleView.mas_centerY);
        make.centerX.equalTo(titleView.mas_centerX);
        make.width.equalTo(160.);
        make.height.equalTo(30.);
    }];
    
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(titleView.mas_right).offset(-20.);
        make.centerY.equalTo(titleView.mas_centerY);
        make.width.equalTo(80/3);
        make.height.equalTo(80/3);
    }];
    
    
    [infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(contentView.mas_left);
        make.right.equalTo(contentView.mas_right);
        make.top.equalTo(titleView.mas_bottom);
        make.bottom.equalTo(contentView.mas_bottom).offset(-50);
    }];
    
    
    [commiteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(infoTableView.mas_bottom);
        make.left.equalTo(contentView.mas_left);
        make.right.equalTo(contentView.mas_right);
        make.bottom.equalTo(contentView.mas_bottom);
    }];
    
    
    [self initData];
    return self;
    
}


-(void)initData
{
    contactArray = [[NSMutableArray alloc] init];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    tempArray = [[TechnicianDao shareInstanceTechnicianDao] getAllTechnichian];
    
    for (TechnicianInfo *info in tempArray)
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:info forKey:@"info"];
        [dic setObject:@"no" forKey:@"select"];
        [contactArray addObject:dic];
    }
    
    [infoTableView reloadData];
}

-(void)cleanState
{
    for (NSMutableDictionary *dic in contactArray)
    {
        [dic setObject:@"no" forKey:@"select"];
    }
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self cleanState];
    NSMutableDictionary *dic = [contactArray objectAtIndex:indexPath.row];
    [dic setObject:@"yes" forKey:@"select"];
    
    [tableView reloadData];
}

#pragma mark UITableVieDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contactArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"ContactInfoTableViewCell";
    SelectContactCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[SelectContactCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    [cell configWithTechnicianEntity:[contactArray objectAtIndex:indexPath.row]];
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

#pragma mark 页面事件
-(void)cancleBtnAction
{
    [self hideInController];
}


-(void)commiteBtnAction
{
    TechnicianInfo *selectedInfo = [[TechnicianInfo alloc] init];
    for (NSDictionary *dic in contactArray)
    {
        if ([[dic objectForKey:@"select"] isEqualToString:@"yes"])
        {
            selectedInfo = [dic objectForKey:@"info"];
            ProjectInfo *projectInfo = [[[OrderRecordInfo shareOrderRecordInfo].projectArray objectAtIndex:indexPath.row] objectForKey:@"info"];
            [[OrderRecordInfo shareOrderRecordInfo].technicianDic setObject:selectedInfo forKey:projectInfo.projectid];
            break;
        }
    }
    if (delegate)
    {
        [delegate SelectTechnician:selectedInfo];
    }
    
    
    [self cancleBtnAction];
}




@end
