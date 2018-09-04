//
//  AddTechnician.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/23.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "AddTechnician.h"
#import "TechnicianDao.h"
#import "TechnicianInfo.h"


@implementation AddTechnician
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
//    titleLabel.text = @"添加技师";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:22];
    titleLabel.textColor = [UIColor whiteColor];
    [titleView addSubview:titleLabel];
    
    cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setImage:[UIImage imageNamed:@"cancle" imageBundle:@"contact"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:cancleBtn];
    
    
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
    
    currentInfo = [[TechnicianInfo alloc] init];
    [self initUIwithInfo:nil];
    return self;
    
}

-(void)initUIwithInfo:(TechnicianInfo *)info
{
    if ([NSObject isNullOrNilWithObject:info])
    {
        name = @"";
        birthDay = @"";
        gender = @"";
        phone = @"";
        mark = @"";
        titleLabel.text = @"添加技师";
    }
    else
    {
        currentInfo = info;
        name = info.technicianname;
        birthDay = info.technicianAge;
        if ([info.technicianGender isEqualToString:@"male"])
        {
            gender = @"男技师";

        }
        else if([info.technicianGender isEqualToString:@"female"])
        {
            gender = @"女技师";
        }
        if (info.technicianImage)
        {
            userImage.image = [UIImage imageWithContentsOfFile:info.technicianImage];
            userHeadImage =  info.technicianImage;
        }
        phone = info.technicianPhone;
        mark = info.remark;
        titleLabel.text = @"编辑技师";

    }
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

            
        default:
            break;
    }
}

#pragma mark UITableVieDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"ContactInfoTableViewCell";
    AddTechnicianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[AddTechnicianTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    cell.delegate = self;
    [self setCellUI:indexPath.row withCell:cell];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddTechnicianTableViewCell *customCell = (AddTechnicianTableViewCell *)cell;
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
            customCell.messageTextFiled.text = birthDay;
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
            customCell.messageTextFiled.text = mark;
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
-(void)setCellUI:(NSInteger)index withCell:(AddTechnicianTableViewCell *)cell
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
            [cell setCellInfoImageName:@"addUserYuEImage" Name:@"年龄" Message:@"" IndexPath:index];
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
            [cell setCellInfoImageName:@"mark" Name:@"备注" Message:@"" IndexPath:index];
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
            birthDay = text;
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
            mark = text;
        }
            break;


        default:
            break;
    }
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
        gender = @"男技师";
    }
    else
    {
        gender = @"女技师";
    }
    
    [infoTableView reloadData];
    
}

#pragma mark 页面事件
-(void)cancleBtnAction
{
    [self removeFromSuperview];
}


-(void)commiteBtnAction
{
   
        TechnicianInfo *info = [[TechnicianInfo alloc] init];
        info.technicianname = name;
        info.technicianAge = birthDay;
        if ([gender isEqualToString:@"男技师"])
        {
            info.technicianGender = @"male";
        }
        else if([gender isEqualToString:@"女技师"])
        {
            info.technicianGender = @"female";
        }
        
        info.technicianPhone = phone;

        if (!userHeadImage)
        {
            info.technicianImage = @"";
        }
        else
        {
            info.technicianImage = userHeadImage;
        }
 
        info.remark = mark;
        if (currentInfo.technicianid.length > 0)
        {
            info.technicianid = currentInfo.technicianid;
            [[TechnicianDao shareInstanceTechnicianDao] updateTechnichian:info];

        }
        else
        {
            [[TechnicianDao shareInstanceTechnicianDao] addNewTechnichian:info];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:TechnicianDataBaseChange object:nil];
        [self cancleBtnAction];

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



@end
