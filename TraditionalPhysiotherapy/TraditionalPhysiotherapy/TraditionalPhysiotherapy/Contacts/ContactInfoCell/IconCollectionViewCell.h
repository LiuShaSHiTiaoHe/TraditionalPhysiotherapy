//
//  IconCollectionViewCell.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/12/12.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IconCollectionViewCell : UICollectionViewCell
{
    UIImageView *iconImage;
    UILabel *infoText;
    UIImageView *hLine;

}

@property (nonatomic ,retain)UIImageView *iconImage;
@property (nonatomic ,retain)UILabel *infoText;
@property (nonatomic ,retain)UIImageView *hLine;;

@end
