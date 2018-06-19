//
//  AddVIPView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/4.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "AddVIPView.h"

#import "ContactInfo.h"
#import "ContactsDao.h"

@implementation AddVIPView
@synthesize infoTableView,contentView;
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
    titleLabel.text = @"添加会员";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:22];
    titleLabel.textColor = [UIColor whiteColor];
    [titleView addSubview:titleLabel];
    
    cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setImage:[UIImage imageNamed:@"cancle" imageBundle:@"contact"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:cancleBtn];
    
    
    
    deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:deleteBtn];
    
    userImage = [[UIImageView alloc] init];
    userImage.image = [UIImage imageNamed:@"addUserImage" imageBundle:@"contact"];
    userImage.userInteractionEnabled = YES;
    [contentView addSubview:userImage];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseUserImage)];
    [userImage addGestureRecognizer:tap];
    
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
        make.width.equalTo(800.);
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
    
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(titleView.mas_left).offset(20.);
        make.centerY.equalTo(titleView.mas_centerY);
        make.width.equalTo(80);
        make.height.equalTo(80/3);
    }];
    
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(titleView.mas_right).offset(-20.);
        make.centerY.equalTo(titleView.mas_centerY);
        make.width.equalTo(80/3);
        make.height.equalTo(80/3);
    }];
    
    [userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@80.);
        make.height.equalTo(@80.);
        make.top.equalTo(titleView.mas_bottom).offset(10.);
        make.centerX.equalTo(contentView.mas_centerX);
    }];
    
    [infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(contentView.mas_left);
        make.right.equalTo(contentView.mas_right);
        make.top.equalTo(userImage.mas_bottom).offset(10.);
        make.bottom.equalTo(contentView.mas_bottom).offset(-50);
    }];
    
    
    [commiteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(infoTableView.mas_bottom);
        make.left.equalTo(contentView.mas_left);
        make.right.equalTo(contentView.mas_right);
        make.bottom.equalTo(contentView.mas_bottom);
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [self initUIwithInfo:nil];
    
    return self;
    
}

-(void)initUIwithInfo:(ContactInfo *)info
{
    if ([NSObject isNullOrNilWithObject:info])
    {
         name = @"";
         birthDay = @"";
         balance = @"";
         gender = @"";
         phone = @"";
         wechat = @"";
         qqNumber = @"";
         weight = @"";
         height = @"";
         job = @"";
        deleteBtn.hidden = YES;
    }
    else
    {
        deleteBtn.hidden = NO;
        currentInfo = info;
        name = info.userName;
        birthDay = info.userBirthday;
        balance = info.userAccountBalance;
        if ([info.userGender isEqualToString:@"male"])
        {
            gender = @"男同学";
        }
        else if([info.userGender isEqualToString:@"female"])
        {
            gender = @"女同学";
        }
        if (info.userImage)
        {
            userImage.image = [UIImage imageWithContentsOfFile:info.userImage];
        }
        gender = info.userGender;
        phone = info.userPhone;
        wechat = info.userWechat;
        qqNumber = info.userQQ;
        weight = info.userWeight;
        height = info.userHeight;
        job = info.userJob;
    }
}

/**
 *  键盘将要显示
 *
 *  @param notification 通知
 */
-(void)keyboardWillShow:(NSNotification *)notification
{
    //这样就拿到了键盘的位置大小信息frame，然后根据frame进行高度处理之类的信息
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(60.);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(800.);
        make.height.equalTo((UIScreenHeight-frame.size.height));
        
        
    }];
    
}

/**
 *  键盘将要隐藏
 *
 *  @param notification 通知
 */
-(void)keyboardWillHidden:(NSNotification *)notification
{
    
    [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(60.);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(800.);
        make.height.equalTo(600.);
        
    }];
    
}


