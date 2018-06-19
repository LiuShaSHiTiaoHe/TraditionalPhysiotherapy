//
//  LeftMenuTableViewCell.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/16.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellIdentifier_Left @"LeftMenuTableViewCell"

@interface LeftMenuTableViewCell : UITableViewCell
{
    UILabel *name;
    UIView *line;
}

@property (nonatomic, strong) UILabel *name;


@end
