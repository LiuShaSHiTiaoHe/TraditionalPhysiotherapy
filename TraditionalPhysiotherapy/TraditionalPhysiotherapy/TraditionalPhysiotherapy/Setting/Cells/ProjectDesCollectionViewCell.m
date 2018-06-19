//
//  ProjectDesCollectionViewCell.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/29.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "ProjectDesCollectionViewCell.h"

@implementation ProjectDesCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _topImage  = [[UIImageView alloc] init];
//        _topImage.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_topImage];
        
        [_topImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self);
        }];
    }
    
    return self;
}


@end
