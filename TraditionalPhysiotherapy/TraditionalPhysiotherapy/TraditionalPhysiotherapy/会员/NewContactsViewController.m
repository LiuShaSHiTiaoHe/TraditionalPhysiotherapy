//
//  NewContactsViewController.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/14.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import "NewContactsViewController.h"
#import "NewContactsCollectionViewCell.h"
#import "TitleCollectionReusableView.h"
#import "AddVIPView.h"
#import "NewContactDetailViewController.h"


#import "ContactsDao.h"
#import "ContactInfo.h"
#import "pinyin.h"
#import "NameString.h"

@interface NewContactsViewController ()<PYSearchViewControllerDelegate,PYSearchViewControllerDataSource>
{
    UIView *myNavView;
    UILabel *titleLabel;
//    UISearchBar *searchBar;
    UICollectionView *infoCollectionView;
    
    NSMutableArray *contactArray;
    NSMutableArray *contactPYnameArray;
    NSMutableArray *sectionKeys;
    NSString *_keyWord;

    UIImage *maleImage;
    UIImage *femaleImage;
    NSMutableDictionary *imageDic;
    
    NSMutableArray *searchArray;
    NSMutableArray *resultArray;
}

@end

@implementation NewContactsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getContacts) name:UserDataBaseChanged object:nil];

    [self initUI];
    [self initData];
    [self getContacts];
}

-(void)getContacts
{
    contactArray = [[ContactsDao shareInstanceContactDao] getAllUser];
    [self getChineseStringArr:contactArray];
    [infoCollectionView reloadData];
}

-(void)initData
{
    contactArray = [[NSMutableArray alloc] init];
    sectionKeys = [[NSMutableArray alloc] init];
    contactPYnameArray = [[NSMutableArray alloc] init];
    searchArray = [NSMutableArray new];
    resultArray = [NSMutableArray new];
    
    NSData *data = UIImageJPEGRepresentation([UIImage imageNamed:@"male" imageBundle:@"contact"], 0.1);
    maleImage = [UIImage imageWithData:data];
    data = UIImageJPEGRepresentation([UIImage imageNamed:@"female" imageBundle:@"contact"], 0.1);
    femaleImage= [UIImage imageWithData:data];
    imageDic = [NSMutableDictionary new];
}

-(void)initUI
{
    myNavView = [[UIView alloc] init];
    myNavView.backgroundColor = [UIColor colorWithHexString:@"4977f1"];
    [self.view addSubview:myNavView];
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"会员";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:30];
    titleLabel.textColor = [UIColor whiteColor];
    [myNavView addSubview:titleLabel];
    
    UIButton *addContactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addContactBtn setImage:[UIImage imageNamed:@"navAdd" imageBundle:@"Menu"] forState:UIControlStateNormal];
    [addContactBtn addTarget:self action:@selector(AddvipAction) forControlEvents:UIControlEventTouchUpInside];
    [myNavView addSubview:addContactBtn];
    
    UILabel *searchLabel = [[UILabel alloc] init];
    searchLabel.backgroundColor = [UIColor whiteColor];
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGFloat width = scale > 0.0 ? 1.0 / scale : 1.0;
    searchLabel.layer.cornerRadius = 10.;
    searchLabel.layer.borderWidth = 3*width;
    searchLabel.layer.borderColor = [UIColor colorWithHexString:@"e2e5e5"].CGColor;
    searchLabel.userInteractionEnabled = YES;
    [self.view addSubview:searchLabel];
    
    UIImageView *searchIcon = [[UIImageView alloc] init];
    searchIcon.image = [UIImage imageNamed:@"search" imageBundle:@"contact"];
    [searchLabel addSubview:searchIcon];
    
    UILabel *placehold = [[UILabel alloc] init];
    placehold.text = @"搜索会员";
    placehold.textColor = [UIColor colorWithHexString:@"8a8a8a"];
    placehold.font = [UIFont systemFontOfSize:22];
    placehold.backgroundColor = [UIColor whiteColor];
    placehold.userInteractionEnabled = YES;
    [searchLabel addSubview:placehold];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchAction)];
    [placehold addGestureRecognizer:tap];
    
    //collectionView
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    infoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    infoCollectionView.backgroundColor = [UIColor clearColor];
    infoCollectionView.showsVerticalScrollIndicator = NO;
    infoCollectionView.showsHorizontalScrollIndicator = NO;
    infoCollectionView.dataSource = self;
    infoCollectionView.delegate = self;
    [infoCollectionView registerClass:[NewContactsCollectionViewCell class] forCellWithReuseIdentifier:@"NewContactsCollectionViewCell"];
    [infoCollectionView registerClass:[TitleCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TitleCollectionReusableView"];
    [self.view addSubview:infoCollectionView];
    
    [myNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(UIScreenWidth);
        make.height.equalTo(80.);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNavView.mas_top).offset(20.);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(UIScreenWidth);
        make.height.equalTo(50.);
        
    }];
    
    [addContactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.centerY.equalTo(myNavView.mas_centerY).offset(20.);
        make.top.equalTo(myNavView.mas_top).offset(30.);
        make.right.equalTo(myNavView.mas_right).offset(-30.);
        make.width.height.equalTo(30);
    }];
    
    [searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(4);
        make.top.equalTo(myNavView.mas_bottom).offset(4);
        make.right.equalTo(self.view.mas_right).offset(-4);
        make.height.equalTo(60.);
    }];
    
    [searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(searchLabel.mas_left).offset(30);
        make.centerY.equalTo(searchLabel.mas_centerY);
        make.width.equalTo(30);
        make.height.equalTo(30.);
    }];
    
    [placehold mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(searchIcon.mas_right).offset(45);
        make.centerY.equalTo(searchLabel.mas_centerY);
        make.right.equalTo(searchLabel.mas_right).offset(-30);
        make.height.equalTo(40.);
    }];

    [infoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchLabel.mas_bottom).offset(4);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        
    }];
}

