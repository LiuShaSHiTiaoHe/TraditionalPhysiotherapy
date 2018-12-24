//
//  OrderView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/4.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "OrderView.h"
#import "OrderRecordInfo.h"
#import "ProjectListTableViewCell.h"

@implementation OrderView
@synthesize delegate;

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        backView = [UIView new];
        backView.backgroundColor = [UIColor clearColor];
        [self addSubview:backView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [backView addGestureRecognizer:tap];
        
        contentView = [UIImageView new];
        contentView.userInteractionEnabled = YES;
        contentView.backgroundColor = [UIColor whiteColor];
        [backView addSubview:contentView];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"已选择";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:22];
        titleLabel.textColor = [UIColor lightGrayColor];
        [contentView addSubview:titleLabel];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        
        infoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        infoTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        infoTableView.backgroundColor = [UIColor clearColor];
        infoTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        infoTableView.dataSource = self;
        infoTableView.delegate = self;
        [contentView addSubview:infoTableView];
        
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line1];
        
        
        totalLabel = [[UILabel alloc] init];
        totalLabel.textAlignment = NSTextAlignmentLeft;
        totalLabel.adjustsFontSizeToFitWidth = YES;
        totalLabel.font = [UIFont systemFontOfSize:22];
        totalLabel.textColor = [UIColor lightGrayColor];
        [contentView addSubview:totalLabel];
        
        cleanCart = [UIButton buttonWithType:UIButtonTypeCustom];
        [cleanCart setTitle:@"清空" forState:UIControlStateNormal];
        cleanCart.layer.cornerRadius = 5.;
        cleanCart.clipsToBounds = YES;
        [cleanCart setBackgroundColor:[UIColor colorWithHexString:@"4eccff"]];
        [cleanCart addTarget:self action:@selector(cleanCartAction) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:cleanCart];
        
        commiteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [commiteBtn setTitle:@"结算" forState:UIControlStateNormal];
        commiteBtn.layer.cornerRadius = 5.;
        commiteBtn.clipsToBounds = YES;
        [commiteBtn setBackgroundColor:[UIColor colorWithHexString:@"4eccff"]];
        [commiteBtn addTarget:self action:@selector(commiteBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:commiteBtn];
        
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            
        }];
        
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).offset(70);
            make.right.equalTo(self.mas_right).offset(-20);
            make.width.equalTo(500.);
            make.height.equalTo(470.);
            
        }];
        
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(contentView.mas_top).offset(0.);
            make.centerX.equalTo(contentView.mas_centerX);
            make.width.equalTo(160.);
            make.height.equalTo(40.);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(titleLabel.mas_bottom);
            make.right.equalTo(contentView.mas_right).offset(-20.);
            make.left.equalTo(contentView.mas_left).offset(20.);
            make.height.equalTo(1.);
        }];
        
        [infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(contentView.mas_left);
            make.right.equalTo(contentView.mas_right);
            make.top.equalTo(line.mas_bottom).offset(5.);
            make.bottom.equalTo(contentView.mas_bottom).offset(-70);
        }];
        
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(infoTableView.mas_bottom);
            make.right.equalTo(contentView.mas_right).offset(-20.);
            make.left.equalTo(contentView.mas_left).offset(20.);
            make.height.equalTo(1.);
        }];
        
        [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(contentView.mas_left).offset(20.);
            make.width.equalTo(130);
            make.height.equalTo(50);
            make.bottom.equalTo(contentView.mas_bottom).offset(-10.);
        }];
        
        
        [commiteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(140);
            make.right.equalTo(contentView.mas_right).offset(-20);
            make.height.equalTo(50);
            make.bottom.equalTo(contentView.mas_bottom).offset(-10.);
        }];
        
        [cleanCart mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(140);
            make.right.equalTo(commiteBtn.mas_left).offset(-20);
            make.height.equalTo(50);
            make.bottom.equalTo(contentView.mas_bottom).offset(-10.);
        }];
        
        
        [self updateTotalMoney];

    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTotalMoney) name:CartProjectChanged object:nil];

    return self;
}

-(void)updateTotalMoney
{
    NSMutableArray *arr = [OrderRecordInfo shareOrderRecordInfo].projectArray;
    NSInteger totalPrice = 0;
    for (NSMutableDictionary *dic in arr)
    {
        if ([OrderRecordInfo shareOrderRecordInfo].contactInfo.userId)
        {
            NSInteger count = [[dic objectForKey:@"count"] integerValue];
            ProjectInfo *info = [dic objectForKey:@"info"];
            NSInteger price = [info.vipprice integerValue];
            totalPrice = totalPrice + count * price;
        }
        else
        {
            NSInteger count = [[dic objectForKey:@"count"] integerValue];
            ProjectInfo *info = [dic objectForKey:@"info"];
            NSInteger price = [info.projectprice integerValue];
            totalPrice = totalPrice + count * price;
        }
        
    }
    totalLabel.text = [NSString stringWithFormat:@"总价:  %ld 元",totalPrice];
}

-(void)cleanCartAction
{
    [[OrderRecordInfo shareOrderRecordInfo].projectArray removeAllObjects];
    [[NSNotificationCenter defaultCenter] postNotificationName:CartProjectChanged object:nil];
    totalLabel.text = @"";
    [infoTableView reloadData];

}

-(void)commiteBtnAction
{
    if (delegate)
    {
        [delegate willGotoPayMentView];
    }
    [self hideInController];
}

-(void)tapAction
{
    [self hideInController];
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark UITableVieDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [OrderRecordInfo shareOrderRecordInfo].projectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"ContactInfoTableViewCell";
    ProjectListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[ProjectListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }

    NSMutableDictionary *dic = [[OrderRecordInfo shareOrderRecordInfo].projectArray objectAtIndex:indexPath.row];
    [cell setProjectListInfo:dic];
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
