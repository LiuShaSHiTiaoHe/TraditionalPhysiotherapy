//
//  BillDetailListView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/5.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactInfo.h"

@interface BillDetailListView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UIView *backView;
    UIView *maskView;
    UIView *contentView;
    
    UIImageView *titleView;
    UILabel *titleLabel;
    UIButton *cancleBtn;
    
    UITableView *infoTableView;
    NSMutableArray *curentArray;
    ContactInfo *curentInfo;
}

-(void)setBillDetailUserInfo:(ContactInfo *)info;

@end
