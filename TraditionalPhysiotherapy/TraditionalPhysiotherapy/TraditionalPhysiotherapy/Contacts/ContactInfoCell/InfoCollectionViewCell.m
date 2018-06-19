//
//  InfoCollectionViewCell.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/12/12.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import "InfoCollectionViewCell.h"

@implementation InfoCollectionViewCell
@synthesize detailText,infoText;
@synthesize vLine,hLine;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

        [self setUserInteractionEnabled:YES];
        self.backgroundColor = [UIColor clearColor];
        
        detailText = [[UILabel alloc] init];
        detailText.backgroundColor=[UIColor clearColor];
        detailText.tag = 1;
        detailText.font = [UIFont systemFontOfSize:28];//FZKTJW--GB1-0
        detailText.textAlignment = NSTextAlignmentCenter;
        detailText.textColor = [UIColor lightGrayColor];
        [self addSubview:detailText];
        
        infoText = [[UILabel alloc] init];
        infoText.backgroundColor=[UIColor clearColor];
        infoText.tag = 2;
        infoText.font = [UIFont systemFontOfSize:18];
        infoText.textAlignment = NSTextAlignmentCenter;
        infoText.textColor = [UIColor grayColor];
        [self addSubview:infoText];
        
        hLine = [[UIImageView alloc] init];
        hLine.image = [UIImage imageNamed:@"home2_title_line01" imageBundle:@"contact"];
        [self addSubview:hLine];
        
        
        vLine = [[UIImageView alloc] init];
        vLine.alpha = .5;
        vLine.image = [UIImage imageNamed:@"home2_title_line02" imageBundle:@"contact"];
        [self addSubview:vLine];

        
        
        [detailText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom).offset(-50);
            make.right.equalTo(self.mas_right);
            make.left.equalTo(self.mas_left);
        }];
        
        [infoText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(detailText.mas_bottom);
            make.bottom.equalTo(self.mas_bottom).offset(-20);
            make.right.equalTo(self.mas_right);
            make.left.equalTo(self.mas_left);
            
        }];
        
        [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).offset(10.);
            make.width.equalTo(1.);
            make.right.equalTo(self.mas_right).offset(-2);
            make.bottom.equalTo(self.mas_bottom).offset(-10.);
        }];

        [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.left.equalTo(self.mas_left).offset(10.);
            make.right.equalTo(self.mas_right).offset(-10.);
            make.bottom.equalTo(self.mas_bottom).offset(-2.);
            
        }];

        
    }
    return self;
}


@end
