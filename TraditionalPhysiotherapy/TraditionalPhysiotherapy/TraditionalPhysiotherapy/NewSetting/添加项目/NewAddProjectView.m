//
//  NewAddProjectView.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/11.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import "NewAddProjectView.h"

@implementation NewAddProjectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
    {
        return nil;
    }
    
    self.backgroundColor = [UIColor colorWithHexString:@"f0f3f3"];
    
    backView = [[UIView alloc] init];
    [self addSubview:backView];
    
    UIView *myNavView = [[UIView alloc] init];
    myNavView.backgroundColor = [UIColor colorWithHexString:@"4977f1"];
    [backView addSubview:myNavView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"添加项目";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:24.];
    [myNavView addSubview:titleLabel];
    
    nameTextFiled = [[UITextField alloc] init];
    nameTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    nameTextFiled.layer.borderColor = [UIColor lightGrayColor].CGColor;
    nameTextFiled.layer.borderWidth = 1.f;
    nameTextFiled.placeholder = @"输入名称:";
    [backView addSubview:nameTextFiled];
    
    priceTextFiled = [[UITextField alloc] init];
    priceTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    priceTextFiled.layer.borderColor = [UIColor lightGrayColor].CGColor;
    priceTextFiled.layer.borderWidth = 1.f;
    priceTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    priceTextFiled.placeholder = @"输入价格:";
    [backView addSubview:priceTextFiled];
    
    vippriceTextFiled = [[UITextField alloc] init];
    vippriceTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    vippriceTextFiled.layer.borderColor = [UIColor lightGrayColor].CGColor;
    vippriceTextFiled.layer.borderWidth = 1.f;
    vippriceTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    vippriceTextFiled.placeholder = @"输入会员价格:";
    [backView addSubview:vippriceTextFiled];
    
    sectionTextfiled = [[HWDownSelectedView alloc] init];
    sectionTextfiled.layer.borderColor = [UIColor lightGrayColor].CGColor;
    sectionTextfiled.layer.borderWidth = 1.f;
    sectionTextfiled.placeholder = @"选择所属类别";
    sectionTextfiled.backgroundColor = [UIColor whiteColor];
    sectionTextfiled.delegate = self;
    [backView addSubview:sectionTextfiled];

    // FSTextView
    textView = [FSTextView textView];
    textView.placeholder = @"输入描述";
    textView.borderWidth = 1.f;
    textView.borderColor = UIColor.lightGrayColor;
    textView.cornerRadius = 5.f;
    textView.canPerformAction = NO;
    [backView addSubview:textView];
    // 限制输入最大字符数.
    textView.maxLength = 100;
    // 添加输入改变Block回调.
    [textView addTextDidChangeHandler:^(FSTextView *textView) {
        //        (textView.text.length < textView.maxLength) ? weakNoticeLabel.text = @"":NULL;
    }];
    // 添加到达最大限制Block回调.
    [textView addTextLengthDidMaxHandler:^(FSTextView *textView) {
        //        weakNoticeLabel.text = [NSString stringWithFormat:@"最多限制输入%zi个字符", textView.maxLength];
    }];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //2.初始化collectionView
    imageCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self addSubview:imageCollection];
    imageCollection.backgroundColor = [UIColor clearColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [imageCollection registerClass:[ProjectDesCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    //4.设置代理
    imageCollection.delegate = self;
    imageCollection.dataSource = self;
    
    
    
    commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitButton addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [commitButton setBackgroundColor:[UIColor colorWithHexString:@"4eccff"]];
    [commitButton setTitle:@"确定" forState:UIControlStateNormal];
    commitButton.layer.cornerRadius = 10.;
    commitButton.clipsToBounds = YES;
    [backView addSubview:commitButton];
    
    cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleButton addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [cancleButton setBackgroundColor:[UIColor colorWithHexString:@"44e6cd"]];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    cancleButton.layer.cornerRadius = 10.;
    cancleButton.clipsToBounds = YES;
    [backView addSubview:cancleButton];
    
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
    
    [myNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(backView.mas_top);
        make.left.equalTo(backView.mas_left);
        make.right.equalTo(backView.mas_right);
        make.height.equalTo(70.);
    }];
    
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(myNavView.mas_top);
        make.right.equalTo(myNavView.mas_right);
        make.left.equalTo(myNavView.mas_left);
        make.height.equalTo(70.);
    }];
    
    [nameTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNavView.mas_bottom).offset(20.);
        make.right.equalTo(backView.mas_right).offset(-40.);
        make.left.equalTo(backView.mas_left).offset(20.);
        make.height.equalTo(40.);
        
    }];
    
    [priceTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameTextFiled.mas_bottom).offset(20.);
        make.right.equalTo(backView.mas_right).offset(-40.);
        make.left.equalTo(backView.mas_left).offset(20.);
        make.height.equalTo(40.);
        
    }];
    
    [vippriceTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceTextFiled.mas_bottom).offset(20.);
        make.right.equalTo(backView.mas_right).offset(-40.);
        make.left.equalTo(backView.mas_left).offset(20.);
        make.height.equalTo(40.);
        
    }];
    
    [sectionTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(vippriceTextFiled.mas_bottom).offset(30.);
        make.right.equalTo(backView.mas_right).offset(-40.);
        make.left.equalTo(backView.mas_left).offset(20.);
        make.height.equalTo(40.);
        
    }];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(sectionTextfiled.mas_bottom).offset(30.);
        make.right.equalTo(backView.mas_right).offset(-40.);
        make.left.equalTo(backView.mas_left).offset(20.);
        make.height.equalTo(200.);
    }];
    
    [imageCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(textView.mas_bottom).offset(30.);
        make.height.equalTo(514);
        make.left.equalTo(backView.mas_left).offset(20.);
        make.right.equalTo(backView.mas_right).offset(-40.);
        
    }];
    
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView.mas_centerX).offset(-20.);
        make.top.equalTo(imageCollection.mas_bottom).offset(70.);
        make.left.equalTo(backView.mas_left).offset(20.);
        make.height.equalTo(50.);
        
    }];
    
    [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_centerX).offset(20.);
        make.top.equalTo(imageCollection.mas_bottom).offset(70.);
        make.right.equalTo(backView.mas_right).offset(-20.);
        make.height.equalTo(50.);
        
    }];
    
    imageArray = [[NSMutableArray alloc] init];
    sectionArray= [[NSMutableArray alloc] init];
    sectionNameArray = [[NSMutableArray alloc] init];
    [self getAllSction];
    return self;
}


