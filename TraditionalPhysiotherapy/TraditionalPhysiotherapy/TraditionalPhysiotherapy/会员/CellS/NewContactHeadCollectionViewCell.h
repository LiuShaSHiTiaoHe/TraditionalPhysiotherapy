//
//  NewContactHeadCollectionViewCell.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/17.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewContactHeadCollectionViewCell : UICollectionViewCell
{
    UIImageView *backImageView;
    UIImageView *headImage;
    UILabel *userName;
}

@property (nonatomic,strong)UIImageView *headImage;
@property (nonatomic,strong)UILabel *userName;
@end

NS_ASSUME_NONNULL_END
