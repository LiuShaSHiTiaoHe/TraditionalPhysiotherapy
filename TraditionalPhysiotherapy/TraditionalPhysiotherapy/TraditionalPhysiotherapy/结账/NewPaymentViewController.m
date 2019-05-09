//
//  NewPaymentViewController.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/19.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import "NewPaymentViewController.h"
#import "NewContactDetailViewController.h"
#import "NewAddRecordViewController.h"

#import "SignatureViewQuartz.h"
#import "SelectContactView.h"
#import "BillInfo.h"
#import "PaySucceedView.h"
#import "SelectTechnicianView.h"

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

@interface NewPaymentViewController ()<UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate,SelectContactViewDelegate,PaySucceedViewDelegate,SelectTechnicianViewDelegate>
{
    UIImageView *headPic;
    UILabel *nameLabel;
    UIButton *changeCustomer;
    UITableView *listView;
    UILabel *totalLabel;
    
    UILabel *signLabel;
    UILabel *timeLabel;
    SignatureViewQuartz *signatureView;
    UIButton *clearBtn;
    UIButton *otherPay;
    UIButton *vipPay;
    ContactInfo *currentContactInfo;
    
    UIImage *shareImage;
}

@end

@implementation NewPaymentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *backView = [[UIView alloc] init];
    [self.view addSubview:backView];
    
    UIView *myNavView = [[UIView alloc] init];
    myNavView.backgroundColor = [UIColor colorWithHexString:@"4977f1"];
    [backView addSubview:myNavView];

    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"结账";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:30];
    [myNavView addSubview:titleLabel];
    
   
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
    
    
    UIView *personalView = [[UIView alloc] init];
    [self.view addSubview:personalView];
    
    headPic = [[UIImageView alloc] init];
    headPic.layer.masksToBounds = YES;
    headPic.layer.cornerRadius = 50/2;
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
    listView.tableHeaderView = [self headViewForTable];
    [self.view addSubview:listView];
    
    signLabel = [[UILabel alloc] init];
    signLabel.text = @"签字";
    signLabel.font = [UIFont systemFontOfSize:26];
    [self.view addSubview:signLabel];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    timeLabel = [[UILabel alloc] init];
    timeLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    timeLabel.font = [UIFont systemFontOfSize:18];
    timeLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:timeLabel];
    
    clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.backgroundColor = [UIColor clearColor];
    //设置button正常状态下的图片
    [clearBtn setImage:[UIImage imageNamed:@"clearBtn" imageBundle:@"payment"] forState:UIControlStateNormal];
    //设置button高亮状态下的图片
    [clearBtn setImage:[UIImage imageNamed:@"clearBtn" imageBundle:@"payment"] forState:UIControlStateHighlighted];
    [clearBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clearSign) forControlEvents:UIControlEventTouchUpInside];
    clearBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:clearBtn];
    
    signatureView = [[SignatureViewQuartz alloc] init];
    signatureView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [self.view addSubview:signatureView];
    
    otherPay = [UIButton buttonWithType:UIButtonTypeCustom];
    otherPay.layer.cornerRadius = 10.;
    [otherPay setTitle:@"其他付款" forState:UIControlStateNormal];
    [otherPay setBackgroundColor:[UIColor colorWithHexString:@"4eccff"]];
    [otherPay addTarget:self action:@selector(otherPayAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:otherPay];
    
    vipPay = [UIButton buttonWithType:UIButtonTypeCustom];
    [vipPay setTitle:@"会员付款" forState:UIControlStateNormal];
    vipPay.layer.cornerRadius = 10.;
    [vipPay setBackgroundColor:[UIColor colorWithHexString:@"44e6cd"]];
    [vipPay addTarget:self action:@selector(vipPayAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:vipPay];
    
    
    UIView *totalBack = [UIView new];
    totalBack.backgroundColor = [UIColor colorWithHexString:@"fbf1d7"];
    [self.view addSubview:totalBack];
    
    totalLabel = [[UILabel alloc] init];
    totalLabel.font = [UIFont systemFontOfSize:18];
    totalLabel.textColor = [UIColor lightGrayColor];
    totalLabel.textAlignment = NSTextAlignmentRight;
    [totalBack addSubview:totalLabel];
    
    
    [personalView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(20.);
        make.top.equalTo(myNavView.mas_bottom).offset(20.);
        make.width.equalTo(500.);
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
        
        make.left.equalTo(self.view.mas_left).offset(20.);
        make.top.equalTo(personalView.mas_bottom).offset(20.);
        make.width.equalTo(500.);
        make.bottom.equalTo(self.view.mas_bottom).offset(-130);
    }];
    
    [totalBack mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(20.);
        make.top.equalTo(listView.mas_bottom);
        make.width.equalTo(500.);
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
        make.top.equalTo(myNavView.mas_bottom).offset(20.);
        make.right.equalTo(self.view.mas_right).offset(-40);
        make.height.equalTo(40.);
    }];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(personalView.mas_right).offset(20.);
        make.top.equalTo(signLabel.mas_bottom).offset(20.);
        make.right.equalTo(self.view.mas_right).offset(-140);
        make.height.equalTo(20.);
    }];
    
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(signLabel.mas_bottom).offset(20.);
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.height.equalTo(30.);
        make.width.equalTo(30.);
        
    }];
    
    [signatureView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(personalView.mas_right).offset(20.);
        make.top.equalTo(timeLabel.mas_bottom).offset(10.);
        make.right.equalTo(self.view.mas_right).offset(-40);
        make.bottom.equalTo(self.view.mas_bottom).offset(-170.);
    }];
    
    [otherPay mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(personalView.mas_right).offset(20.);
        make.top.equalTo(signatureView.mas_bottom).offset(20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-90);
        make.right.equalTo(signatureView.mas_centerX).offset(-20);
    }];
    
    [vipPay mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(signatureView.mas_bottom).offset(20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-90);
        make.left.equalTo(signatureView.mas_centerX).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-40);
        
    }];
  
    
}

