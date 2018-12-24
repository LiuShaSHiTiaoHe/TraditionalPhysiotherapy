//
//  NewContactDetailViewController.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/17.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import "NewContactDetailViewController.h"
#import "BalanceShortView.h"
#import "RecordListView.h"
#import "IconCollectionViewCell.h"
#import "InfoCollectionViewCell.h"
#import "HeadCollectionViewCell.h"
#import "NewContactHeadCollectionViewCell.h"
#import "AddVIPView.h"

#import "TitleCollectionReusableView.h"
#import "RechargeView.h"
#import "ContactsDao.h"
#import "BillDao.h"
#import "BillDetailListView.h"
#import "AddRecordView.h"
#import "EditRecordView.h"
#import "ReViewPhotoView.h"
#import "RechargeRecordView.h"

#import "NewBillDetailListViewController.h"
#import "ContactInfo.h"
#import "BillInfo.h"

#import "NewRecordListViewController.h"

@interface NewContactDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BalanceShortViewDelegate>
{
    UIImageView *backImageView;
    UIImageView *headImage;
    UILabel *userName;
    UICollectionView *infoCollectionView;
    NSMutableArray *billArray;
}

@end

@implementation NewContactDetailViewController
@synthesize currentInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserInfo) name:UserDataBaseChanged object:nil];

}

//-(void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UserDataBaseChanged object:nil];
//}

-(void)updateUserInfo
{
    currentInfo = [[ContactsDao shareInstanceContactDao] getUserInfo:currentInfo.userId];
    [infoCollectionView reloadData];
}

-(void)initData
{
    billArray = [[BillDao shareInstanceBillDao] getBillInfoByUser:currentInfo.userId];
}

-(void)backBtnAction
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UserDataBaseChanged object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)editContact
{
    AddVIPView *addVipView = [[AddVIPView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    [addVipView initUIwithInfo:currentInfo];
    [self.view addSubview:addVipView];
}

-(void)initUI
{
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f3f3"];
    
    UIView *backView = [[UIView alloc] init];
    [self.view addSubview:backView];
    
    UIView *myNavView = [[UIView alloc] init];
    myNavView.backgroundColor = [UIColor colorWithHexString:@"4977f1"];
    [backView addSubview:myNavView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back" imageBundle:@"Project"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [myNavView addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"会员详情";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:30];
    [myNavView addSubview:titleLabel];
    
    UIButton *addContactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addContactBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [addContactBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addContactBtn.titleLabel.font = [UIFont systemFontOfSize:27];
//    [addContactBtn setImage:[UIImage imageNamed:@"navAdd" imageBundle:@"Menu"] forState:UIControlStateNormal];
    [addContactBtn addTarget:self action:@selector(editContact) forControlEvents:UIControlEventTouchUpInside];
    [myNavView addSubview:addContactBtn];
    
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];
    
    [myNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(backView.mas_top);
        make.left.equalTo(backView.mas_left);
        make.right.equalTo(backView.mas_right);
        make.height.equalTo(100.);
    }];
    
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNavView.mas_top).offset(40.);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(UIScreenWidth);
        make.height.equalTo(50.);
        
    }];
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(myNavView.mas_centerY).offset(20.);
        make.left.equalTo(myNavView.mas_left).offset(30.);
        make.width.height.equalTo(50);
    }];
    
    [addContactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(myNavView.mas_centerY).offset(20.);
        make.right.equalTo(myNavView.mas_right).offset(-30.);
        make.height.equalTo(50);
        make.width.equalTo(120);
    }];
    
    //collectionView
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    infoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    infoCollectionView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    infoCollectionView.showsVerticalScrollIndicator = NO;
    infoCollectionView.showsHorizontalScrollIndicator = NO;
    infoCollectionView.dataSource = self;
    infoCollectionView.delegate = self;
    
    [infoCollectionView registerClass:[NewContactHeadCollectionViewCell class] forCellWithReuseIdentifier:@"HeadCollectionViewCell"];
    [infoCollectionView registerClass:[IconCollectionViewCell class] forCellWithReuseIdentifier:@"IconCollectionViewCell"];
    [infoCollectionView registerClass:[InfoCollectionViewCell class] forCellWithReuseIdentifier:@"InfoCollectionViewCell"];
    [infoCollectionView registerClass:[TitleCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TitleCollectionReusableView"];
    
    [self.view addSubview:infoCollectionView];
    
    [infoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNavView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        
    }];
}


#pragma mark - UICollectionViewDelegate + UICollectionViewDelegate + UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 3;
        }
            break;
        case 2:
        {
            return 3;
        }
            break;
        default:
            break;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * iconCollectionViewCellID = @"IconCollectionViewCell";
    static NSString * infoCollectionViewCellID = @"InfoCollectionViewCell";
    static NSString * headCollectionViewCellID = @"HeadCollectionViewCell";
    
    switch (indexPath.section)
    {
#pragma mark 头像Cell
        case 0:
        {
            NewContactHeadCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:headCollectionViewCellID forIndexPath:indexPath];
            if (!cell)
            {
                cell = [[NewContactHeadCollectionViewCell alloc] init];
            }
            
            if (![NSObject isNullOrNilWithObject:currentInfo])
            {
                cell.userName.text = currentInfo.userName;
                if (![NSObject isNullOrNilWithObject:currentInfo.userImage])
                {
                    cell.headImage.image = [GlobalDataManager resizeImageByvImage:[UIImage imageWithContentsOfFile:currentInfo.userImage]];
                }
                else
                {
                    if ([currentInfo.userGender isEqualToString:@"male"])
                    {
                        cell.headImage.image = [UIImage imageNamed:@"male" imageBundle:@"contact"];
                    }
                    else
                    {
                        cell.headImage.image = [UIImage imageNamed:@"female" imageBundle:@"contact"];
                    }
                }
            }
            
            
            return cell;
            
        }
            break;
