//
//  TYCyclePagerViewCell.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/31.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "TYCyclePagerViewCell.h"

@implementation TYCyclePagerViewCell
@synthesize imageview;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {

        imageview = [[UIImageView alloc] init];
        [self addSubview:imageview];
        

        
        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
    }
    return self;
}

@end
