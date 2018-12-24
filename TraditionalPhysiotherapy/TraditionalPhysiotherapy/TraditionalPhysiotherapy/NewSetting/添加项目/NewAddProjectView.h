//
//  NewAddProjectView.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/11.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTImagePickerViewController.h"
#import "ProjectSectionInfo.h"
#import "ProjectInfo.h"
#import "ProjectDao.h"
#import "ProjectDesCollectionViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface NewAddProjectView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,RTImagePickerViewControllerDelegate,UITextFieldDelegate,ZFDropDownDelegate,HWDownSelectedViewDelegate>
{
    UIView *backView;
    UIButton *commitButton;
    UIButton *cancleButton;
    UITextField *nameTextFiled;
    UITextField *priceTextFiled;
    UITextField *vippriceTextFiled;
    
    FSTextView *textView;
    
    HWDownSelectedView *sectionTextfiled;
    ZFDropDown *dropDown;
    UIImageView *imageview;
    UICollectionView *imageCollection;
    
    NSMutableArray *imageArray;
    NSMutableArray *sectionArray;
    NSMutableArray *sectionNameArray;
    
    RTImagePickerViewController *imagePickerController;
    ProjectInfo *currentProjectInfo;
    ProjectSectionInfo *currentSelectedSectionInfo;
}


@end

NS_ASSUME_NONNULL_END