-(void)getAllSction
{
    sectionArray = [[ProjectDao shareInstanceProjectDao] getAllSection];
    for (ProjectSectionInfo *info in sectionArray)
    {
        [sectionNameArray addObject:info.sectionname];
    }
    sectionTextfiled.listArray = sectionNameArray;
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (imageArray.count == 0)
    {
        return 1;
    }
    if (imageArray.count == 4)
    {
        return 4;
    }
    return imageArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProjectDesCollectionViewCell *cell = (ProjectDesCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    //    cell.backgroundColor = [UIColor yellowColor];
    if (imageArray.count == 0)
    {
        cell.topImage.image = [UIImage imageNamed:@"addProjectPic" imageBundle:@"Project"];
    }
    else if(imageArray.count == 4)
    {
        NSString *stringNameWithPNG = [imageArray objectAtIndex:indexPath.row];
        NSString *filePath = [tempFilePath stringByAppendingPathComponent:stringNameWithPNG]; //Add the file name
        cell.topImage.image = [UIImage imageWithContentsOfFile:filePath];
    }
    else
    {
        if (indexPath.row==imageArray.count)
        {
            cell.topImage.image = [UIImage imageNamed:@"addProjectPic" imageBundle:@"Project"];
        }
        else
        {
            NSString *stringNameWithPNG = [imageArray objectAtIndex:indexPath.row];
            NSString *filePath = [tempFilePath stringByAppendingPathComponent:stringNameWithPNG]; //Add the file name
            cell.topImage.image = [UIImage imageWithContentsOfFile:filePath];
        }
    }
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((514-20)/2, (514-20)/2);
}


//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == imageArray.count)
    {
        imagePickerController = [RTImagePickerViewController new];
        imagePickerController.delegate = self;
        imagePickerController.mediaType = RTImagePickerMediaTypeImage;
        imagePickerController.allowsMultipleSelection = YES;
        imagePickerController.showsNumberOfSelectedAssets = YES;
        imagePickerController.maximumNumberOfSelection = 4;
        
        [[self viewController] presentViewController:imagePickerController animated:YES completion:^{
        }];
    }
}


