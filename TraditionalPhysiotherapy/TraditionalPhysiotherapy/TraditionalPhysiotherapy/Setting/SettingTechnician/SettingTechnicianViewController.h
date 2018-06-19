//
//  SettingTechnicianViewController.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/6.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingTechnicianView.h"

@protocol SettingTechnicianViewControllerDelegate <NSObject>

-(void)addTechnicianToVC;

@end

@interface SettingTechnicianViewController : UIViewController<SettingTechnicianViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    SettingTechnicianView *contentView;
    __unsafe_unretained id<SettingTechnicianViewControllerDelegate>delegate;
    NSMutableArray *technicianArray;
    
}

@property(nonatomic,assign)id<SettingTechnicianViewControllerDelegate>delegate;

@end
