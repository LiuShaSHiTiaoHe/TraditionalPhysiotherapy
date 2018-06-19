//
//  RechargeRecordView.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/6/3.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "RechargeRecordView.h"
#import "ContactInfo.h"
#import "RecordDao.h"
#import "RechargeRecordTableViewCell.h"

@implementation RechargeRecordView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
    {
        return nil;
    }
    
    self.backgroundColor = [UIColor clearColor];
    
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
    titleLabel.text = @"充值记录";
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
    infoTableView.dataSource = self;
    infoTableView.delegate = self;
    [contentView addSubview:infoTableView];
    
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
    
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(80.);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(600.);
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
        make.bottom.equalTo(contentView.mas_bottom).offset(-60);
    }];
    
    curentArray = [[NSMutableArray alloc] init];
    return self;
}

-(void)cancleBtnAction
{
    [self removeFromSuperview];
}

-(void)setRecordListUserInfo:(ContactInfo *)info
{
    currentInfo = info;
    NSMutableArray *tempArray =  [[RecordDao shareInstanceRecordDao] getRechargeRecordByUserId:info.userId];
    [curentArray addObjectsFromArray:tempArray];
    [infoTableView reloadData];
}


#pragma mark UITableVieDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return curentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"ContactInfoTableViewCell";
    RechargeRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[RechargeRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic = [curentArray objectAtIndex:indexPath.row];
    cell.timeLabel.text = [dic objectForKey:@"rechargeDate"];
    cell.numLabel.text = [NSString stringWithFormat:@"充值成功 + %@ 元!      余额: %@ 元",[dic objectForKey:@"rechargeNum"],[dic objectForKey:@"totalNum"]];

    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 60;
}

@end
