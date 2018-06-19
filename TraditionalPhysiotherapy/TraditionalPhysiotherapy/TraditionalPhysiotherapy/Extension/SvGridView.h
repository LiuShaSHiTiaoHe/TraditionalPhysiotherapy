//
//  SvGridView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/26.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SvGridView : UIView
/**
 * @brief 网格间距，默认30
 */
@property (nonatomic, assign) CGFloat   gridSpacing;
/**
 * @brief 网格线宽度，默认为1 pixel (1.0f / [UIScreen mainScreen].scale)
 */
@property (nonatomic, assign) CGFloat   gridLineWidth;
/**
 * @brief 网格颜色，默认蓝色
 */
@property (nonatomic, strong) UIColor   *gridColor;

@end
