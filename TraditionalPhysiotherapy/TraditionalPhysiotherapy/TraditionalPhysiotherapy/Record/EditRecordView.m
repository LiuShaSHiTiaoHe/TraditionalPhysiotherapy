//
//  EditRecordView.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/5/13.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "EditRecordView.h"
#import "ProjectDesCollectionViewCell.h"
#import "RecordDao.h"
@implementation EditRecordView

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
    titleLabel.text = @"修改记录";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:22];
    titleLabel.textColor = [UIColor whiteColor];
    [titleView addSubview:titleLabel];
    
    cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setImage:[UIImage imageNamed:@"cancle" imageBundle:@"contact"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:cancleBtn];
    
    
    UIView *personalView = [[UIView alloc] init];
    [contentView addSubview:personalView];
    
    headPic = [[UIImageView alloc] init];
    headPic.layer.masksToBounds = YES;
    headPic.layer.cornerRadius = 50/2;
    [personalView addSubview:headPic];
    
    nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor lightGrayColor];
    nameLabel.font = [UIFont systemFontOfSize:20];
    [personalView addSubview:nameLabel];
    
    
    textView = [FSTextView textView];
    textView.placeholder = @"输入记录";
    textView.borderWidth = 1.f;
    textView.borderColor = UIColor.lightGrayColor;
    textView.cornerRadius = 5.f;
    textView.canPerformAction = NO;
    [contentView addSubview:textView];
    // 限制输入最大字符数.
    textView.maxLength = 400;
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
    
    
    commiteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commiteBtn addTarget:self action:@selector(commiteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [commiteBtn setBackgroundColor:[UIColor colorWithHexString:@"44e6cd"]];
    [commiteBtn setTitle:@"确定修改" forState:UIControlStateNormal];
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
        make.width.equalTo(600.);
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
    
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(titleView.mas_bottom).offset(30.);
        make.right.equalTo(contentView.mas_right).offset(-20.);
        make.left.equalTo(contentView.mas_left).offset(20.);
        make.height.equalTo(200.);
    }];
    
    [imageCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(textView.mas_bottom).offset(30.);
        make.right.equalTo(contentView.mas_right).offset(-20.);
        make.left.equalTo(contentView.mas_left).offset(20.);
        make.bottom.equalTo(contentView.mas_bottom).offset(-50);
        
    }];
    
    
    [commiteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(50);
        make.left.equalTo(contentView.mas_left);
        make.right.equalTo(contentView.mas_right);
        make.bottom.equalTo(contentView.mas_bottom);
    }];
    
    imageArray = [[NSMutableArray alloc] init];
    return self;
    
}

-(void)setAddRecordViewInfo:(ContactInfo *)info
{
    currentInfo = info;
    headPic.image = [UIImage imageWithContentsOfFile:info.userImage];
    nameLabel.text = info.userName;
    
}

-(void)setEditRecordInfo:(RecordInfo *)info
{
    currentRecordInfo = info;
    textView.text = info.recordcontent;
    [imageArray addObjectsFromArray:info.recordimage];
    [imageCollection reloadData];

}


-(void)commiteBtnAction
{
    RecordInfo *recordinfo = [[RecordInfo alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    recordinfo.recordtime = [dateFormatter stringFromDate:[NSDate date]];
    recordinfo.recordcontent = textView.text;
    recordinfo.recordid = currentRecordInfo.recordid;
    recordinfo.recordimage = [[NSMutableArray alloc] init];
    [recordinfo.recordimage addObjectsFromArray:imageArray];
    recordinfo.userid = currentInfo.userId;
    RecordDao *dao = [RecordDao shareInstanceRecordDao];
    [dao editRecord:recordinfo];
    
    [EasyShowTextView showText:@"修改成功！"];
    
    [self cancleBtnAction];
}

-(void)cancleBtnAction
{
    [self removeFromSuperview];
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
    if (imageArray.count == 9)
    {
        return 9;
    }
    return imageArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProjectDesCollectionViewCell *cell = (ProjectDesCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    if (imageArray.count == 0)
    {
        cell.topImage.image = [UIImage imageNamed:@"addProjectPic" imageBundle:@"Project"];
    }
    else if(imageArray.count == 9)
    {
        NSString *stringNameWithPNG = [imageArray objectAtIndex:indexPath.row];
        NSString *filePath = [recordImagePath stringByAppendingPathComponent:stringNameWithPNG]; //Add the file name
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
            NSString *filePath = [recordImagePath stringByAppendingPathComponent:stringNameWithPNG]; //Add the file name
            cell.topImage.image = [UIImage imageWithContentsOfFile:filePath];
        }
    }
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(176, 176);
}


//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //    return UIEdgeInsetsMake(10, 10, 10, 10);
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
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
        imagePickerController.maximumNumberOfSelection = 9;
        
        [[self viewController] presentViewController:imagePickerController animated:YES completion:^{
        }];
    }
    else
    {
        [imageArray removeObjectAtIndex:indexPath.row];
        [collectionView reloadData];
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
        //        NSString *stringNameWithPNG = [NSString stringWithFormat:@"%@.png",time_stamp_string];
        [imageArray addObject:stringNameWithPNG];
        NSLog(@"stringNameWithPNG %@",stringNameWithPNG);
        
    }
    
    
    
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
    NSString *filePath = [recordImagePath stringByAppendingPathComponent:stringNameWithPNG]; //Add the file name
    [imageData writeToFile:filePath atomically:YES];
    return filePath;
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
