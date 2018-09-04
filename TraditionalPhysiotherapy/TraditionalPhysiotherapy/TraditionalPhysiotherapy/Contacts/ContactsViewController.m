//
//  ContactsViewController.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 11/12/2017.
//  Copyright © 2017 Gu GuiJun. All rights reserved.
//

#import "ContactsViewController.h"
#import "ContactInfoTableViewCell.h"
#import "ContactsDao.h"
#import "ContactInfo.h"
#import "UserDetailView.h"
#import "AddVIPView.h"

#import "pinyin.h"
#import "NameString.h"
#import "UnlockView.h"

@interface ContactsViewController ()<UserDetailViewDelegate>
{
    NSMutableArray *contactArray;
    NSMutableArray *contactPYnameArray;
    NSMutableArray *sectionKeys;
    NSString *_keyWord;
    UserDetailView *userDetailView;
    UnlockView *unLockView;
    BOOL isSearching;
}

@end

@implementation ContactsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    contentView = [[ContactsView alloc] init];
    contentView.contactListView.dataSource = self;
    contentView.contactListView.delegate = self;
    contentView.searchBar.delegate = self;
    contentView.delegate = self;
    
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    userDetailView = [[UserDetailView alloc] init];
    [contentView.contentScrollView addSubview:userDetailView];
    userDetailView.delegate = self;
    [userDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.contentScrollView.mas_top).offset(-20);
        make.left.equalTo(contentView.contentScrollView.mas_left);
        make.right.equalTo(contentView.contentScrollView.mas_right);
        make.bottom.equalTo(contentView.contentScrollView.mas_bottom);

    }];
    userDetailView.hidden = YES;
    [self showLockView];
    
    contactArray = [[NSMutableArray alloc] init];
    sectionKeys = [[NSMutableArray alloc] init];
    contactPYnameArray = [[NSMutableArray alloc] init];
    isSearching = NO;
    [self getContacts];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getContacts) name:UserDataBaseChanged object:nil];
}

-(void)getContacts
{
    contactArray = [[ContactsDao shareInstanceContactDao] getAllUser];
    [self getChineseStringArr:contactArray];
    [contentView.contactListView reloadData];
    userDetailView.hidden = YES;

}

-(void)autoLayoutSubViews
{

}


#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    userDetailView.hidden = NO;
//    NSString *cStr = [sectionKeys objectAtIndex:indexPath.section];
//    for(int index = 0; index < [contactPYnameArray count]; index++)
//    {
//        NameString *chineseStr = [contactPYnameArray objectAtIndex:index];
//        NSMutableString *strchar= [NSMutableString stringWithString:chineseStr.pyString];
//        NSString *sr= [strchar substringToIndex:1];
//        if ([sr isEqualToString:cStr])
//        {
//            for (ContactInfo *info in contactArray)
//            {
//                if ([info.userId isEqualToString:chineseStr.userId])
//                {
//                    [userDetailView setViewData:info];
//                    break;
//                }
//            }
//        }
//    }
    
    
    NSString *cStr = [sectionKeys objectAtIndex:indexPath.section];
    NSMutableArray *countArray = [[NSMutableArray alloc] init];
    
    for(int index = 0; index < [contactPYnameArray count]; index++)
    {
        NameString *chineseStr = [contactPYnameArray objectAtIndex:index];
        NSMutableString *strchar= [NSMutableString stringWithString:chineseStr.pyString];
        NSString *sr= [strchar substringToIndex:1];
        if ([sr isEqualToString:cStr])
        {
            [countArray addObject:chineseStr];
        }
    }
    
    NameString *chineseStr = [countArray objectAtIndex:indexPath.row];
    for (ContactInfo *info in contactArray)
    {
        if ([info.userId isEqualToString:chineseStr.userId])
        {
            [userDetailView setViewData:info];
            break;
        }
    }
}

#pragma mark UITableVieDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *cStr = [sectionKeys objectAtIndex:section];
    NSMutableArray *countArray = [[NSMutableArray alloc] init];
    
    for(int index = 0; index < [contactPYnameArray count]; index++)
    {
        NameString *chineseStr = [contactPYnameArray objectAtIndex:index];
        NSMutableString *strchar= [NSMutableString stringWithString:chineseStr.pyString];
        NSString *sr= [strchar substringToIndex:1];
        if ([sr isEqualToString:cStr])
        {
            [countArray addObject:chineseStr];
        }
    }
    
    return countArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"ContactInfoTableViewCell";
    ContactInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[ContactInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    
    /*
    NSString *cStr = [sectionKeys objectAtIndex:indexPath.section];
    for(int index = 0; index < [contactPYnameArray count]; index++)
    {
        NameString *chineseStr = [contactPYnameArray objectAtIndex:index];
        NSMutableString *strchar= [NSMutableString stringWithString:chineseStr.pyString];
        NSString *sr= [strchar substringToIndex:1];
        if ([sr isEqualToString:cStr])
        {
            for (ContactInfo *info in contactArray)
            {
                if ([info.userId isEqualToString:chineseStr.userId])
                {
                    [cell configWithEntity:info];
                    break;
                }
            }
        }
    }
    */
    
    NSString *cStr = [sectionKeys objectAtIndex:indexPath.section];
    NSMutableArray *countArray = [[NSMutableArray alloc] init];
    
    for(int index = 0; index < [contactPYnameArray count]; index++)
    {
        NameString *chineseStr = [contactPYnameArray objectAtIndex:index];
        NSMutableString *strchar= [NSMutableString stringWithString:chineseStr.pyString];
        NSString *sr= [strchar substringToIndex:1];
        if ([sr isEqualToString:cStr])
        {
            [countArray addObject:chineseStr];
        }
    }
    
    NameString *chineseStr = [countArray objectAtIndex:indexPath.row];
    for (ContactInfo *info in contactArray)
    {
        if ([info.userId isEqualToString:chineseStr.userId])
        {
            [cell configWithEntity:info];
            break;
        }
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sectionKeys.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (isSearching)
    {
        return 0.;
    }
    return 20.;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *cStr = [sectionKeys objectAtIndex:section];
    return cStr;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isSearching)
    {
        return NO;
    }
    return NO;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 从列表中删除
//    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    // 从数据源中删除
//    [_data removeObjectAtIndex:indexPath.row];
    [self removeUsrAtIndexPath:indexPath];

}


