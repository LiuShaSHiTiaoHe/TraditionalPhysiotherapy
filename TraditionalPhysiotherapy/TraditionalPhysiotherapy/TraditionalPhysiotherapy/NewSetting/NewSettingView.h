//
//  NewSettingView.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/10.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewSettingView : UIView
{
    UIView *myNavView;
    UILabel *titleLabel;
    UICollectionView *infoCollectionView;
}

@property(nonatomic,strong)UICollectionView *infoCollectionView;
@end

NS_ASSUME_NONNULL_END
