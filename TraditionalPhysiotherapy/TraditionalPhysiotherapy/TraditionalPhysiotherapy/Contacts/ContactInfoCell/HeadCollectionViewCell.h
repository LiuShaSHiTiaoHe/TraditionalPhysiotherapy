//
//  HeadCollectionViewCell.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/12/14.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadCollectionViewCell : UICollectionViewCell
{
    UIImageView *backImageView;
    UIImageView *headImage;
    UILabel *userName;
    UIButton *editButton;
}

@property (nonatomic,strong)UIImageView *headImage;
@property (nonatomic,strong)UILabel *userName;
@property (nonatomic,strong)UIButton *editButton;
@property (nonatomic,copy)void(^editBlock)(void);
@end
