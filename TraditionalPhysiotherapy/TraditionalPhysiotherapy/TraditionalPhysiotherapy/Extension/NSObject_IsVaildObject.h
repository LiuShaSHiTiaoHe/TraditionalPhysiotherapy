//
//  NSObject_IsVaildObject.h
//  YC
//
//  Created by Gu GuiJun on 2017/3/20.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (IsVaildObject)

/**
 *  判断对象是否为空
 *  PS：nil、NSNil、@""、@0 以上4种返回YES
 *
 *  @return YES 为空  NO 为实例对象
 */
+ (BOOL)isNullOrNilWithObject:(id)object;


@end
