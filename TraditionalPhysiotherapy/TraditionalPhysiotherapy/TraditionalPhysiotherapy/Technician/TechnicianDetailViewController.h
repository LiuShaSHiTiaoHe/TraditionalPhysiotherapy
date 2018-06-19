//
//  TechnicianDetailViewController.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/31.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TechnicianInfo.h"

@interface TechnicianDetailViewController : UIViewController<HWDownSelectedViewDelegate>
{
    TechnicianInfo *currentInfo;
    UILabel *titleLabel;
    UIImageView *headImage;
    UILabel *nameLabel;
    UILabel *telephone;
    UIButton *chooseDateBtn;
    BOOL viewMode;
    UIPopoverController *popOver;
    UITableView *settechnicianTable;
    NSMutableArray *currentArray;
}

@property(nonatomic,strong)TechnicianInfo *currentInfo;
//-(void)setcurrentInfo:(TechnicianInfo *)info;

@end
