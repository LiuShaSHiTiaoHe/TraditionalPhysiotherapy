//
//  ContactsView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 11/12/2017.
//  Copyright © 2017 Gu GuiJun. All rights reserved.
//

#import "ContactsView.h"

@implementation ContactsView
@synthesize contactListView,searchBar,contentScrollView;
@synthesize addContactBtn;
@synthesize delegate;

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
    titleLabel.text = @"会员";
    titleLabel.font = [UIFont systemFontOfSize:22];
    titleLabel.textColor = [UIColor whiteColor];
    [myNavView addSubview:titleLabel];
    
    addContactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addContactBtn setImage:[UIImage imageNamed:@"add" imageBundle:@"contact"] forState:UIControlStateNormal];
    [addContactBtn addTarget:self action:@selector(AddNewContactAction) forControlEvents:UIControlEventTouchUpInside];
    [myNavView addSubview:addContactBtn];
    
    searchBar = [[UISearchBar alloc] init];
    searchBar.barStyle = UISearchBarStyleDefault;
    searchBar.placeholder = @"搜索联系人";

    for (UIView *subView in searchBar.subviews)
    {
        if ([subView isKindOfClass:[UIView  class]])
        {
            [[subView.subviews objectAtIndex:0] removeFromSuperview];
            if ([[subView.subviews objectAtIndex:0] isKindOfClass:[UITextField class]])
            {
                UITextField *textField = [subView.subviews objectAtIndex:0];
                textField.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                //设置默认文字颜色
                UIColor *color = [UIColor grayColor];
                [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"搜索会员" attributes:@{NSForegroundColorAttributeName:color}]];
                //修改默认的放大镜图片
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
                imageView.backgroundColor = [UIColor clearColor];
                imageView.image = [UIImage imageNamed:@"search" imageBundle:@"contact"];
                textField.leftView = imageView;
            }
        }
    }
    
    [self addSubview:searchBar];
    
    contactListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    contactListView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    contactListView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [self addSubview:contactListView];
    
    UIImageView *line = [UIImageView new];
    line.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:line];
    
    contentScrollView = [[UIView alloc] init];
//    contentScrollView.backgroundColor = [UIColor redColor];
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
    
    [addContactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(myNavView.mas_top).offset(30.);
        make.right.equalTo(myNavView.mas_right).offset(-20);
        make.width.equalTo(30.);
        make.height.equalTo(30.);
    }];
    
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNavView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(449.);
        make.height.equalTo(40.);
        
    }];
    
    [contactListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchBar.mas_bottom);
        make.bottom.equalTo(self.mas_bottom).offset(-45);
        make.width.equalTo(449);
        make.left.equalTo(self.mas_left);
        
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(.5);
        make.left.equalTo(contactListView.mas_right);
        
    }];
    
    [contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(line.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    
    return self;
}

-(void)isSearching:(BOOL)searchFlag
{
    myNavView.hidden = searchFlag;

    if (searchFlag)
    {
        [searchBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(myNavView.mas_top);
        }];
    }
    else
    {
        
        
        [searchBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(myNavView.mas_top).offset(70);

        }];
    }
}


-(void)AddNewContactAction
{
    if (delegate)
    {
        [delegate ContactViewAdd];
    }
}






@end









