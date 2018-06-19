//
//  AddProjrctView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/29.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTImagePickerViewController.h"
#import "ProjectSectionInfo.h"
#import "ProjectInfo.h"

@interface AddProjrctView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,RTImagePickerViewControllerDelegate,UITextFieldDelegate,ZFDropDownDelegate,HWDownSelectedViewDelegate>
{
    UIView *backView;
    UITableView *tableView;
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
