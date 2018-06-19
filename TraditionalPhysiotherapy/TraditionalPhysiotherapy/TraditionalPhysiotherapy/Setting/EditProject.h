//
//  EditProject.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/30.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProject : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UIView *backView;
    UITableView *editTableView;
    UIButton *commitButton;
    NSMutableArray *currentArray;
}

@property(nonatomic,strong)UITableView *editTableView;

@end
