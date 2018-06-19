//
//  AddProjectSectionView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/22.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddProjectSectionView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIView *backView;
    UITableView *tableView;
    UIButton *commitButton;
    UIButton *cancleButton;
    UITextField *nameTextFiled;
    FSTextView *textView;
}

@end
