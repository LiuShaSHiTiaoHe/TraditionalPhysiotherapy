//
//  GlobalDataManager.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/6.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "GlobalDataManager.h"

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

@end
