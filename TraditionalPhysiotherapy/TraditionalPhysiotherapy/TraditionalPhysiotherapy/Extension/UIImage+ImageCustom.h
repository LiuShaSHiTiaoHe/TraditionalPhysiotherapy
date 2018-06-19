//
//  UIImage+ImageCustom.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/11/26.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageCustom)

+ (UIImage *)imageWithContentsOfFile:(NSString *)imageName imageBundle:(NSString *)bundle;

+ (UIImage *)imageNamed:(NSString *)imageName imageBundle:(NSString *)bundle;

+ (UIImage *)getImageViewWithView:(UIView *)view;

+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

+ (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;

@end