#pragma mark 选择头像回调
- (void)rt_imagePickerController:(RTImagePickerViewController *)imagePickerController didFinishPickingImages:(NSArray<UIImage *> *)images
{
    
    NSLog(@"Send %@",images);
    long long time_stamp_now = [[NSDate date] timeIntervalSince1970];
    NSNumber *longlongNumber = [NSNumber numberWithLongLong:time_stamp_now];
    NSString *time_stamp_string = [longlongNumber stringValue];
    
    for (NSInteger i = 0;i< images.count;i++)
    {
        UIImage *image = images[i];
        NSString *stringNameWithPNG = [NSString stringWithFormat:@"%@_%ld.png",time_stamp_string,i];
        [self savescanresultimage:image imagename:[NSString stringWithFormat:@"%@_%ld",time_stamp_string,i]];
        [imageArray addObject:stringNameWithPNG];
        NSLog(@"stringNameWithPNG %@",stringNameWithPNG);
        
    }
    
    //
    //    NSLog(@"Send %@",images);
    //    long long time_stamp_now = [[NSDate date] timeIntervalSince1970];
    //    NSNumber *longlongNumber = [NSNumber numberWithLongLong:time_stamp_now];
    //    NSString *time_stamp_string = [longlongNumber stringValue];
    //    NSString *picFilePath = [self savescanresultimage:[images objectAtIndex:0] imagename:time_stamp_string];
    //    NSString *stringNameWithPNG = [NSString stringWithFormat:@"%@.png",time_stamp_string];
    //    [imageArray addObject:stringNameWithPNG];
    [imagePickerController dismissViewControllerAnimated:YES completion:^{
        
        [imageCollection reloadData];
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
    NSString *stringNameWithPNG = [NSString stringWithFormat:@"%@.png",strimagename];
    NSData *imageData = UIImagePNGRepresentation(resultimage);
    NSString *filePath = [tempFilePath stringByAppendingPathComponent:stringNameWithPNG]; //Add the file name
    [imageData writeToFile:filePath atomically:YES];
    return filePath;
}


#pragma mark 选择类别
- (void)downSelectedView:(HWDownSelectedView *)selectedView didSelectedAtIndex:(NSIndexPath *)indexPath;
{
    currentSelectedSectionInfo = [sectionArray objectAtIndex:indexPath.row];
}

-(void)confirmBtnAction
{
    if ([nameTextFiled.text isEqualToString:@""])
    {
//        [EasyShowTextView showText:@"请输入名称"];
        [GlobalDataManager showHUDWithText:@"请输入名称" addTo:self dismissDelay:2. animated:YES];
        return;
    }
    if ([textView.text isEqualToString:@""])
    {
//        [EasyShowTextView showText:@"请输入描述"];
        [GlobalDataManager showHUDWithText:@"请输入描述" addTo:self dismissDelay:2. animated:YES];
        return;
    }
    if ([sectionTextfiled.text isEqualToString:@""])
    {
//        [EasyShowTextView showText:@"请选择类别"];
        [GlobalDataManager showHUDWithText:@"请选择类别" addTo:self dismissDelay:2. animated:YES];
        return;
    }
    if ([priceTextFiled.text isEqualToString:@""])
    {
//        [EasyShowTextView showText:@"请输入价格"];
        [GlobalDataManager showHUDWithText:@"请输入价格" addTo:self dismissDelay:2. animated:YES];
        return;
    }
    if ([vippriceTextFiled.text isEqualToString:@""])
    {
//        [EasyShowTextView showText:@"请输入会员价格"];
        [GlobalDataManager showHUDWithText:@"请输入会员价格" addTo:self dismissDelay:2. animated:YES];
        return;
    }
    
    currentProjectInfo = [[ProjectInfo alloc] init];
    currentProjectInfo.sectionid = currentSelectedSectionInfo.sectionid;
    currentProjectInfo.projectname = nameTextFiled.text;
    currentProjectInfo.projectdescription = textView.text;
    currentProjectInfo.projectprice = priceTextFiled.text;
    currentProjectInfo.vipprice = vippriceTextFiled.text;
    currentProjectInfo.isdelete = @"0";
    currentProjectInfo.projectimages = [[NSMutableArray alloc] init];
    [currentProjectInfo.projectimages addObjectsFromArray:imageArray];
    [[ProjectDao shareInstanceProjectDao] addNewProject:currentProjectInfo];
//    [EasyShowTextView showText:@"添加成功"];
    [GlobalDataManager showHUDWithText:@"添加成功" addTo:self dismissDelay:2. animated:YES];
    [self cancleBtnAction];
}



-(void)cancleBtnAction
{
    nameTextFiled.text = @"";
    textView.text = @"";
    priceTextFiled.text = @"";
    sectionTextfiled.placeholder = @"选择所属类别";
    [imageArray removeAllObjects];
    [imageCollection reloadData];
    
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