-(UIView *)headViewForTable
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400., 40)];
    backView.backgroundColor = [UIColor colorWithHexString:@"fbf1d7"];
    
    UILabel * deptLabel = [UILabel new];
    deptLabel.font = [UIFont systemFontOfSize:17];
    deptLabel.text = @"消费详情";
    deptLabel.textColor = [UIColor colorWithHexString:@"bda486"];
    [backView addSubview:deptLabel];
    
    [deptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(20);
        make.centerY.equalTo(backView.mas_centerY);
        make.height.equalTo(40);
    }];
    return backView;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshData];

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
    qrview.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
    qrview.costString = [NSString stringWithFormat:@"%ld",totalPrice];
    WS(weakSelf)
    
    qrview.commiteBlock = ^(){
        [weakSelf otherPaycommiteBlock];
    };
    [self.view addSubview:qrview];
    
}

-(void)otherPaycommiteBlock
{
    if (currentContactInfo)
    {
        BOOL judgeSelectTechnician = [self judgeAlreadySelectedTechnician];
        if (!judgeSelectTechnician)
        {
//            [EasyShowTextView showText:@"请选择服务的技师"];
            [GlobalDataManager showHUDWithText:@"请选择服务的技师" addTo:self.view dismissDelay:2. animated:YES];
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
        
//        [EasyShowTextView showSuccessText:@"结账成功"];
        [GlobalDataManager showHUDWithText:@"结账成功" addTo:self.view dismissDelay:1. animated:YES];

        [self checkSucceed];
        
        
    }
    else
    {
        //添加技师记录
        [self addTechniaicnRecord];
        
//        [EasyShowTextView showSuccessText:@"结账成功"];
        [GlobalDataManager showHUDWithText:@"结账成功" addTo:self.view dismissDelay:1. animated:YES];

        
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
//            [EasyShowTextView showText:@"请选择服务的技师"];
            [GlobalDataManager showHUDWithText:@"请选择服务的技师" addTo:self.view dismissDelay:2. animated:YES];

            return;
        }
        [self getImage];
        
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
//            [EasyShowTextView showText:@"账户余额不足"];
            [GlobalDataManager showHUDWithText:@"账户余额不足" addTo:self.view dismissDelay:2. animated:YES];
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
        [self checkSucceed];
        //更新余额
        [self updateUserBalance:totalPrice];
        [self shareImage];
    }
    else
    {
        [GlobalDataManager showHUDWithText:@"请选择会员" addTo:self.view dismissDelay:3. animated:YES];
    }
    
}

