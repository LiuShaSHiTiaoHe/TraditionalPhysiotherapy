//
//  MenuItemView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/2.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectInfo.h"

#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "TYCyclePagerViewCell.h"

@interface MenuItemView : UIView<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>
{

    UIView *backView;
    UIImageView *contentView;
    UILabel *nameLabel;
    UITextView *desTextView;
    UILabel *priceLabel;
    UILabel *vippriceLabel;
    UIButton *addButton;
    ProjectInfo *currentInfo;

}

@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;
@property (nonatomic, strong) NSArray *datas;

-(void)setViewProjectInfo:(ProjectInfo *)info;

@end
