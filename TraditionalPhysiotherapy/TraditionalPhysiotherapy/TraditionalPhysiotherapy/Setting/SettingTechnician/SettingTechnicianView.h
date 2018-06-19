//
//  SettingTechnicianView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/6.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingTechnicianViewDelegate <NSObject>

-(void)addTechnician;

@end


@interface SettingTechnicianView : UIView
{
    UITableView *settechnicianTable;
    UILabel *titleLabel;
    __unsafe_unretained id<SettingTechnicianViewDelegate>delegate;
}

@property(nonatomic,assign)id<SettingTechnicianViewDelegate>delegate;
@property(nonatomic,strong)UITableView *settechnicianTable;
@end
