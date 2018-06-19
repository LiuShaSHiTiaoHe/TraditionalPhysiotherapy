//
//  SelectContactView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/4.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "SelectContactView.h"
#import "SelectContactCell.h"
#import "ContactsDao.h"
#import "OrderRecordInfo.h"
#import "ChineseToPinyin.h"

@implementation SelectContactView
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
    titleLabel.text = @"选择会员";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:22];
    titleLabel.textColor = [UIColor whiteColor];
    [titleView addSubview:titleLabel];
    
    cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setImage:[UIImage imageNamed:@"cancle" imageBundle:@"contact"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:cancleBtn];
    
    UIImageView *searchIconView = [[UIImageView alloc] init];
    searchIconView.image = [UIImage imageNamed:@"searchVip" imageBundle:@"contact"];
    [contentView addSubview:searchIconView];
    
    searchField = [[UITextField alloc] init];
    searchField.placeholder = @"搜索会员";
    searchField.textColor = [UIColor lightGrayColor];
    searchField.returnKeyType = UIReturnKeySearch;
    searchField.delegate = self;
    [contentView addSubview:searchField];
    
    searchCancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchCancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [searchCancleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [searchCancleBtn setBackgroundColor:[UIColor colorWithHexString:@"47b9fe"]];
//    searchCancleBtn.layer.cornerRadius = 10.;
//    searchCancleBtn.clipsToBounds = YES;
    [searchCancleBtn addTarget:self action:@selector(cancleSearch) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:searchCancleBtn];
    
    
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
    
    [searchIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(contentView.mas_left).offset(5);
        make.top.equalTo(titleView.mas_bottom).offset(25);
        make.width.equalTo(30.);
        make.height.equalTo(30.);
    }];
    
    [searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(contentView.mas_left).offset(45);
        make.top.equalTo(titleView.mas_bottom).offset(20);
        make.right.equalTo(contentView.mas_right).offset(-100);
        make.height.equalTo(40);
    }];
    
    [searchCancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(80);
        make.right.equalTo(contentView.mas_right).offset(-10);
        make.top.equalTo(titleView.mas_bottom).offset(20);
        make.height.equalTo(40);
    }];

    [infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(contentView.mas_left);
        make.right.equalTo(contentView.mas_right);
        make.top.equalTo(titleView.mas_bottom).offset(70);
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
    searchArray = [[NSMutableArray alloc] init];
    allPeopleArray = [[NSMutableArray alloc] init];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    tempArray = [[ContactsDao shareInstanceContactDao] getAllUser];
    [allPeopleArray addObjectsFromArray:tempArray];
    for (ContactInfo *info in tempArray)
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:info forKey:@"info"];
        [dic setObject:@"no" forKey:@"select"];
        [contactArray addObject:dic];
        [searchArray addObject:dic];
    }
    searchString = @"";
    [infoTableView reloadData];
}

-(void)cleanState
{
    for (NSMutableDictionary *dic in searchArray)
    {
        [dic setObject:@"no" forKey:@"select"];
    }
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self cleanState];
    NSMutableDictionary *dic = [searchArray objectAtIndex:indexPath.row];
    [dic setObject:@"yes" forKey:@"select"];
    searchString = @"";
    searchField.text = @"";
    [searchField resignFirstResponder];
    [tableView reloadData];
}

#pragma mark UITableVieDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (searchString.length > 0)
//    {
//        return searchArray.count;
//    }
//    else
//    {
//        return contactArray.count;
//    }
    return searchArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"ContactInfoTableViewCell";
    SelectContactCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[SelectContactCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    [cell configWithEntity:[searchArray objectAtIndex:indexPath.row]];
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


-(void)cancleSearch
{
    searchString = @"";
    searchField.text = @"";
    [searchField resignFirstResponder];
    [searchArray removeAllObjects];
    [searchArray addObjectsFromArray:contactArray];
    [infoTableView reloadData];
}

#pragma mark UITextFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length > 0)
    {
        searchString = textField.text;
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (int i = 0; i<allPeopleArray.count; i++)
        {
            ContactInfo *model = allPeopleArray[i];
            NSString *lowStr = [ChineseToPinyin pinyinFromChineseString:searchString withSpace:NO ];
            NSString *allStr =[ChineseToPinyin pinyinFromChineseString:model.userName withSpace:NO ];
            //**********手机号模糊搜索*************//
            if ([model.userPhone rangeOfString:searchString].location != NSNotFound)
            {
                
                [tempArray addObject:model];
            }
            
            //**********姓模糊搜索*************//
//            searchString = [NSString stringWithFormat:@"%c",[ChineseToPinyin sortSectionTitle:searchString]];
            BOOL isHas = [allStr isEqualToString:lowStr];
            BOOL isPY = false;
            if ( lowStr || lowStr.length != 0)
            {
                isPY = [allStr hasPrefix:lowStr];
            }
            if (isHas)
            {
                //这种情况是精确查找。
                [tempArray addObject:model];//讲搜索后的数据添加到数组中
                
            }
            else
            {
                if (isPY && !isHas)
                {
                    [tempArray addObject:model];
                }
            }
        }
        [searchArray removeAllObjects];
        for (ContactInfo *info in tempArray)
        {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:info forKey:@"info"];
            [dic setObject:@"no" forKey:@"select"];
            [searchArray addObject:dic];
        }
        
        [infoTableView reloadData];
    }
    return YES;
}

#pragma mark 页面事件
-(void)cancleBtnAction
{
    [self hideInController];
}


-(void)commiteBtnAction
{
    
    for (NSDictionary *dic in searchArray)
    {
        if ([[dic objectForKey:@"select"] isEqualToString:@"yes"])
        {
            [OrderRecordInfo shareOrderRecordInfo].contactInfo = [dic objectForKey:@"info"];
            break;
        }
    }
    if (delegate)
    {
        [delegate SelectContact:[OrderRecordInfo shareOrderRecordInfo].contactInfo];
    }

    
    [self cancleBtnAction];
}


@end
