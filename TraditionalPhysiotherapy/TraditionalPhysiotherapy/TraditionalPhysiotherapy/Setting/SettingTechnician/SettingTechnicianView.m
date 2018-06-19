//
//  SettingTechnicianView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/6.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "SettingTechnicianView.h"

@implementation SettingTechnicianView
@synthesize delegate;
@synthesize settechnicianTable;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
    {
        return nil;
    }
    self.backgroundColor = [UIColor colorWithHexString:@"f0f3f3"];

    UIView *myNavView = [[UIView alloc] init];
    myNavView.backgroundColor = [UIColor colorWithHexString:@"4977f1"];
    [self addSubview:myNavView];
    
    UIButton *addContactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addContactBtn setImage:[UIImage imageNamed:@"777" imageBundle:@"Menu"] forState:UIControlStateNormal];
    [addContactBtn addTarget:self action:@selector(AddTechnicianAction) forControlEvents:UIControlEventTouchUpInside];
    [myNavView addSubview:addContactBtn];
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"技师";
    titleLabel.font = [UIFont systemFontOfSize:22];
    titleLabel.textColor = [UIColor whiteColor];
    [myNavView addSubview:titleLabel];
    
    settechnicianTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    settechnicianTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    settechnicianTable.backgroundColor = [UIColor whiteColor];
    [self addSubview:settechnicianTable];
    
    [myNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(70.);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNavView.mas_top).offset(30.);
        make.centerX.equalTo(myNavView.mas_centerX);
        make.width.equalTo(100.);
        make.height.equalTo(30.);
        
    }];

    [addContactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(myNavView.mas_top).offset(30.);
        make.left.equalTo(myNavView.mas_right).offset(-50);
        make.width.equalTo(30.);
        make.height.equalTo(30.);
    }];
    
    
    [settechnicianTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNavView.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
    
    
    return self;
}

-(void)AddTechnicianAction
{
    if (delegate)
    {
        [delegate addTechnician];
    }
}






@end
