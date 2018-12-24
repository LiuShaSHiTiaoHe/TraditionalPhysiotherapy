//
//  VIPCustomerPaymentView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/12/28.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import "VIPCustomerPaymentView.h"
#import "OrderRecordInfo.h"
#import "PayMentRecordTableViewCell.h"
#import "ProjectInfo.h"
#import "BillDao.h"
#import "ContactsDao.h"
#import "AddRecordView.h"
#import "TechnicianDao.h"
#import "TechnicianInfo.h"
#import "TechnicainRecordDao.h"
#import "QRcodeViewController.h"
#import "QRcodeView.h"

@implementation VIPCustomerPaymentView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (!self)
    {
        return nil;
    }
    
    UIView *personalView = [[UIView alloc] init];
    [self addSubview:personalView];
    
    headPic = [[UIImageView alloc] init];
    headPic.layer.masksToBounds = YES;
    headPic.layer.cornerRadius = 50/2;
//    headPic.image = [UIImage imageNamed:@"unselectUser" imageBundle:@"contact"];
    [personalView addSubview:headPic];
    
    nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"请选择会员";
    nameLabel.textColor = [UIColor lightGrayColor];
    nameLabel.font = [UIFont systemFontOfSize:20];
    [personalView addSubview:nameLabel];
    
    changeCustomer = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeCustomer setImage:[UIImage imageNamed:@"changeUser" imageBundle:@"payment"] forState:UIControlStateNormal];
    [changeCustomer addTarget:self action:@selector(changeCustomerAction) forControlEvents:UIControlEventTouchUpInside];
    [personalView addSubview:changeCustomer];
    
    
    listView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    listView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    listView.delegate  = self;
    listView.dataSource = self;
    [self addSubview:listView];
    
    signLabel = [[UILabel alloc] init];
    signLabel.text = @"签字";
    signLabel.font = [UIFont systemFontOfSize:26];
    [self addSubview:signLabel];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    timeLabel = [[UILabel alloc] init];
    timeLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    timeLabel.font = [UIFont systemFontOfSize:18];
    timeLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:timeLabel];
    
    clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.backgroundColor = [UIColor clearColor];
    //设置button正常状态下的图片
    [clearBtn setImage:[UIImage imageNamed:@"clearBtn" imageBundle:@"payment"] forState:UIControlStateNormal];
    //设置button高亮状态下的图片
    [clearBtn setImage:[UIImage imageNamed:@"clearBtn" imageBundle:@"payment"] forState:UIControlStateHighlighted];
    [clearBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clearSign) forControlEvents:UIControlEventTouchUpInside];
    clearBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:clearBtn];
    
    signatureView = [[SignatureViewQuartz alloc] init];