-(void)searchAction
{
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:@[] searchBarPlaceholder:@"搜索会员" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
  
        [searchViewController.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
        
    }];
    searchViewController.showHotSearch = NO;
//    searchViewController.searchSuggestionHidden = YES;
    searchViewController.delegate = self;
    searchViewController.dataSource = self;
    // 3. present the searchViewController
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];
}

-(void)AddvipAction
{
    AddVIPView *addVipView = [[AddVIPView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    [self.view addSubview:addVipView];
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
        
        [self getImageDic:userInfo];
        
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

-(void)getImageDic:(ContactInfo *)info
{
    if (![NSObject isNullOrNilWithObject:info.userImage])
    {
        UIImage *resultImage = [GlobalDataManager resizeImageByvImage:[UIImage imageWithContentsOfFile:info.userImage]];
        [imageDic setObject:resultImage forKey:info.userId];
    }
}

#pragma mark - UICollectionViewDelegate + UICollectionViewDelegate + UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
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

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return sectionKeys.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * infoCollectionViewCellID = @"NewContactsCollectionViewCell";
    NewContactsCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:infoCollectionViewCellID forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[NewContactsCollectionViewCell alloc] init];
    }
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
            UIImage *headImage = [imageDic objectForKey:info.userId];
            if (headImage)
            {
                cell.imageView.image = headImage;
            }
            else
            {
                if ([info.userGender isEqualToString:@"male"])
                {
                    cell.imageView.image = maleImage;
                }
                else
                {
                    cell.imageView.image = femaleImage;
                }
            }
            break;
        }
    }
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(220, 280);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

//每个cell的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20.0f;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

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
            NewContactDetailViewController *temp = [[NewContactDetailViewController alloc] init];
            temp.currentInfo = info;
            [self.navigationController pushViewController:temp animated:YES];
            break;
        }
    }

}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    TitleCollectionReusableView *reusableview = nil;

    if (kind == UICollectionElementKindSectionHeader)
    {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TitleCollectionReusableView" forIndexPath:indexPath];
        NSString *cStr = [sectionKeys objectAtIndex:indexPath.section];
        reusableview.titlelabel.backgroundColor = [UIColor colorWithHexString:@"e2e5e5"];
        reusableview.titlelabel.textColor = [UIColor grayColor];
        reusableview.titlelabel.text = cStr;
    }

    return reusableview;

}

// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(UIScreenWidth, 30.);
}


