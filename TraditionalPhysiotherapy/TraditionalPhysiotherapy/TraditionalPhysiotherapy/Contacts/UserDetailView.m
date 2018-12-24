//
//  UserDetailView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 12/12/2017.
//  Copyright © 2017 Gu GuiJun. All rights reserved.
//

#import "UserDetailView.h"
#import "ContactInfo.h"
#import "IconCollectionViewCell.h"
#import "InfoCollectionViewCell.h"
#import "HeadCollectionViewCell.h"
#import "TitleCollectionReusableView.h"

#import "RechargeView.h"
#import "ContactsDao.h"
#import "BillDetailListView.h"
#import "AddRecordView.h"
#import "EditRecordView.h"
#import "ReViewPhotoView.h"
#import "RechargeRecordView.h"

@implementation UserDetailView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
    {
        return nil;
    }
    self.backgroundColor = [UIColor whiteColor];

    
    //collectionView
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    infoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    infoCollectionView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    infoCollectionView.showsVerticalScrollIndicator = NO;
    infoCollectionView.showsHorizontalScrollIndicator = NO;
    infoCollectionView.dataSource = self;
    infoCollectionView.delegate = self;
    
    [infoCollectionView registerClass:[HeadCollectionViewCell class] forCellWithReuseIdentifier:@"HeadCollectionViewCell"];
    [infoCollectionView registerClass:[IconCollectionViewCell class] forCellWithReuseIdentifier:@"IconCollectionViewCell"];
    [infoCollectionView registerClass:[InfoCollectionViewCell class] forCellWithReuseIdentifier:@"InfoCollectionViewCell"];
    [infoCollectionView registerClass:[TitleCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TitleCollectionReusableView"];
    
    [self addSubview:infoCollectionView];
    
    [infoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserInfo) name:UserDataBaseChanged object:nil];

    return self;
}

-(void)updateUserInfo
{
    currentInfo = [[ContactsDao shareInstanceContactDao] getUserInfo:currentInfo.userId];
}


-(void)setViewData:(ContactInfo *)info
{
    currentInfo = info;
    [infoCollectionView reloadData];
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
        case 3:
        {
            return 6;
        }
            break;
        default:
            break;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
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
            HeadCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:headCollectionViewCellID forIndexPath:indexPath];
            if (!cell)
            {
                cell = [[HeadCollectionViewCell alloc] init];
            }
            
            if (![NSObject isNullOrNilWithObject:currentInfo])
            {
                WS(weakSelf)
                
                cell.editBlock = ^(){
                    
                    [weakSelf editContactInfo];
                };
                
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
            IconCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:iconCollectionViewCellID forIndexPath:indexPath];
            if (!cell)
            {
                cell = [[IconCollectionViewCell alloc] init];
            }
            
            switch (indexPath.row)
            {
                case 0://手机
                {
                    cell.iconImage.image = [UIImage imageNamed:@"phone" imageBundle:@"contact"];
                     if (![NSObject isNullOrNilWithObject:currentInfo.userPhone])
                     {
                         cell.infoText.text = currentInfo.userPhone;
                     }
                    else
                    {
                        cell.infoText.text = @"保密";
                    }
                    cell.hLine.hidden = NO;
                }
                    break;
                case 1://微信
                {
                    cell.iconImage.image = [UIImage imageNamed:@"wechat" imageBundle:@"contact"];
                    if (![NSObject isNullOrNilWithObject:currentInfo.userWechat])
                    {
                        cell.infoText.text = currentInfo.userWechat;
                    }
                    else
                    {
                        cell.infoText.text = @"保密";
                    }
                    cell.hLine.hidden = NO;

                }
                    break;
                case 2://QQ
                {
                    cell.iconImage.image = [UIImage imageNamed:@"qq" imageBundle:@"contact"];
                    if (![NSObject isNullOrNilWithObject:currentInfo.userQQ])
                    {
                        cell.infoText.text = currentInfo.userQQ;
                    }
                    else
                    {
                        cell.infoText.text = @"保密";
                    }
                    cell.hLine.hidden = YES;

                }
                    break;
                default:
                    break;
            }
            
            return cell;
        }
            break;
