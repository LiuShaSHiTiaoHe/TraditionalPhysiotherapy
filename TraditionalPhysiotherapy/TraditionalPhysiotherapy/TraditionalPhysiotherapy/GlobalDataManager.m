//
//  GlobalDataManager.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/6.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "GlobalDataManager.h"
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>

@implementation GlobalDataManager

#pragma mark - 手势密码
#pragma mark 手势密码是否打开
+ (BOOL)OpenGestureCode
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    return [prefs boolForKey:@"openGestureCode"];
}
#pragma mark 设置手势打开或者关闭
+ (void)setOpenGestureCode:(BOOL)enable
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setValue:[NSNumber numberWithBool:enable] forKey:@"openGestureCode"];
    [prefs synchronize];
}
#pragma mark 获得手势密码
+ (NSString *)getGestureCode
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs objectForKey:@"GestureCode"];
}
#pragma mark 设置手势密码
+ (void)setGestureCode:(NSString *)code
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:code forKey:@"GestureCode"];
    [prefs synchronize];
}

+ (UIImage *)resizeImageByvImage:(UIImage *)srcImage withScale:(double)scale
{
    UIImage *inImage = srcImage;
    NSAssert(inImage, @"error");
    
//    NSLog(@"in %@", NSStringFromCGSize(inImage.size));
    
    CGImageRef inImageRef = [inImage CGImage];
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(inImageRef);
    CFDataRef inBitmapData       = CGDataProviderCopyData(inProvider);
    
    vImage_Buffer inBuffer = {
        .data     = (void *)CFDataGetBytePtr(inBitmapData),
        .width    = CGImageGetWidth(inImageRef),
        .height   = CGImageGetHeight(inImageRef),
        .rowBytes = CGImageGetBytesPerRow(inImageRef),
    };
    
    
//    double scaleFactor      = 1.0 / 6.0;
    double scaleFactor      = scale;

    void *outBytes          = malloc(trunc(inBuffer.height * scaleFactor) * inBuffer.rowBytes);
    vImage_Buffer outBuffer = {
        .data     = outBytes,
        .width    = trunc(inBuffer.width * scaleFactor),
        .height   = trunc(inBuffer.height * scaleFactor),
        .rowBytes = inBuffer.rowBytes,
    };
    
    vImage_Error error =
    vImageScale_ARGB8888(&inBuffer,
                         &outBuffer,
                         NULL,
                         kvImageHighQualityResampling);
    if (error)
    {
        NSLog(@"Error: %ld", error);
    }
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef c                = CGBitmapContextCreate(outBuffer.data,
                                                          outBuffer.width,
                                                          outBuffer.height,
                                                          8,
                                                          outBuffer.rowBytes,
                                                          colorSpaceRef,
                                                          kCGImageAlphaNoneSkipLast);
    CGImageRef outImageRef = CGBitmapContextCreateImage(c);
    UIImage *outImage      = [UIImage imageWithCGImage:outImageRef];
    
    CGImageRelease(outImageRef);
    CGContextRelease(c);
    CGColorSpaceRelease(colorSpaceRef);
    CFRelease(inBitmapData);
    free(outBytes);
//    NSLog(@"out %@", NSStringFromCGSize(outImage.size));
    return outImage;
}
+ (UIImage *)resizeImageByvImage:(UIImage *)srcImage
{
    return [self resizeImageByvImage:srcImage withScale:(1.0 / 6.0)];
}

+ (void)showHUDWithText:(NSString *)message addTo:(UIView *)view dismissDelay:(double) delay animated:(BOOL)animated
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:animated];
    
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.textColor = [UIColor whiteColor];
    hud.label.font = [UIFont systemFontOfSize:33];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.userInteractionEnabled = NO;
    hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    // Move to bottm center.
    hud.minSize = CGSizeMake(400., 250.);
    [hud hideAnimated:animated afterDelay:delay];
}

@end
