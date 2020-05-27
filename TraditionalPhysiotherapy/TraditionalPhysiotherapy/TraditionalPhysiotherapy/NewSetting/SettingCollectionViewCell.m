//
//  SettingCollectionViewCell.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/10.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import "SettingCollectionViewCell.h"

@implementation SettingCollectionViewCell
@synthesize imageView;
@synthesize nameLabel;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = NO;
        self.layer.shadowOffset = CGSizeMake(0, 3);
        self.layer.shadowOpacity = 0.4;
        self.layer.shadowRadius = 3;
        self.layer.shadowColor = [UIColor blackColor].CGColor;

        self.layer.cornerRadius = 10;
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor whiteColor].CGColor;

        imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];

        nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:30];
        nameLabel.textColor = [UIColor lightGrayColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:nameLabel];
        
        float consLength = (UIScreenWidth-100)/3;
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.top.equalTo(self.mas_top).offset(30.);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(self.mas_width).offset(-80);
//            if (consLength > 300.)
//            {
//                make.height.equalTo(consLength-160);
//                make.width.equalTo(consLength-160);
//            }
//            else
//            {
//                make.height.equalTo(200);
//                make.width.equalTo(200);
//            }
       
        }];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.mas_bottom).offset(-30.);
            make.left.equalTo(self.mas_left).offset(10.);
            make.right.equalTo(self.mas_right).offset(-10.);
            make.height.equalTo(40);
        }];
        
       
        
    }
    return self;
}
@end
