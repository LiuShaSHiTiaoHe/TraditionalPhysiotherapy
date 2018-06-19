//
//  MenuCollectionViewCell.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/16.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellIdentifier_CollectionView @"MenuCollectionViewCell"
@class ProjectInfo;
@class MenuCollectionViewCell;

@protocol MenuCollectionViewCellDelegate <NSObject>

-(void)addToCart:(ProjectInfo *)info andImage:(MenuCollectionViewCell *)shortCut;

@end

@interface MenuCollectionViewCell : UICollectionViewCell
{
    UILabel *name;
    UILabel *priceLabel;
    UILabel *vippriceLabel;
    UIImageView *imageView;
    UIButton *addBtn;
    ProjectInfo *currentInfo;
    CGPoint buttomRect;
    __unsafe_unretained id<MenuCollectionViewCellDelegate>delegate;
}

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, assign) CGPoint buttomRect;
@property (nonatomic, assign) id<MenuCollectionViewCellDelegate>delegate;

-(void)setCellProjectInfo:(ProjectInfo *)info;

@end