#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row)
    {
        case 2:
        {
            AddVIPChooseGenderView *temp = [[AddVIPChooseGenderView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
            temp.delegate = self;
            [temp showInController:[self viewController] preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationDropDown backgoundTapDismissEnable:YES];
        }
            break;
            
        case 6:
        {
            AddVIPChooseBirthDayView *temp = [[AddVIPChooseBirthDayView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
            temp.delegate = self;
            [temp showInController:[self viewController] preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationDropDown backgoundTapDismissEnable:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark UITableVieDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"ContactInfoTableViewCell";
    AddVipCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[AddVipCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    cell.delegate = self;
    [self setCellUI:indexPath.row withCell:cell];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddVipCell *customCell = (AddVipCell *)cell;
    customCell.messageTextFiled.text = @"";
    customCell.messageTextFiled.userInteractionEnabled = YES;

    switch (indexPath.row)
    {
        case 0:
        {
            customCell.messageTextFiled.text = name;
        }
            break;
        case 1:
        {
            customCell.messageTextFiled.text = balance;
        }
            break;
        case 2:
        {
            customCell.messageTextFiled.text = gender;
            customCell.messageTextFiled.userInteractionEnabled = NO;

        }
            break;
        case 3:
        {
            customCell.messageTextFiled.text = phone;
        }
            break;
        case 4:
        {
            customCell.messageTextFiled.text = wechat;
        }
            break;
        case 5:
        {
            customCell.messageTextFiled.text = qqNumber;
        }
            break;
        case 6:
        {
            customCell.messageTextFiled.text = birthDay;
            customCell.messageTextFiled.userInteractionEnabled = NO;

        }
            break;
        case 7:
        {
            customCell.messageTextFiled.text = weight;
        }
            break;
        case 8:
        {
            customCell.messageTextFiled.text = height;
        }
            break;
        case 9:
        {
            customCell.messageTextFiled.text = job;
        }
            break;
        default:
            break;
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.;
}

#pragma mark 设置Cell
-(void)setCellUI:(NSInteger)index withCell:(AddVipCell *)cell
{
    switch (index)
    {
        case 0:
        {
            [cell setCellInfoImageName:@"addUserNameImage" Name:@"姓名" Message:@"" IndexPath:index];
        }
            break;
        case 1:
        {
            [cell setCellInfoImageName:@"addUserYuEImage" Name:@"余额(元)" Message:@"" IndexPath:index];
        }
            break;
        case 2:
        {
            [cell setCellInfoImageName:@"addUserSexImage@3x" Name:@"性别" Message:@"" IndexPath:index];
        }
            break;
        case 3:
        {
            [cell setCellInfoImageName:@"addUserPhoneImage" Name:@"手机" Message:@"" IndexPath:index];
        }
            break;
        case 4:
        {
            [cell setCellInfoImageName:@"addUserWeChatImage" Name:@"微信" Message:@"" IndexPath:index];
        }
            break;
        case 5:
        {
            [cell setCellInfoImageName:@"addUserQQImage" Name:@"QQ" Message:@"" IndexPath:index];
        }
            break;
        case 6:
        {
            [cell setCellInfoImageName:@"addUserBirthDayImage@3x" Name:@"生日" Message:@"" IndexPath:index];
        }
            break;
        case 7:
        {
            [cell setCellInfoImageName:@"addUserWeightImage@3x" Name:@"体重(kg)" Message:@"" IndexPath:index];
        }
            break;
        case 8:
        {
            [cell setCellInfoImageName:@"addUserheightImage@3x" Name:@"身高(cm)" Message:@"" IndexPath:index];
        }
            break;
        case 9:
        {
            [cell setCellInfoImageName:@"addUserJobImage@3x" Name:@"职业" Message:@"" IndexPath:index];
        }
            break;
        default:
            break;
    }
}

#pragma mark AddCustomCellCellDelegate cell上的TextFiled
// cell的代理方法中拿到text进行保存
- (void)contentDidChanged:(NSString *)text forIndexPath:(NSInteger)indexPath
{
    switch (indexPath)
    {
        case 0:
        {
            name = text;
        }
            break;
        case 1:
        {
            balance = text;
        }
            break;
        case 2:
        {
            gender = text;
        }
            break;
        case 3:
        {
            phone = text;
        }
            break;
        case 4:
        {
            wechat = text;
        }
            break;
        case 5:
        {
            qqNumber = text;
        }
            break;
        case 6:
        {
            birthDay = text;
        }
            break;
        case 7:
        {
            weight = text;
        }
            break;
        case 8:
        {
            height = text;
        }
            break;
        case 9:
        {
            job = text;
        }
            break;
        default:
            break;
    }
}



#pragma mark 页面事件
-(void)cancleBtnAction
{
//    [[MJPopTool sharedInstance] closeAnimated:YES];
//    [self hideInController];
    [self removeFromSuperview];
    
}

-(void)deleteBtnAction
{
    [[ContactsDao shareInstanceContactDao] deleteSelectedUserInfo:currentInfo.userId];
    [[NSNotificationCenter defaultCenter] postNotificationName:UserDataBaseChanged object:nil];
    [self cancleBtnAction];

}


-(void)commiteBtnAction
{
    if (currentInfo)
    {
        
    }
    else
    {
        ContactInfo *info = [[ContactInfo alloc] init];
        info.userName = name;
        info.userBirthday = birthDay;
        info.userAccountBalance = balance;
        if ([gender isEqualToString:@"男同学"])
        {
            info.userGender = @"male";
        }
        else if([gender isEqualToString:@"女同学"])
        {
            info.userGender = @"female";
        }

        info.userPhone = phone;
        info.userWechat = wechat;
        info.userQQ = qqNumber;
        info.userWeight = weight;
        info.userHeight = height;
        info.userJob = job;
        
        info.userHoroscope = userHoroscope;

        if (!userHeadImage)
        {
            info.userImage = @"";
        }
        else
        {
            info.userImage = userHeadImage;
        }
        info.userAge = userAge;
        info.isVIP = @"YES";
        info.remark = @"";
        [[ContactsDao shareInstanceContactDao] addnewUser:info];
        [[NSNotificationCenter defaultCenter] postNotificationName:UserDataBaseChanged object:nil];
        [self cancleBtnAction];
    }
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


#pragma mark 选择头像
-(void)chooseUserImage
{
    imagePickerController = [RTImagePickerViewController new];
    imagePickerController.delegate = self;
    imagePickerController.mediaType = RTImagePickerMediaTypeImage;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.showsNumberOfSelectedAssets = YES;
    imagePickerController.maximumNumberOfSelection = 2;
    
    [[self viewController] presentViewController:imagePickerController animated:YES completion:^{
    }];
}


#pragma mark 选择头像回调
- (void)rt_imagePickerController:(RTImagePickerViewController *)imagePickerController didFinishPickingImages:(NSArray<UIImage *> *)images
{
    NSLog(@"Send %@",images);
    userImage.image = [images objectAtIndex:0];
    userHeadImage = [self savescanresultimage:[images objectAtIndex:0] imagename:@"temp"];
//    userHeadImage = [userDocumentPath stringByAppendingPathComponent:@"temp"]; //Add the file name

    [imagePickerController dismissViewControllerAnimated:YES completion:^{
        
        [infoTableView reloadData];
    }];
}

- (void)rt_imagePickerControllerDidCancel:(RTImagePickerViewController *)imagePickerController
{
    [imagePickerController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)rt_imagePickerController:(RTImagePickerViewController *)imagePickerController didFinishPickingVideoWithURL:(NSURL *)videoURL
{
    NSLog(@"didFinishPickingVideoWithURL : %@",videoURL);
    [imagePickerController dismissViewControllerAnimated:YES completion:^{
    }];
}


#pragma mark 保存图片
-(NSString *)savescanresultimage:(UIImage *)resultimage imagename:(NSString *)strimagename
{
    NSData *imageData = UIImagePNGRepresentation(resultimage);
    NSString *filePath = [userDocumentPath stringByAppendingPathComponent:strimagename]; //Add the file name
    [imageData writeToFile:filePath atomically:YES];
    return filePath;
}

#pragma mark 选择性别回调
-(void)selectedGender:(BOOL)chooseGender  //yes male no female
{
    if (chooseGender)
    {
        gender = @"男同学";
    }
    else
    {
        gender = @"女同学";
    }
    
    [infoTableView reloadData];

}


#pragma mark 选择生日回调
-(void)selectedBirthDay:(NSString *)dateString  //yyyy-MM-dd
{
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateNew = [fomatter dateFromString:dateString];
    [fomatter setDateFormat:@"MM"];
    NSInteger month = [[fomatter stringFromDate:dateNew] integerValue];
    [fomatter setDateFormat:@"dd"];
    NSInteger day = [[fomatter stringFromDate:dateNew] integerValue];
    
    birthDay = dateString;
    userAge = [self dateToOld:dateNew];
    userHoroscope = [self calculateConstellationWithMonth:month day:day];
    
    [infoTableView reloadData];

}


#pragma mark 计算年龄
-(NSString *)dateToOld:(NSDate *)bornDate
{
    //获得当前系统时间
    NSDate *currentDate = [NSDate date];
    //获得当前系统时间与出生日期之间的时间间隔
    NSTimeInterval time = [currentDate timeIntervalSinceDate:bornDate];
    //时间间隔以秒作为单位,求年的话除以60*60*24*356
    int age = ((int)time)/(3600*24*365);
    return [NSString stringWithFormat:@"%d",age];
}


#pragma mark 计算星座
-(NSString *)calculateConstellationWithMonth:(NSInteger)month day:(NSInteger)day
{
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    
    if (month<1 || month>12 || day<1 || day>31)
    {
        return @"错误日期格式!";
    }
    
    if(month==2 && day>29)
    {
        return @"错误日期格式!!";
    }
    else if(month==4 || month==6 || month==9 || month==11)
    {
        if (day>30)
        {
            return @"错误日期格式!!!";
        }
    }
    
    result = [NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(month*2-(day < [[astroFormat substringWithRange:NSMakeRange((month-1), 1)] intValue] - (-19))*2,2)]];
    
    return [NSString stringWithFormat:@"%@座",result];
    
}


@end





