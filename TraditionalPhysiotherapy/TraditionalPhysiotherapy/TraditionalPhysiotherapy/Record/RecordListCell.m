//
//  RecordListCell.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/6.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "RecordListCell.h"
#import "ProjectDesCollectionViewCell.h"

@implementation RecordListCell
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        timeLabel = [[UILabel alloc] init];
        timeLabel.font = [UIFont systemFontOfSize:18];
        timeLabel.numberOfLines = 0;
        //        timeLabel.textColor = [UIColor colorWithHexString:@"4977f1"];
        timeLabel.textColor = [UIColor lightGrayColor];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:timeLabel];
        
        timeImage = [[UIImageView alloc] init];
        //        timeImage.image = [UIImage imageNamed:@"time_axis" imageBundle:@"payment"];
        [self addSubview:timeImage];
        
        UIView *dot = [UIView new];
        dot.backgroundColor = [UIColor colorWithHexString:@"4977f1"];
        dot.layer.cornerRadius = 14/2;
        dot.clipsToBounds = YES;
        [timeImage addSubview:dot];
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor colorWithHexString:@"4977f1"];
        [timeImage addSubview:line];
        
        detialLabel = [[UILabel alloc] init];
        detialLabel.font = [UIFont systemFontOfSize:16];
        detialLabel.textColor = [UIColor lightGrayColor];
        detialLabel.text = @"记录详情";
        detialLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:detialLabel];
        
       
        recordText = [[UITextView alloc] init];
        recordText.userInteractionEnabled = NO;
        // 设置预设文本
        recordText.text = @"这是一条记录";
        // 设置文本字体
        recordText.font = [UIFont fontWithName:@"Arial" size:16.5f];
        // 设置文本颜色
        recordText.textColor = [UIColor blackColor];
        // 设置文本框背景颜色
        recordText.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];;
        // 设置文本对齐方式
        recordText.textAlignment = NSTextAlignmentLeft;
        // 设置自动纠错方式
        recordText.autocorrectionType = UITextAutocorrectionTypeNo;
        
        //外框
//        recordText.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        recordText.layer.borderWidth = 1;
//        recordText.layer.cornerRadius =5;
        
        // 设置是否可以拖动
        recordText.scrollEnabled = YES;

        //自适应高度
        recordText.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self addSubview: recordText];
        
 
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
        
        
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).offset(10.);
            make.top.equalTo(self.mas_top).offset(10.);
            make.height.equalTo(60);
            make.width.equalTo(100);
            
        }];
        
        [timeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(timeLabel.mas_right);
            make.top.equalTo(self.mas_top);
            make.width.equalTo(10);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        [dot mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(timeImage.mas_centerX);
            make.top.equalTo(timeImage.mas_top);
            make.width.equalTo(14);
            make.height.equalTo(14);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(timeImage.mas_centerX);
            make.top.equalTo(dot.mas_bottom);
            make.width.equalTo(2);
            make.bottom.equalTo(timeImage.mas_bottom).offset(-4);
        }];
        
       
        
        [detialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(timeImage.mas_right).offset(20);
            make.top.equalTo(self.mas_top).offset(20);
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.equalTo(30.);
        }];
        
        [recordText mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(timeImage.mas_right).offset(20);
            make.top.equalTo(detialLabel.mas_bottom).offset(10);
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.equalTo(200.);
        }];
        
        [imageCollection mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(timeImage.mas_right).offset(20);
            make.top.equalTo(recordText.mas_bottom).offset(10);
            make.right.equalTo(self.mas_right).offset(-20);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
        
        curentArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)recordListCellSetRecordInfo:(RecordInfo *)info
{
    [curentArray removeAllObjects];
    NSArray *timearr = [info.recordtime componentsSeparatedByString:@" "];
    timeLabel.text = [NSString stringWithFormat:@"%@\r%@",[timearr objectAtIndex:0],[timearr objectAtIndex:1]];
    [curentArray addObjectsFromArray:info.recordimage];
    recordText.text = info.recordcontent;
    [imageCollection reloadData];
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

    return curentArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProjectDesCollectionViewCell *cell = (ProjectDesCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    NSString *stringNameWithPNG = [curentArray objectAtIndex:indexPath.row];
    NSString *filePath = [recordImagePath stringByAppendingPathComponent:stringNameWithPNG]; //Add the file name
    cell.topImage.image = [UIImage imageWithContentsOfFile:filePath];
 
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(420/3, 420/3);
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
    return 10;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *stringNameWithPNG = [curentArray objectAtIndex:indexPath.row];
    NSString *filePath = [recordImagePath stringByAppendingPathComponent:stringNameWithPNG]; //Add the file name
    if (delegate)
    {
        [delegate RecordListCellSelectImage:filePath];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
