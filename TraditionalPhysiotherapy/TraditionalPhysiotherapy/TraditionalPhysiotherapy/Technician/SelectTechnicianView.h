//
//  SelectTechnicianView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/27.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TechnicianInfo;

@protocol SelectTechnicianViewDelegate <NSObject>

-(void)SelectTechnician:(TechnicianInfo *)technician;

@end


@interface SelectTechnicianView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIView *backView;
    UIView *maskView;
    UIView *contentView;
    
    UIImageView *titleView;
    UILabel *titleLabel;
    UIButton *cancleBtn;
    UIButton *commiteBtn;
    
    UITableView *infoTableView;
    NSMutableArray *contactArray;
    NSIndexPath *indexPath;
    __unsafe_unretained id<SelectTechnicianViewDelegate>delegate;
}

@property(nonatomic,assign)id<SelectTechnicianViewDelegate>delegate;
@property(nonatomic,strong)NSIndexPath *indexPath;

@end
