//
//  RechargeRecordView.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/6/3.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContactInfo;

@interface RechargeRecordView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UIView *backView;
    UIView *maskView;
    UIView *contentView;
    
    UIImageView *titleView;
    UILabel *titleLabel;
    UIButton *cancleBtn;
    
    UITableView *infoTableView;
    NSMutableArray *curentArray;
    ContactInfo* currentInfo;
    
}

-(void)setRecordListUserInfo:(ContactInfo *)info;

@end