//    signatureView.layer.cornerRadius = 10.;
    signatureView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [self addSubview:signatureView];
    
    otherPay = [UIButton buttonWithType:UIButtonTypeCustom];
    otherPay.layer.cornerRadius = 10.;
    [otherPay setTitle:@"其他付款" forState:UIControlStateNormal];
    [otherPay setBackgroundColor:[UIColor colorWithHexString:@"4eccff"]];
    [otherPay addTarget:self action:@selector(otherPayAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:otherPay];
//    otherPay.hidden = YES;
    
    vipPay = [UIButton buttonWithType:UIButtonTypeCustom];
    [vipPay setTitle:@"会员付款" forState:UIControlStateNormal];
    vipPay.layer.cornerRadius = 10.;
    [vipPay setBackgroundColor:[UIColor colorWithHexString:@"44e6cd"]];
    [vipPay addTarget:self action:@selector(vipPayAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:vipPay];

    
    UIView *totalBack = [UIView new];
    totalBack.backgroundColor = [UIColor colorWithHexString:@"fbf1d7"];
    [self addSubview:totalBack];
    
    totalLabel = [[UILabel alloc] init];
    totalLabel.font = [UIFont systemFontOfSize:18];
    totalLabel.textColor = [UIColor lightGrayColor];
    totalLabel.textAlignment = NSTextAlignmentRight;
    [totalBack addSubview:totalLabel];
    
    
    [personalView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(20.);
        make.top.equalTo(self.mas_top).offset(20.);
        make.width.equalTo(400.);
        make.height.equalTo(60.);
    }];
    
    [headPic mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(personalView.mas_left).offset(10);
        make.centerY.equalTo(personalView.mas_centerY);
        make.width.equalTo(50);
        make.height.equalTo(50.);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(headPic.mas_right).offset(20.);
        make.centerY.equalTo(personalView.mas_centerY);
        make.right.equalTo(personalView.mas_right).offset(80);
        make.height.equalTo(40.);
    }];
    
    [changeCustomer mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(personalView.mas_right).offset(-10);
        make.centerY.equalTo(personalView.mas_centerY);
        make.width.equalTo(30);
        make.height.equalTo(30.);
    }];
    

    [listView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(20.);
        make.top.equalTo(personalView.mas_bottom).offset(20.);
        make.width.equalTo(400.);
        make.bottom.equalTo(self.mas_bottom).offset(-130);
    }];
    
    [totalBack mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(20.);
        make.top.equalTo(listView.mas_bottom);
        make.width.equalTo(400.);
        make.height.equalTo(40);
    }];
    
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(totalBack.mas_left);
        make.top.equalTo(listView.mas_bottom);
        make.right.equalTo(totalBack.mas_right).offset(-20);
        make.height.equalTo(40);
    }];
    
    [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(personalView.mas_right).offset(20.);
        make.top.equalTo(self.mas_top).offset(20.);
        make.right.equalTo(self.mas_right).offset(-40);
        make.height.equalTo(40.);
    }];
    

    
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(personalView.mas_right).offset(20.);
        make.top.equalTo(signLabel.mas_bottom).offset(20.);
        make.right.equalTo(self.mas_right).offset(-140);
        make.height.equalTo(20.);
    }];
    
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(signLabel.mas_bottom).offset(20.);
        make.right.equalTo(self.mas_right).offset(-50);
        make.height.equalTo(30.);
        make.width.equalTo(30.);

    }];
    
    [signatureView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(personalView.mas_right).offset(20.);
        make.top.equalTo(timeLabel.mas_bottom).offset(10.);
        make.right.equalTo(self.mas_right).offset(-40);
        make.bottom.equalTo(self.mas_bottom).offset(-170.);
    }];
    
    [otherPay mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(personalView.mas_right).offset(20.);
        make.top.equalTo(signatureView.mas_bottom).offset(20);
        make.bottom.equalTo(self.mas_bottom).offset(-90);
        make.right.equalTo(signatureView.mas_centerX).offset(-20);
    }];
    
    [vipPay mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(signatureView.mas_bottom).offset(20);
        make.bottom.equalTo(self.mas_bottom).offset(-90);
        make.left.equalTo(signatureView.mas_centerX).offset(20);
        make.right.equalTo(self.mas_right).offset(-40);

    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserInfo) name:UserDataBaseChanged object:nil];

    [self getTotalPrice];
    
    return self;
}

-(void)updateUserInfo
{
    if (currentContactInfo)
    {
        currentContactInfo = [[ContactsDao shareInstanceContactDao] getUserInfo:currentContactInfo.userId];
    }
}

-(void)otherPayAction
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
        
    NSMutableArray *arr = [OrderRecordInfo shareOrderRecordInfo].projectArray;
    NSInteger totalPrice = 0;
    for (NSMutableDictionary *dic in arr)
    {
        NSInteger count = [[dic objectForKey:@"count"] integerValue];
        ProjectInfo *info = [dic objectForKey:@"info"];
        if (currentContactInfo)
        {
            NSInteger price = [info.vipprice integerValue];
            totalPrice = totalPrice + count * price;
        }
        else
        {
            NSInteger price = [info.projectprice integerValue];
            totalPrice = totalPrice + count * price;
        }
    }
    
    QRcodeView *qrview = [[QRcodeView alloc] init];
    qrview.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight - 100);
    qrview.costString = [NSString stringWithFormat:@"%ld",totalPrice];
    WS(weakSelf)
    
    qrview.commiteBlock = ^(){
        [weakSelf otherPaycommiteBlock];
    };
    [self addSubview:qrview];
    
}

