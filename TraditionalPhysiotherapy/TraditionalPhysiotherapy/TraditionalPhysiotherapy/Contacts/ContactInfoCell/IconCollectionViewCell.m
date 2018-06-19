//
//  IconCollectionViewCell.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/12/12.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import "IconCollectionViewCell.h"

@implementation IconCollectionViewCell
@synthesize infoText,iconImage,hLine;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code NewCharCheckMember@3x
        [self setUserInteractionEnabled:YES];
        self.backgroundColor = [UIColor clearColor];

        iconImage = [[UIImageView alloc] init];
//        iconImage.layer.cornerRadius = 20;
        iconImage.clipsToBounds = YES;
        iconImage.tag =1;
//        iconImage.layer.borderWidth = 1;
//        iconImage.layer.borderColor = [[UIColor whiteColor] CGColor];
        [self addSubview:iconImage];
        
        infoText = [[UILabel alloc] init];
        infoText.backgroundColor=[UIColor clearColor];
        infoText.tag = 2;
        infoText.font = [UIFont systemFontOfSize:16];
        infoText.textAlignment = NSTextAlignmentCenter;
        infoText.textColor = [UIColor grayColor];
        [self addSubview:infoText];
        
        hLine = [[UIImageView alloc] init];
        hLine.image = [UIImage imageNamed:@"home2_title_line01" imageBundle:@"contact"];
        [self addSubview:hLine];
        
        [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
//            make.bottom.equalTo(self.mas_bottom).offset(-30);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(40.);
            make.height.equalTo(40.);
        }];
        
        [infoText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconImage.mas_bottom);
            make.bottom.equalTo(self.mas_bottom);
            make.right.equalTo(self.mas_right);
            make.left.equalTo(self.mas_left);
            
        }];
        
        [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).offset(10.);
            make.width.equalTo(1.);
            make.right.equalTo(self.mas_right).offset(-2);
            make.bottom.equalTo(self.mas_bottom).offset(-10.);
        }];
        
    }
    return self;
}

@end
