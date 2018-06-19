//
//  SettingView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/21.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "SettingView.h"

@implementation SettingView
@synthesize settingListView;
@synthesize contentScrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
    {
        return nil;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    
//    titleImageView = [[UIImageView alloc] init];
//    titleImageView.backgroundColor = [UIColor clearColor];
//    [self addSubview:titleImageView];
    
    myNavView = [[UIView alloc] init];
    myNavView.backgroundColor = [UIColor colorWithHexString:@"4977f1"];
    [self addSubview:myNavView];
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"设置";
    titleLabel.font = [UIFont systemFontOfSize:22];
    titleLabel.textColor = [UIColor whiteColor];
    [myNavView addSubview:titleLabel];
    
    
    settingListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    settingListView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    settingListView.backgroundColor = [UIColor colorWithHexString:@"f0f3f3"];
    [self addSubview:settingListView];
    
    
    contentScrollView = [[UIScrollView alloc] init];
//    contentScrollView.backgroundColor = [UIColor redColor];
    contentScrollView.frame = CGRectMake(449, 0, UIScreenWidth-449, UIScreenHeight-60);
    contentScrollView.contentSize = CGSizeMake(UIScreenWidth-449, 1300.);
    [self addSubview:contentScrollView];
    
//    [titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top);
//        make.right.equalTo(self.mas_right);
//        make.left.equalTo(self.mas_left);
//        make.height.equalTo(20.);
//
//    }];
    
    [myNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(449.);
        make.height.equalTo(70.);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNavView.mas_top).offset(30.);
        make.centerX.equalTo(myNavView.mas_centerX);
        make.width.equalTo(100.);
        make.height.equalTo(30.);
        
    }];
    
    
    [settingListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNavView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(449);
        make.left.equalTo(self.mas_left);
        
    }];
    
//    [contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(titleImageView.mas_bottom);
//        make.left.equalTo(settingListView.mas_right);
//        make.bottom.equalTo(self.mas_bottom).offset(-40.);
//        make.right.equalTo(self.mas_right);
//    }];
    
    return self;
}


@end