#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController
didSelectSearchHistoryAtIndex:(NSInteger)index
                  searchText:(NSString *)searchText
{
    if (searchText.length)
    {
        _keyWord = searchText;
        NSString *pinYinResult = [NSString string];
        for(int j = 0;j < _keyWord.length; j++)
        {
            NSString *singlePinyinLetter = [[NSString stringWithFormat:@"%c",
                                             pinyinFirstLetter([_keyWord characterAtIndex:j])]uppercaseString];
            pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
        }
        
        [searchArray removeAllObjects];
        NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@ || pyString CONTAINS[c] %@",_keyWord,pinYinResult];
        [searchArray addObjectsFromArray:[[contactPYnameArray filteredArrayUsingPredicate:searchPredicate] mutableCopy]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [searchViewController.searchSuggestionView reloadData];
        });
    }
}


- (void)didClickCancel:(PYSearchViewController *)searchViewController
{
    [searchViewController.navigationController dismissViewControllerAnimated:YES completion:^{
        
        searchViewController.searchTextField.text = @"";
    }];
}



- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length)
    {
        _keyWord = searchText;
        NSString *pinYinResult = [NSString string];
        for(int j = 0;j < _keyWord.length; j++)
        {
            NSString *singlePinyinLetter = [[NSString stringWithFormat:@"%c",
                                             pinyinFirstLetter([_keyWord characterAtIndex:j])]uppercaseString];
            pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
        }
        
        [searchArray removeAllObjects];
        NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@ || pyString CONTAINS[c] %@",_keyWord,pinYinResult];
        [searchArray addObjectsFromArray:[[contactPYnameArray filteredArrayUsingPredicate:searchPredicate] mutableCopy]];
        
        dispatch_async(dispatch_get_main_queue(), ^{

            [searchViewController.searchSuggestionView reloadData];
        });
    }
}

- (void)searchViewController:(PYSearchViewController *)searchViewController didSelectSearchSuggestionAtIndexPath:(NSIndexPath *)indexPath searchBar:(UISearchBar *)searchBar
{
    
    __weak __typeof(self)weakSelf = self;
    [searchViewController.navigationController dismissViewControllerAnimated:YES completion:^{
        
//        AMapPOI *poi = [poisArray objectAtIndex:indexPath.row];
//        [ACFunctionUtils saveToUserDefaults:[[poi valueForKey:@"location"] valueForKey:@"latitude"] withKey:@"searchedPOILat"];
//        [ACFunctionUtils saveToUserDefaults:[[poi valueForKey:@"location"] valueForKey:@"longitude"] withKey:@"searchedPOILon"];
//        __strong __typeof(weakSelf)strongSelf = weakSelf;
//        [strongSelf locatedAtSelectedPoint];
//        [headView setSearchText:poi.name];
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        NameString *chineseStr = [searchArray objectAtIndex:indexPath.row];
        for (ContactInfo *info in contactArray)
        {
            if ([info.userId isEqualToString:chineseStr.userId])
            {
                NewContactDetailViewController *temp = [[NewContactDetailViewController alloc] init];
                temp.currentInfo = info;
                [strongSelf.navigationController pushViewController:temp animated:YES];
                break;
            }
        }
        
    }];
}

#pragma mark - PYSearchViewControllerDataSource

-(NSInteger)searchSuggestionView:(UITableView *)searchSuggestionView numberOfRowsInSection:(NSInteger)section
{
    return searchArray.count;
}

-(UITableViewCell *)searchSuggestionView:(UITableView *)searchSuggestionView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [searchSuggestionView dequeueReusableCellWithIdentifier:@"GSearchTableViewCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GSearchTableViewCell"];
    }
    NameString *chineseStr = [searchArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"4977f1"];
    cell.textLabel.text = chineseStr.name;
//    if (tempArray.count > 0)
//    {
//        cell.placeName.text = tempArray[indexPath.row][@"name"];
//        cell.address.text = tempArray[indexPath.row][@"address"];
//        cell.location = (AMapGeoPoint *)tempArray[indexPath.row][@"location"];
//        [cell setNavBlock:^(AMapGeoPoint *location) {
//            NSString *url = [NSString stringWithFormat:@"MXTC://push/ACPack/ACPackNavigationViewController?startLat=%f&startLon=%f&endLat=%f&endLon=%f&parkId=%@", _location.coordinate.latitude, _location.coordinate.longitude, location.latitude, location.longitude,@""];
//            [ACFunctionUtils openUrl:url];
//        }];
//    }
    return cell;
}

-(CGFloat)searchSuggestionView:(UITableView *)searchSuggestionView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

@end