-(void)getImage
{
    shareImage = [UIImage getImageViewWithView:self.view];
    [self calulateImageFileSize:shareImage];
  
}

-(void)shareImage
{
    NSArray *postItems=@[shareImage];
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:postItems applicationActivities:nil];
    controller.completionWithItemsHandler = ^(UIActivityType  _Nullable   activityType,
                                              BOOL completed,
                                              NSArray * _Nullable returnedItems,
                                              NSError * _Nullable activityError) {
        
        NSLog(@"activityType: %@,\n completed: %d,\n returnedItems:%@,\n activityError:%@",activityType,completed,returnedItems,activityError);
        if (completed)
        {
            
        }
    };
    controller.modalPresentationStyle = UIModalPresentationPopover;
    controller.preferredContentSize = CGSizeMake(400, 300);
    UIPopoverPresentationController *pop = controller.popoverPresentationController;
    pop.sourceView = self.view;
    pop.sourceRect = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height/2, 0, 0);
    pop.permittedArrowDirections = UIPopoverArrowDirectionUp;
    pop.backgroundColor = [UIColor whiteColor];
    pop.delegate = self;
    [self presentViewController:controller animated:YES completion:^{
        
    }];
}
#pragma mark- UIPopoverPresentationControllerDelegate
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}
-(void)checkSucceed
{
    [[OrderRecordInfo shareOrderRecordInfo].projectArray removeAllObjects];
    [[OrderRecordInfo shareOrderRecordInfo].technicianDic removeAllObjects];
    [[NSNotificationCenter defaultCenter] postNotificationName:CartProjectChanged object:nil];
    [self clearSign];
    [self refreshData];
//    [self showSucceedView];
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
    [itemView showInController:self preferredStyle:TYAlertControllerStyleActionSheet transitionAnimation:TYAlertTransitionAnimationDropDown backgoundTapDismissEnable:YES];
    
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
    [itemView showInController:self preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationDropDown backgoundTapDismissEnable:YES];
    //    [self showSelectTechnicianView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
    
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
//    AddRecordView *bview = [[AddRecordView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
//    [bview setAddRecordViewInfo:currentContactInfo];
//    [self.view addSubview:bview];
    self.tabBarController.selectedIndex = 1;
    UIViewController *userViewController =  self.tabBarController.selectedViewController;
    NewAddRecordViewController *temp = [[NewAddRecordViewController alloc] init];
    temp.curentInfo= currentContactInfo;
    [userViewController presentViewController:temp animated:YES completion:^{
        
    }];
    
    
    
}

-(void)PaySucceedViewToUserDetail
{
    [[MJPopTool sharedInstance] closeAnimated:NO];
    self.tabBarController.selectedIndex = 1;
    UIViewController *userViewController =  self.tabBarController.selectedViewController;
    NewContactDetailViewController *temp = [[NewContactDetailViewController alloc] init];
    temp.currentInfo = currentContactInfo;
    [userViewController.navigationController pushViewController:temp animated:YES];
}


- (void)calulateImageFileSize:(UIImage *)image
{
    NSData *data = UIImagePNGRepresentation(image);
    if (!data) {
        data = UIImageJPEGRepresentation(image, 1.0);//需要改成0.5才接近原图片大小，原因请看下文
    }
    double dataLength = [data length] * 1.0;
    NSArray *typeArray = @[@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB",@"ZB",@"YB"];
    NSInteger index = 0;
    while (dataLength > 1024) {
        dataLength /= 1024.0;
        index ++;
    }
    NSLog(@"image = %.3f %@",dataLength,typeArray[index]);
}
@end
