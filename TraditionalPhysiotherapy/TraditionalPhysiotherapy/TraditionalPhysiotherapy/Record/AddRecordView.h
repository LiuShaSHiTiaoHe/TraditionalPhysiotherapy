//
//  AddRecordView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/5.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactInfo.h"
#import "RTImagePickerViewController.h"

@interface AddRecordView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,RTImagePickerViewControllerDelegate>
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
    
    FSTextView *textView;
    UICollectionView *imageCollection;
    RTImagePickerViewController *imagePickerController;
    NSMutableArray *imageArray;
}


-(void)setAddRecordViewInfo:(ContactInfo *)info;

@end
