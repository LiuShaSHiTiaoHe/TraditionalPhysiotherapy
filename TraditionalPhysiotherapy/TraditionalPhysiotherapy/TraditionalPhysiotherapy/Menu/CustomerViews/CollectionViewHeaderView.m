//
//  CollectionViewHeaderView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/16.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "CollectionViewHeaderView.h"

@implementation CollectionViewHeaderView
@synthesize title;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];//rgba(240, 240, 240, 0.8);
        
        backView = [[UIView alloc] init];
//        backView.backgroundColor = rgba(240, 240, 240, 0.8);
        backView.backgroundColor = [UIColor colorWithHexString:@"e2e5e5"];
        [self addSubview:backView];
        
        title = [[UILabel alloc] init];
        title.font = [UIFont systemFontOfSize:14];
        title.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:title];
        
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom).offset(-20);
            
        }];
        
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(backView.mas_left);
            make.right.equalTo(backView.mas_right);
            make.top.equalTo(backView.mas_top);
            make.bottom.equalTo(backView.mas_bottom);

        }];
        
    }
    return self;
}


@end
