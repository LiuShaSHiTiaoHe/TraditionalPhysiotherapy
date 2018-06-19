//
//  SettingViewCell.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/6.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewCell : UITableViewCell
{
    UIImageView *iconImage;
    UILabel *titleLabel;
    UILabel *contentLabel;
    UIImageView *accView;
}


@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *contentLabel;
@property(nonatomic,retain)UIImageView *iconImage;
@property(nonatomic,retain)UIImageView *accView;
@end
