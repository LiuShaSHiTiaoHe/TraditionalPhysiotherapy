//
//  NSObject_IsVaildObject.m
//  YC
//
//  Created by Gu GuiJun on 2017/3/20.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import"NSObject_IsVaildObject.h"

@implementation NSObject(IsVaildObject)

+ (BOOL)isNullOrNilWithObject:(id)object
{
    if (object == nil || [object isEqual:[NSNull null]]) {
        return YES;
    } else if ([object isKindOfClass:[NSString class]]) {
        if ([object isEqualToString:@""]) {
            return YES;
        } else {
            return NO;
        }
    } else if ([object isKindOfClass:[NSNumber class]]) {
        if ([object isEqualToNumber:@0]) {
            return YES;
        } else {
            return NO;
        }
    }
    
    return NO;
}

@end
