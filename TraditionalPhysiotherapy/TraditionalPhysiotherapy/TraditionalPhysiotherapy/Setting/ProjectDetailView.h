//
//  ProjectDetailView.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/4/25.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTImagePickerViewController.h"
#import "ProjectSectionInfo.h"
#import "ProjectInfo.h"
@interface ProjectDetailView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,RTImagePickerViewControllerDelegate,UITextFieldDelegate,ZFDropDownDelegate,HWDownSelectedViewDelegate>
{
    UIView *backView;
    
    UIScrollView *contentScrollView;
    
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
-(void)initUIwithInfo:(ProjectInfo *)info;
@end
