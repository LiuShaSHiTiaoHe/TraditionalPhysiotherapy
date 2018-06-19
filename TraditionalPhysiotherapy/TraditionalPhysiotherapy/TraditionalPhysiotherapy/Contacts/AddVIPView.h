//
//  AddVIPView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/4.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTImagePickerViewController.h"
#import "AddVipCell.h"

#import "AddVIPChooseGenderView.h"
#import "AddVIPChooseBirthDayView.h"
@class ContactInfo;

@interface AddVIPView : UIView<UITableViewDataSource,UITableViewDelegate,RTImagePickerViewControllerDelegate,AddCustomCellCellDelegate,AddVIPChooseGenderViewDelegate,AddVIPChooseBirthDayViewDelegate>
{
    UIView *backView;
    UIView *maskView;
    UIView *contentView;
    
    UIImageView *titleView;
    UILabel *titleLabel;
    UIButton *cancleBtn;
    UIButton *commiteBtn;
    UIButton *deleteBtn;

    UIImageView *userImage;
    
    UITableView *infoTableView;
    
    UILabel *userGenderLabel;
    UIButton *maleBtn;
    UIButton *femaleBtn;
    
    RTImagePickerViewController *imagePickerController;
    
    NSString *name;
    NSString *birthDay;
    NSString *balance;
    NSString *gender;
    NSString *phone;
    NSString *wechat;
    NSString *qqNumber;
    NSString *weight;
    NSString *height;
    NSString *job;
    
    NSString * userHoroscope;
    NSString * userHeadImage;
    NSString * userAge;
    
    ContactInfo *currentInfo;
    
}

@property (nonatomic, strong) UITableView *infoTableView;
@property (nonatomic, strong) UIView *contentView;

-(void)initUIwithInfo:(ContactInfo *)info;

@end
