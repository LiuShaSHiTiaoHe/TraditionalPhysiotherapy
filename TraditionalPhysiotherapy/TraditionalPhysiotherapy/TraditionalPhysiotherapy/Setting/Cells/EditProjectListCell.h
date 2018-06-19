//
//  EditProjectListCell.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/30.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProjectListCell : UITableViewCell
{
    UILabel *nameLabel;
    UISwitch *mySwitch;
}

@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UISwitch *mySwitch;

@end
