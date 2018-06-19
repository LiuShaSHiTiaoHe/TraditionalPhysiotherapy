//
//  SettingViewController.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/21.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingView.h"
#import "AddProjectSectionView.h"
#import "AddProjrctView.h"
#import "EditProject.h"
#import "SetGestureCodeView.h"
#import "SettingTechnicianViewController.h"
#import "EditProjectViewController.h"


@interface SettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,GraphicLockViewDelegate,SettingTechnicianViewControllerDelegate>
{
    SettingView *contentView;
    AddProjectSectionView *addProjectSectionView;
    AddProjrctView *addProjectView;
    EditProject *editProjectView;
    SetGestureCodeView *gestureCodeView;
    SettingTechnicianViewController *managerTechnicianVC;
    UINavigationController *nav ;
    UINavigationController *editNav;
    //手势密码
    BOOL ifIgnore;
    int enterTimes;
    NSString *tmpPath;
}

@end
