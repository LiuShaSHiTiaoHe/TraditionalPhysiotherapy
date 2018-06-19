//
//  AddTechnician.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/23.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTImagePickerViewController.h"
#import "AddVIPChooseGenderView.h"
#import "AddTechnicianTableViewCell.h"
@class TechnicianInfo;

@interface AddTechnician : UIView<UITableViewDataSource,UITableViewDelegate,RTImagePickerViewControllerDelegate,AddTechnicianTableViewCellDelegate,AddVIPChooseGenderViewDelegate>
{
    UIView *backView;
    UIView *maskView;
    UIView *contentView;
    
    UIImageView *titleView;
    UILabel *titleLabel;
    UIButton *cancleBtn;
    UIButton *commiteBtn;
    
    UIImageView *userImage;
    
    UITableView *infoTableView;
    
    UILabel *userGenderLabel;
    UIButton *maleBtn;
    UIButton *femaleBtn;
    
    RTImagePickerViewController *imagePickerController;
    
    NSString *name;
    NSString *birthDay;
    NSString *gender;
    NSString *phone;
    NSString *mark;
    
    NSString * userHoroscope;
    NSString * userHeadImage;
    NSString * userAge;
    
    TechnicianInfo *currentInfo;
    
}

@property (nonatomic, strong) UITableView *infoTableView;
@property (nonatomic, strong) UIView *contentView;

-(void)initUIwithInfo:(TechnicianInfo *)info;


@end