#pragma mark 会员信息
        case 1:
        {
            IconCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:iconCollectionViewCellID forIndexPath:indexPath];
            if (!cell)
            {
                cell = [[IconCollectionViewCell alloc] init];
            }
            
            switch (indexPath.row)
            {
                case 0://余额
                {
                    cell.iconImage.image = [UIImage imageNamed:@"balance" imageBundle:@"contact"];
                    cell.infoText.text = @"账户余额";
                }
                    break;
                case 1://账单
                {
                    cell.iconImage.image = [UIImage imageNamed:@"bill" imageBundle:@"contact"];
                    cell.infoText.text = @"消费账单";
                }
                    break;
                case 2://记录
                {
                    cell.iconImage.image = [UIImage imageNamed:@"record" imageBundle:@"contact"];
                    cell.infoText.text = @"治疗记录";
                    cell.hLine.hidden = YES;
                }
                    break;
                default:
                    break;
            }
            
            return cell;
        }
            break;
#pragma mark 联系方式
        case 2:
        {
            InfoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:infoCollectionViewCellID forIndexPath:indexPath];
            if (!cell)
            {
                cell = [[InfoCollectionViewCell alloc] init];
            }
            
            switch (indexPath.row)
            {
                case 0:
                {
                    cell.infoText.text  =@"手机号码";
                    if (![NSObject isNullOrNilWithObject:currentInfo.userPhone])
                    {
                        cell.detailText.text = currentInfo.userPhone;
                    }
                    else
                    {
                        cell.detailText.text = @"未知";
                    }
                    cell.hLine.hidden = NO;
                    cell.vLine.hidden = YES;
                }
                    break;
                case 1:
                {
                    cell.infoText.text  =@"消费次数";
                    if (billArray.count > 0)
                    {
                        cell.detailText.text = [NSString stringWithFormat:@"%lu 次",(unsigned long)billArray.count];
                    }
                    else
                    {
                        cell.detailText.text = @"暂无";
                    }
                    cell.hLine.hidden = NO;
                    cell.vLine.hidden = YES;
                }
                    break;
                    
                case 2:
                {
                    cell.infoText.text  =@"上次消费";
                    if (billArray.count > 0)
                    {
                        BillInfo *billinfo = [billArray lastObject];
                        cell.detailText.text = billinfo.recordTime;
                    }
                    else
                    {
                        cell.detailText.text = @"未知";
                    }
                    cell.hLine.hidden = YES;
                    cell.vLine.hidden = YES;
                }
                    break;
                default:
                    break;
            }
            
            return cell;
        }
            break;
        default:
            break;
    }
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[UICollectionViewCell alloc] init];
    }
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            return CGSizeMake(UIScreenWidth, 230);
        }
            break;
        case 1:
        {
            return CGSizeMake((UIScreenWidth)/3, 160);
        }
            break;
        case 2:
        {
            return CGSizeMake((UIScreenWidth)/3, 160);
        }
            break;
        default:
            break;
    }
    return CGSizeZero;
    
}

//每个cell的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section)
    {
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    BalanceShortView *bview = [[BalanceShortView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
                    [bview setContactInfo:currentInfo];
                    bview.delegate = self;
                    [self.view addSubview:bview];
                }
                    break;
                case 1:
                {
                    NewBillDetailListViewController *temp = [[NewBillDetailListViewController alloc] init];
                    temp.curentInfo = currentInfo;
                    [self.navigationController presentViewController:temp animated:YES completion:^{
                        
                    }];
                    
                }
                    break;
                case 2:
                {
                    NewRecordListViewController *temp = [[NewRecordListViewController alloc] init];
                    temp.curentInfo = currentInfo;
                    [self.navigationController presentViewController:temp animated:YES completion:^{
                        
                    }];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    TitleCollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TitleCollectionReusableView" forIndexPath:indexPath];
        
        if (indexPath.section == 2)
        {
            reusableview.titlelabel.text = @"用户信息";
            reusableview.titlelabel.font = [UIFont systemFontOfSize:27];
            reusableview.backgroundColor = [UIColor lightTextColor];
        }
        else if (indexPath.section == 3)
        {
            reusableview.titlelabel.text = @"基本资料";
            reusableview.backgroundColor = [UIColor clearColor];
        }
        else
        {
            reusableview.titlelabel.text = @"";
            reusableview.backgroundColor = [UIColor clearColor];

        }
        
    }
    
    return reusableview;
    
}

// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return CGSizeMake(0, 0);
    }
    else if (section == 1)
    {
        return CGSizeMake(UIScreenWidth, 60.);
    }
    else
    {
        return CGSizeMake(UIScreenWidth, 60.);
    }
}


#pragma mark 显示充值页面
-(void)BalanceShortViewRecharge
{
    RechargeView *bview = [[RechargeView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    [bview setViewContactInfo:currentInfo];
    [self.view addSubview:bview];
}

#pragma mark 显示充值记录
-(void)BalanceShortViewShowRechargeRecord
{
    RechargeRecordView *bview = [[RechargeRecordView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    [bview setRecordListUserInfo:currentInfo];
    [self.view addSubview:bview];
}


@end
