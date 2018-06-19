//
//  RecordListView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/6.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "RecordListView.h"
#import "RecordDao.h"
#import "ReViewPhotoView.h"

@implementation RecordListView
@synthesize delegate;

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
    titleLabel.text = @"记录";
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
    
    
    addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn addTarget:self action:@selector(commiteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setBackgroundColor:[UIColor colorWithHexString:@"44e6cd"]];
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [contentView addSubview:addBtn];
    
    
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
    
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(contentView.mas_bottom).offset(-60);
        make.left.equalTo(contentView.mas_left);
        make.right.equalTo(contentView.mas_right);
        make.bottom.equalTo(contentView.mas_bottom);
    }];
    
    
    
    curentArray = [[NSMutableArray alloc] init];
    return self;
    
}

-(void)setRecordListUserInfo:(ContactInfo *)info
{
    curentInfo = info;
    NSMutableArray *tempArray =  [[RecordDao shareInstanceRecordDao] getRecordByUserId:info.userId];
    [curentArray addObjectsFromArray:tempArray];
    [infoTableView reloadData];
}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    RecordListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSString *textToShare = @"要分享的账单";
//    UIImage *imageToShare = [UIImage getImageViewWithView:cell];
//    NSArray *activityItems = @[textToShare, imageToShare];
//    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
//    activityVC.excludedActivityTypes = @[UIActivityTypePostToTencentWeibo,UIActivityTypePostToWeibo];
//
//    [[self viewController] presentViewController:activityVC animated:YES completion:nil];

    RecordInfo *info = [curentArray objectAtIndex:indexPath.row];
    if (delegate)
    {
        [delegate RecordListViewEditRecord:info];
    }
    
    [self removeFromSuperview];

}

#pragma mark UITableVieDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return curentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"ContactInfoTableViewCell";
    RecordListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[RecordListCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
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


-(void)cancleBtnAction
{
    [self removeFromSuperview];
}

-(void)commiteBtnAction
{
    if (delegate)
    {
        [delegate RecordListViewAddNewRecord];
    }
    [self removeFromSuperview];
}


- (UIViewController*)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

-(void)RecordListCellSelectImage:(NSString *)imagePath
{
    if (delegate)
    {
        [delegate preViewImage:imagePath];
    }
}


@end
