//
//  GraphicLockButton.m
//  HaidilaoPadV2
//
//  Created by GuGuiJun on 14/10/28.
//  Copyright (c) 2014年 Hoperun. All rights reserved.
//

#import "GraphicLockButton.h"

@implementation GraphicLockButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setup];
    }
    return self;
}

/**
 初始化
 */
- (void)setup
{
    // 设置按钮不可用
    self.userInteractionEnabled = NO;
    
    // 设置默认的背景图片
    [self setBackgroundImage:[UIImage imageNamed:@"kt_btn_circle_normal"] forState:UIControlStateNormal];
    
    // 设置选中时的背景图片(selected)
    [self setBackgroundImage:[UIImage imageNamed:@"kt_btn_circle_select"] forState:UIControlStateSelected];
}

@end
