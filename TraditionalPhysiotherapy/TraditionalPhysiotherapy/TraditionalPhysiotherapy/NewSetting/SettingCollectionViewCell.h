//
//  SettingCollectionViewCell.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/10.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingCollectionViewCell : UICollectionViewCell
{
    UIImageView *imageView;
    UILabel *nameLabel;
}

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *nameLabel;

@end

NS_ASSUME_NONNULL_END
