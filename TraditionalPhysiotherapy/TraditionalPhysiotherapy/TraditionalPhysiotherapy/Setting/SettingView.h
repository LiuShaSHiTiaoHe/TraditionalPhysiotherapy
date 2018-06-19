//
//  SettingView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/21.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingView : UIView
{
//    UIImageView *titleImageView;
    UIView *myNavView;
    UILabel *titleLabel;
    UITableView *settingListView;
    UIScrollView *contentScrollView;

}

@property(nonatomic,strong)UITableView *settingListView;
@property(nonatomic,strong)UIScrollView *contentScrollView;

@end
