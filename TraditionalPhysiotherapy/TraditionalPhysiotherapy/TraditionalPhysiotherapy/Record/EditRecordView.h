//
//  EditRecordView.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/5/13.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactInfo.h"
#import "RTImagePickerViewController.h"
#import "RecordInfo.h"
@interface EditRecordView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,RTImagePickerViewControllerDelegate>
{
    UIView *backView;
    UIView *maskView;
    UIView *contentView;
    UIImageView *headPic;
    UILabel *nameLabel;
    
    UIImageView *titleView;
    UILabel *titleLabel;
    UIButton *cancleBtn;
    UIButton *commiteBtn;
    ContactInfo *currentInfo;
    RecordInfo *currentRecordInfo;
    
    FSTextView *textView;
    UICollectionView *imageCollection;
    RTImagePickerViewController *imagePickerController;
    NSMutableArray *imageArray;
}


-(void)setAddRecordViewInfo:(ContactInfo *)info;
-(void)setEditRecordInfo:(RecordInfo *)info;

@end
