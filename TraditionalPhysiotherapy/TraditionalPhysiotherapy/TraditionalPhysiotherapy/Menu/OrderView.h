//
//  OrderView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/4.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderViewDelegate <NSObject>

-(void)willGotoPayMentView;

@end

@interface OrderView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIView *backView;
    UIView *contentView;
    UILabel *titleLabel;
    UITableView *infoTableView;
    UILabel *totalLabel;
    UIButton *cleanCart;
    UIButton *commiteBtn;
    
    __weak id<OrderViewDelegate>delegate;
}

@property(nonatomic,weak)id<OrderViewDelegate>delegate;


@end
