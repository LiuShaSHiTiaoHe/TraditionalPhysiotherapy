//
//  NewContactsCollectionViewCell.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/14.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface NewContactsCollectionViewCell : UICollectionViewCell
{
    UIImageView *imageView;
    UILabel *nameLabel;
    UILabel *phoneLabel;
//    UILabel *lastTimeLabel;
//    UILabel *countLabel;
}

@property(nonatomic,strong)UIImageView *imageView;

-(void)configWithEntity:(ContactInfo *)info;

@end

NS_ASSUME_NONNULL_END
