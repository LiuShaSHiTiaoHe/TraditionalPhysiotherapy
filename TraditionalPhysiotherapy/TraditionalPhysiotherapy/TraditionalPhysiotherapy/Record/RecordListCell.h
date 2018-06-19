//
//  RecordListCell.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/6.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordInfo.h"

@protocol RecordListCellDelegate <NSObject>

-(void)RecordListCellSelectImage:(NSString *)imagePath;


@end

@interface RecordListCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UILabel *timeLabel;
    UIImageView *timeImage;
    UILabel *detialLabel;
    UITextView *recordText;
    UICollectionView *imageCollection;
    NSMutableArray *curentArray;
    __unsafe_unretained id<RecordListCellDelegate>delegate;
}

@property(nonatomic,assign)id<RecordListCellDelegate>delegate;

-(void)recordListCellSetRecordInfo:(RecordInfo *)info;

@end
