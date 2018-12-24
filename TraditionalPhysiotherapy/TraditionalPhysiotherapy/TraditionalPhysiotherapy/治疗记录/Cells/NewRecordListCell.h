//
//  NewRecordListCell.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/18.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordInfo.h"

NS_ASSUME_NONNULL_BEGIN
@protocol NewRecordListCellDelegate <NSObject>

-(void)RecordListCellSelectImage:(NSString *)imagePath;

@end

@interface NewRecordListCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UILabel *timeLabel;
    UIImageView *timeImage;
    UILabel *detialLabel;
    UITextView *recordText;
    UICollectionView *imageCollection;
    NSMutableArray *curentArray;
    __weak id<NewRecordListCellDelegate>delegate;
}

@property(nonatomic,weak)id<NewRecordListCellDelegate>delegate;

-(void)recordListCellSetRecordInfo:(RecordInfo *)info;

@end

NS_ASSUME_NONNULL_END
