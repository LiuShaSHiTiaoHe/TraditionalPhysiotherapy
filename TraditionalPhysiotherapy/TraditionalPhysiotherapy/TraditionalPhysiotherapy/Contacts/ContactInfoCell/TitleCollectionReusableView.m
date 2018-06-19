//
//  TitleCollectionReusableView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/12/14.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import "TitleCollectionReusableView.h"

@implementation TitleCollectionReusableView
@synthesize titlelabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        titlelabel = [[UILabel alloc] init];
        titlelabel.textAlignment = NSTextAlignmentCenter;
        titlelabel.font = [UIFont fontWithName:@"FZKTJW--GB1-0" size:26];//FZKTJW--GB1-0
        titlelabel.textColor = [UIColor grayColor];
        [self addSubview:titlelabel];
        
        [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.right.equalTo(self.mas_right);
            make.left.equalTo(self.mas_left);
        }];
        
        
    }
    return self;
}
@end
