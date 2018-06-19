//
//  BillDetailListView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/5.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "BillDetailListView.h"
#import "BillDao.h"
#import "BillInfo.h"
#import "BillDetailListCell.h"

@implementation BillDetailListView

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
    titleLabel.text = @"账单";
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
//    infoTableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    
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
        make.bottom.equalTo(contentView.mas_bottom).offset(0);
    }];

    curentArray = [[NSMutableArray alloc] init];
    return self;
    
}

-(void)setBillDetailUserInfo:(ContactInfo *)info
{
    curentInfo = info;
    curentArray = [[BillDao shareInstanceBillDao] getBillInfoByUser:curentInfo.userId];
    [infoTableView reloadData];
    NSLog(@"11111111");

}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    BillDetailListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIImage *image=[UIImage getImageViewWithView:cell];
    NSArray *postItems=@[image];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:postItems applicationActivities:nil];
    controller.completionWithItemsHandler = ^(UIActivityType  _Nullable   activityType,
                                              BOOL completed,
                                              NSArray * _Nullable returnedItems,
                                              NSError * _Nullable activityError) {
        
        NSLog(@"activityType: %@,\n completed: %d,\n returnedItems:%@,\n activityError:%@",activityType,completed,returnedItems,activityError);
    };

    // Change Rect to position Popover
    UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:controller];
    [popup presentPopoverFromRect:CGRectMake(700, 20, 400, 400) inView:rootViewController.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    [self cancleBtnAction];

    

}

#pragma mark UITableVieDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return curentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"ContactInfoTableViewCell";
    BillDetailListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[BillDetailListCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell billDetailListCellSetInfo:[curentArray objectAtIndex:indexPath.row]];
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BillInfo *info = [curentArray objectAtIndex:indexPath.row];
    float height = 150.;
    if (![NSObject isNullOrNilWithObject:info.userSign])
    {
        height = height + 200;
    }
//    height = height + 100;

    if (info.projectArray.count > 0)
    {
        height = height + 40*info.projectArray.count;
    }
    return height;
}


-(void)cancleBtnAction
{
//    [[MJPopTool sharedInstance] closeAnimated:YES];
    [self removeFromSuperview];
}








@end
