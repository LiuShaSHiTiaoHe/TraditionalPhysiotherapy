//
//  GlobalDataManager.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/6.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalDataManager : NSObject

+ (UIImage *)resizeImageByvImage:(UIImage *)srcImage;
+ (UIImage *)resizeImageByvImage:(UIImage *)srcImage withScale:(double)scale;

+ (void)showHUDWithText:(NSString *)message addTo:(UIView *)view dismissDelay:(double) delay animated:(BOOL)animated;

#pragma mark 手势密码是否打开
+ (BOOL)OpenGestureCode;
#pragma mark 设置手势打开或者关闭
+ (void)setOpenGestureCode:(BOOL)enable;
#pragma mark 获得手势密码
+ (NSString *)getGestureCode;
#pragma mark 设置手势密码
+ (void)setGestureCode:(NSString *)code;

+(void)resizeRecordImage;

@end
