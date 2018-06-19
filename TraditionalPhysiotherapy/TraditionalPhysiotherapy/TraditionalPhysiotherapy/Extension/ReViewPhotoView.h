//
//  ReViewPhotoView.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/5/13.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^longPressBlock)(UIImage *image);

@interface ReViewPhotoView : UIView

- (instancetype)initWithFrame:(CGRect)frame Photo:(UIImage *)photo;

@property (copy, nonatomic) longPressBlock longpressblock;

@end