-(void)otherPaycommiteBlock
{
    if (currentContactInfo)
    {
        BOOL judgeSelectTechnician = [self judgeAlreadySelectedTechnician];
        if (!judgeSelectTechnician)
        {
            [EasyShowTextView showText:@"请选择服务的技师"];
            return;
        }
        
        BillInfo *billInfo = [[BillInfo alloc] init];
        billInfo.userid = currentContactInfo.userId;
        billInfo.billid = [self uuidString];
        billInfo.projectArray = [[NSMutableArray alloc] init];
        NSMutableArray *arr = [OrderRecordInfo shareOrderRecordInfo].projectArray;
        NSInteger totalPrice = 0;
        for (NSMutableDictionary *dic in arr)
        {
            NSInteger count = [[dic objectForKey:@"count"] integerValue];
            ProjectInfo *info = [dic objectForKey:@"info"];
            NSInteger price = [info.vipprice integerValue];
            totalPrice = totalPrice + count * price;
        }
        
        [billInfo.projectArray addObjectsFromArray:arr];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        billInfo.recordTime = [dateFormatter stringFromDate:[NSDate date]];
        billInfo.premoney = currentContactInfo.userAccountBalance;
        billInfo.balance = [NSString stringWithFormat:@"%ld",[billInfo.premoney integerValue]-totalPrice];
        billInfo.total = [NSString stringWithFormat:@"%ld",totalPrice];
        billInfo.isOtherPay = @"YES";
        UIImage *tempImage = [UIImage getImageViewWithView:signatureView];
        NSString *filePath = [userSignPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",billInfo.billid]]; //Add the file name
        NSData *imageData = UIImagePNGRepresentation(tempImage);
        [imageData writeToFile:filePath atomically:YES];
        billInfo.userSign = [NSString stringWithFormat:@"%@.png",billInfo.billid];
        [[BillDao shareInstanceBillDao] addnewRecord:billInfo];
        
        //添加技师记录
        [self addTechniaicnRecord];
        
        [EasyShowTextView showSuccessText:@"结账成功"];
        
        [self checkSucceed];
        
        
    }
    else
    {
        //添加技师记录
        [self addTechniaicnRecord];
        
        [EasyShowTextView showSuccessText:@"结账成功"];
        
        [self checkSucceed];
    }
}


-(void)vipPayAction
{
    if (currentContactInfo)
    {
        BOOL judgeSelectTechnician = [self judgeAlreadySelectedTechnician];
        if (!judgeSelectTechnician)
        {
            [EasyShowTextView showText:@"请选择服务的技师"];
            return;
        }
        
        BillInfo *billInfo = [[BillInfo alloc] init];
        billInfo.userid = currentContactInfo.userId;
        billInfo.billid = [self uuidString];
        billInfo.projectArray = [[NSMutableArray alloc] init];
        NSMutableArray *arr = [OrderRecordInfo shareOrderRecordInfo].projectArray;
        NSInteger totalPrice = 0;
        for (NSMutableDictionary *dic in arr)
        {
            NSInteger count = [[dic objectForKey:@"count"] integerValue];
            ProjectInfo *info = [dic objectForKey:@"info"];
            NSInteger price = [info.vipprice integerValue];
            totalPrice = totalPrice + count * price;
        }
        
        if (totalPrice > [currentContactInfo.userAccountBalance integerValue])
        {
            [EasyShowTextView showText:@"账户余额不足"];
            return;
        }
        
        [billInfo.projectArray addObjectsFromArray:arr];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        billInfo.recordTime = [dateFormatter stringFromDate:[NSDate date]];
        billInfo.premoney = currentContactInfo.userAccountBalance;
        billInfo.balance = [NSString stringWithFormat:@"%ld",[billInfo.premoney integerValue]-totalPrice];
        billInfo.total = [NSString stringWithFormat:@"%ld",totalPrice];
        billInfo.isOtherPay = @"NO";
        UIImage *tempImage = [UIImage getImageViewWithView:signatureView];
        NSString *filePath = [userSignPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",billInfo.billid]]; //Add the file name
        NSData *imageData = UIImagePNGRepresentation(tempImage);
        [imageData writeToFile:filePath atomically:YES];
        billInfo.userSign = [NSString stringWithFormat:@"%@.png",billInfo.billid];
        [[BillDao shareInstanceBillDao] addnewRecord:billInfo];
        
        //添加技师记录
        [self addTechniaicnRecord];
        
        [EasyShowTextView showSuccessText:@"结账成功"];
        
        [self checkSucceed];
        //更新余额
        [self updateUserBalance:totalPrice];
    }
    else
    {
        MBProgressHUD *my_hud = [[MBProgressHUD alloc] initWithView:self];
        my_hud.mode = MBProgressHUDModeText;
        my_hud.labelText = @"请选择会员";
        [my_hud show:YES];
        [self addSubview:my_hud];
        [my_hud hide:YES afterDelay:3];
        
    }
    
}

-(void)checkSucceed
{
    [[OrderRecordInfo shareOrderRecordInfo].projectArray removeAllObjects];
    [[NSNotificationCenter defaultCenter] postNotificationName:CartProjectChanged object:nil];
    [self clearSign];
    [self refreshData];
    [self showSucceedView];
}


-(void)updateUserBalance:(NSInteger )pay
{
    NSInteger prebalance = [currentContactInfo.userAccountBalance integerValue];
    NSInteger recharge = pay;
    NSInteger total = prebalance - recharge;
    [[ContactsDao shareInstanceContactDao] updateUserBalance:currentContactInfo.userId andBalance:[NSString stringWithFormat:@"%ld",total]];
    [[NSNotificationCenter defaultCenter] postNotificationName:UserDataBaseChanged object:nil];
    //付款结束，记录该记录的 清空
    [OrderRecordInfo shareOrderRecordInfo].contactInfo = [ContactInfo new];

}

-(void)refreshData
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    timeLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    [self getTotalPrice];
    [listView reloadData];
}

-(void)getTotalPrice
{
    NSMutableArray *arr = [OrderRecordInfo shareOrderRecordInfo].projectArray;
    NSInteger totalPrice = 0;
    for (NSMutableDictionary *dic in arr)
    {
        if ([OrderRecordInfo shareOrderRecordInfo].contactInfo.userId)
        {
            NSInteger count = [[dic objectForKey:@"count"] integerValue];
            ProjectInfo *info = [dic objectForKey:@"info"];
            NSInteger price = [info.vipprice integerValue];
            totalPrice = totalPrice + count * price;
        }
        else
        {
            NSInteger count = [[dic objectForKey:@"count"] integerValue];
            ProjectInfo *info = [dic objectForKey:@"info"];
            NSInteger price = [info.projectprice integerValue];
            totalPrice = totalPrice + count * price;
        }

    }
    totalLabel.text = [NSString stringWithFormat:@"总价:  %ld 元",totalPrice];
}

-(void)clearSign
{
    [signatureView erase];
}


-(void)changeCustomerAction
{
    SelectContactView *itemView = [[SelectContactView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    itemView.delegate = self;
    [itemView showInController:[self viewController] preferredStyle:TYAlertControllerStyleActionSheet transitionAnimation:TYAlertTransitionAnimationDropDown backgoundTapDismissEnable:YES];

}

#pragma mark SelectContactViewDelegate
-(void)SelectContact:(ContactInfo *)contact
{
    currentContactInfo = contact;
    if ([NSObject isNullOrNilWithObject:contact.userImage])
    {
        if ([contact.userGender isEqualToString:@"male"])
        {
            headPic.image = [UIImage imageNamed:@"male" imageBundle:@"contact"];
        }
        else
        {
            headPic.image = [UIImage imageNamed:@"female" imageBundle:@"contact"];
        }
    }
    else
    {
        headPic.image = [GlobalDataManager resizeImageByvImage:[UIImage imageWithContentsOfFile:contact.userImage]];
    }
    nameLabel.text = contact.userName;
    [self getTotalPrice];
    [listView reloadData];
}

//获得当前view的控制器
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [OrderRecordInfo shareOrderRecordInfo].projectArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *cellIdentifer = @"ContactIdentifer";
    PayMentRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    
    if (cell == nil)
    {
        cell = [[PayMentRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    NSMutableDictionary *dic = [[OrderRecordInfo shareOrderRecordInfo].projectArray objectAtIndex:indexPath.row];
    [cell setProjectListInfo:dic];
    return cell;
    
    
    
}

#pragma mark - UITableViewDelegate


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * backView = [UIView new];
    backView.backgroundColor = [UIColor colorWithHexString:@"fbf1d7"];
    
    UILabel * deptLabel = [UILabel new];
    deptLabel.font = [UIFont systemFontOfSize:17];
    deptLabel.text = @"消费详情";
    deptLabel.textColor = [UIColor colorWithHexString:@"bda486"];
    [backView addSubview:deptLabel];
    
    [deptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(20);
        make.centerY.equalTo(backView.mas_centerY);
        make.height.equalTo(@40);
    }];
    
    
    return backView;
}

//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView * backView = [UIView new];
//    backView.backgroundColor = [UIColor colorWithHexString:@"fbf1d7"];
//
//    UILabel * deptLabel = [UILabel new];
//    deptLabel.font = [UIFont systemFontOfSize:17];
//    deptLabel.text = @"123123";
//    deptLabel.textColor = [UIColor colorWithHexString:@"bda486"];
//    [backView addSubview:deptLabel];
//
//    [deptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(backView.mas_left);
//        make.centerY.equalTo(backView.mas_centerY);
//        make.height.equalTo(@20);
//    }];
//
//
//    return backView;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30.;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SelectTechnicianView *itemView = [[SelectTechnicianView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    itemView.delegate = self;
    itemView.indexPath = indexPath;
    [itemView showInController:[self viewController] preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationDropDown backgoundTapDismissEnable:YES];
//    [self showSelectTechnicianView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;

}

-(void)addTechniaicnRecord
{
    NSMutableDictionary *technicianDic = [OrderRecordInfo shareOrderRecordInfo].technicianDic;
    NSArray *keysArray = [technicianDic allKeys];
    NSMutableArray *projectArray = [OrderRecordInfo shareOrderRecordInfo].projectArray;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *timeString = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *yearString = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter setDateFormat:@"MM"];
    NSString *MonthString = [dateFormatter stringFromDate:[NSDate date]];
    
    for (NSDictionary *projectDic in projectArray)
    {
        ProjectInfo *projectInfo = [projectDic objectForKey:@"info"];
        TechnicianInfo *technicianInfo = [technicianDic objectForKey:projectInfo.projectid];

        if ([keysArray containsObject:projectInfo.projectid])
        {
            NSString *number = [projectDic objectForKey:@"count"];
            
            if ([number intValue] > 0)
            {
                for (int times = 0 ; times < [number intValue]; times++)
                {
                    NSMutableDictionary *recordTechnicianDic = [NSMutableDictionary new];
                    [recordTechnicianDic setObject:technicianInfo.technicianid forKey:@"technicianid"];
                    [recordTechnicianDic setObject:technicianInfo.technicianname forKey:@"technicianname"];
                    [recordTechnicianDic setObject:timeString forKey:@"recordtime"];
                    [recordTechnicianDic setObject:yearString forKey:@"recordyear"];
                    [recordTechnicianDic setObject:MonthString forKey:@"recordmonth"];
                    if (currentContactInfo)
                    {
                        [recordTechnicianDic setObject:currentContactInfo.userId forKey:@"userid"];
                        [recordTechnicianDic setObject:currentContactInfo.userName forKey:@"username"];
                    }
                    else
                    {
                        [recordTechnicianDic setObject:@"" forKey:@"userid"];
                        [recordTechnicianDic setObject:@"非会员" forKey:@"username"];
                    }

                    [recordTechnicianDic setObject:projectInfo.projectid forKey:@"projectid"];
                    [recordTechnicianDic setObject:projectInfo.projectname forKey:@"projectname"];
                    if ([OrderRecordInfo shareOrderRecordInfo].contactInfo.userId)
                    {
                        [recordTechnicianDic setObject:projectInfo.vipprice forKey:@"projectprice"];
                    }
                    else
                    {
                        [recordTechnicianDic setObject:projectInfo.projectprice forKey:@"projectprice"];
                    }
                    [recordTechnicianDic setObject:@"" forKey:@"mark"];
                    [[TechnicainRecordDao shareInstanceTechnicainRecordDao] addNewTechnichian:recordTechnicianDic];
                }
            }
        

        }
        else
        {
            continue;
        }
        
        
    
    }
}


-(BOOL)judgeAlreadySelectedTechnician
{
    BOOL allSelected = YES;
    NSMutableDictionary *technicianDic = [OrderRecordInfo shareOrderRecordInfo].technicianDic;
    NSArray *keysArray = [technicianDic allKeys];
    NSMutableArray *projectArray = [OrderRecordInfo shareOrderRecordInfo].projectArray;
    
    for (NSDictionary *projectDic in projectArray)
    {
        ProjectInfo *projectInfo = [projectDic objectForKey:@"info"];
        if (![keysArray containsObject:projectInfo.projectid])
        {
            allSelected = NO;
            break;
        }
    }
    return allSelected;
}

-(void)SelectTechnician:(TechnicianInfo *)technician
{
    [listView reloadData];
}



- (NSString *)uuidString
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

-(void)showSucceedView
{
    [[MJPopTool sharedInstance] closeAnimated:NO];

    PaySucceedView *bview = [[PaySucceedView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    [bview setPaySucceedViewInfo:currentContactInfo];
    bview.delegate = self;
    [[MJPopTool sharedInstance] popView:bview animated:YES];
}

-(void)PaySucceedViewRecord
{
    [[MJPopTool sharedInstance] closeAnimated:NO];
    AddRecordView *bview = [[AddRecordView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    [bview setAddRecordViewInfo:currentContactInfo];
    [[self viewController].view addSubview:bview];
}

@end
