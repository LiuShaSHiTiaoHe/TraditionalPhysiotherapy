//
//  RecordListView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/6.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactInfo.h"
#import "RecordInfo.h"
#import "RecordListCell.h"

@protocol RecordListViewDelegate <NSObject>

-(void)RecordListViewAddNewRecord;

-(void)RecordListViewEditRecord:(RecordInfo *)info;

-(void)preViewImage:(NSString *)imagePath;

@end


@interface RecordListView : UIView<UITableViewDelegate,UITableViewDataSource,RecordListCellDelegate>
{
    UIView *backView;
    UIView *maskView;
    UIView *contentView;
    
    UIImageView *titleView;
    UILabel *titleLabel;
    UIButton *cancleBtn;
    
    UITableView *infoTableView;
    NSMutableArray *curentArray;
    UIButton *addBtn;
    ContactInfo *curentInfo;
    __unsafe_unretained id<RecordListViewDelegate>delegate;
}

@property(nonatomic,assign)id<RecordListViewDelegate>delegate;

-(void)setRecordListUserInfo:(ContactInfo *)info;


@end
