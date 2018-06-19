//
//  MenuViewController.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/16.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController
{
    UIImageView *titleImageView;
    UILabel *titleLabel;
    UIButton *cartButton;
    UILabel *cartNumberLabel;
}

@property(nonatomic,strong)UIButton *cartButton;

@end