#pragma mark 基本信息
        case 3:
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
                    cell.infoText.text  =@"身高";
                    if (![NSObject isNullOrNilWithObject:currentInfo.userHeight])
                    {
                        cell.detailText.text = currentInfo.userHeight;
                    }
                    else
                    {
                        cell.detailText.text = @"保密";
                    }
                    cell.hLine.hidden = NO;
                    cell.vLine.hidden = NO;
                }
                    break;
                case 1:
                {
                    cell.infoText.text  =@"体重";
                    if (![NSObject isNullOrNilWithObject:currentInfo.userWeight])
                    {
                        cell.detailText.text = currentInfo.userWeight;
                    }
                    else
                    {
                        cell.detailText.text = @"保密";
                    }
                    cell.hLine.hidden = NO;
                    cell.vLine.hidden = NO;
                }
                    break;
                case 2:
                {
                    cell.infoText.text  =@"年龄";
                    if (![NSObject isNullOrNilWithObject:currentInfo.userAge])
                    {
                        cell.detailText.text = currentInfo.userAge;
                    }
                    else
                    {
                        cell.detailText.text = @"保密";
                    }
                    cell.hLine.hidden = YES;
                    cell.vLine.hidden = NO;

                }
                    break;
                case 3:
                {
                    cell.infoText.text  =@"职业";
                    if (![NSObject isNullOrNilWithObject:currentInfo.userJob])
                    {
                        cell.detailText.text = currentInfo.userJob;
                    }
                    else
                    {
                        cell.detailText.text = @"保密";
                    }
                    cell.vLine.hidden = YES;
                    cell.hLine.hidden = NO;

                }
                    break;
                case 4:
                {
                    cell.infoText.text  =@"生日";
                    if (![NSObject isNullOrNilWithObject:currentInfo.userBirthday])
                    {
                        cell.detailText.text = currentInfo.userBirthday;
                    }
                    else
                    {
                        cell.detailText.text = @"保密";
                    }
                    cell.vLine.hidden = YES;
                    cell.hLine.hidden = NO;

                }
                    break;
                case 5:
                {
                    cell.infoText.text  =@"星座";
                    if (![NSObject isNullOrNilWithObject:currentInfo.userHoroscope])
                    {
                        cell.detailText.text = currentInfo.userHoroscope;
                    }
                    else
                    {
                        cell.detailText.text = @"保密";
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
            return CGSizeMake(UIScreenWidth-450, 150);
        }
            break;
        case 1:
        {
            return CGSizeMake((UIScreenWidth-450)/3, 80);
        }
            break;
        case 2:
        {
            return CGSizeMake((UIScreenWidth-450)/3, 80);
        }
            break;
        case 3:
        {
            return CGSizeMake((UIScreenWidth-450)/3, 110);
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
                    [[self viewController].view addSubview:bview];
                }
                    break;
                case 1:
                {
                    BillDetailListView *bview = [[BillDetailListView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
                    [bview setBillDetailUserInfo:currentInfo];
                    [[self viewController].view addSubview:bview];
                }
                    break;
                case 2:
                {
                    RecordListView *bview = [[RecordListView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
                    [bview setRecordListUserInfo:currentInfo];
                    bview.delegate = self;
                    [[self viewController].view addSubview:bview];
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
            reusableview.titlelabel.text = @"联系方式";
        }
        else if (indexPath.section == 3)
        {
            reusableview.titlelabel.text = @"基本资料";
        }
        else
        {
            reusableview.titlelabel.text = @"";
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
        return CGSizeMake(UIScreenWidth-450, 30.);
    }
    else
    {
        return CGSizeMake(UIScreenWidth-450, 60.);
    }
}

#pragma mark 修改个人信息
-(void)editContactInfo
{
    if (delegate)
    {
        [delegate editContactInfo:currentInfo];
    }
}

#pragma mark 显示充值页面
-(void)BalanceShortViewRecharge
{
    RechargeView *bview = [[RechargeView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    [bview setViewContactInfo:currentInfo];
    [[self viewController].view addSubview:bview];
}

#pragma mark 显示充值记录
-(void)BalanceShortViewShowRechargeRecord
{
    RechargeRecordView *bview = [[RechargeRecordView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    [bview setRecordListUserInfo:currentInfo];
    [[self viewController].view addSubview:bview];
}

-(void)RecordListViewAddNewRecord
{
    AddRecordView *bview = [[AddRecordView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    [bview setAddRecordViewInfo:currentInfo];
    [[self viewController].view addSubview:bview];
}

-(void)RecordListViewEditRecord:(RecordInfo *)info
{
    EditRecordView *bview = [[EditRecordView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    [bview setAddRecordViewInfo:currentInfo];
    [bview setEditRecordInfo:info];
    [[self viewController].view addSubview:bview];
}

-(void)preViewImage:(NSString *)imagePath
{
    ReViewPhotoView *review = [[ReViewPhotoView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight) Photo:[UIImage imageWithContentsOfFile:imagePath]];
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionReveal;
    transition.duration = 0.5;
    [review.layer addAnimation:transition forKey:nil];
    [[self viewController].view addSubview:review];
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
@end