-(void)removeUsrAtIndexPath:(NSIndexPath *)indexPath
{
    ContactInfo *deleteInfo = [[ContactInfo alloc] init];
    NSString *cStr = [sectionKeys objectAtIndex:indexPath.section];
    for(int index = 0; index < [contactPYnameArray count]; index++)
    {
        NameString *chineseStr = [contactPYnameArray objectAtIndex:index];
        NSMutableString *strchar= [NSMutableString stringWithString:chineseStr.pyString];
        NSString *sr= [strchar substringToIndex:1];
        if ([sr isEqualToString:cStr])
        {
            for (ContactInfo *info in contactArray)
            {
                if ([info.userId isEqualToString:chineseStr.userId])
                {
                    deleteInfo = info;
                    break;
                }
            }
        }
    }
    
    [[ContactsDao shareInstanceContactDao] deleteSelectedUserInfo:deleteInfo.userId];
    [self getContacts];
}

//对数组重新提取首字母和重新分组 返回已分组好的数据
- (void)getChineseStringArr:(NSMutableArray *)contactsArray
{

    [self getPYNameArray:contactsArray];
    
    [sectionKeys removeAllObjects];
    for(int index = 0; index < [contactPYnameArray count]; index++)
    {
        NameString *chineseStr = [contactPYnameArray objectAtIndex:index];
        NSMutableString *strchar= [NSMutableString stringWithString:chineseStr.pyString];
        NSString *sr= [strchar substringToIndex:1];

        if(![sectionKeys containsObject:[sr uppercaseString]])
        {
            [sectionKeys addObject:[sr uppercaseString]];
        }
        
    }
}

-(void)getPYNameArray:(NSMutableArray *)contactsArray
{
    [contactPYnameArray removeAllObjects];
    
    for(int i = 0; i < [contactsArray count]; i++)
    {
        ContactInfo *userInfo = [contactsArray objectAtIndex:i];
        NameString *chineseString = [[NameString alloc]init];
        
        chineseString.name = userInfo.userName;
        chineseString.userId = userInfo.userId;
        
        NSString *pinYinResult = [NSString string];
        for(int j = 0;j < chineseString.name.length; j++)
        {
            NSString *singlePinyinLetter = [[NSString stringWithFormat:@"%c",
                                             pinyinFirstLetter([chineseString.name characterAtIndex:j])]uppercaseString];
            pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
        }
        chineseString.pyString = pinYinResult;
        [contactPYnameArray addObject:chineseString];
    }
    
    //sort the ChineseStringArr by pinYin
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pyString" ascending:YES]];
    [contactPYnameArray sortUsingDescriptors:sortDescriptors];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    _keyWord = searchText;
    if ([_keyWord isEqualToString:@""])
    {
        [self getPYNameArray:contactArray];
    }
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@",_keyWord];
    contactPYnameArray = [[contactPYnameArray filteredArrayUsingPredicate:searchPredicate] mutableCopy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [contentView.contactListView reloadData];
    });
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES];
    [contentView isSearching:YES];
    isSearching = YES;

    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO];
    [contentView isSearching:NO];
    isSearching = NO;
    [self getContacts];
    return YES;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchBar.text = @"";
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _keyWord = searchBar.text;
    
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@",_keyWord];
    contactPYnameArray = [[contactPYnameArray filteredArrayUsingPredicate:searchPredicate] mutableCopy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [contentView.contactListView reloadData];
    });
   
}

#pragma mark ContactsViewDelegate联系人页面代理

-(void)ContactViewAdd
{
    AddVIPView *addVipView = [[AddVIPView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
//    [[MJPopTool sharedInstance] popView:addVipView animated:YES];
//    [addVipView showInController:self];
    [self.view addSubview:addVipView];

}

#pragma mark 编辑联系人信息
-(void)editContactInfo:(ContactInfo *)info
{
    AddVIPView *addVipView = [[AddVIPView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    [addVipView initUIwithInfo:info];
    [self.view addSubview:addVipView];
}

-(void)showLockView
{
    if ([GlobalDataManager getGestureCode].length>0)
    {
        unLockView = [[UnlockView alloc] init];
        [contentView.contentScrollView addSubview:unLockView];
        [unLockView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(contentView.contentScrollView);
        }];
        [contentView.contentScrollView bringSubviewToFront:unLockView];
    }
}


@end
