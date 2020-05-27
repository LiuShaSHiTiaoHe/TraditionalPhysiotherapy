//
//  NewSettingView.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/10.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import "NewSettingView.h"
#import "SettingCollectionViewCell.h"

@implementation NewSettingView
@synthesize infoCollectionView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
    {
        return nil;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    
    myNavView = [[UIView alloc] init];
    myNavView.backgroundColor = [UIColor colorWithHexString:@"4977f1"];
    [self addSubview:myNavView];
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"设置";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:30];
    titleLabel.textColor = [UIColor whiteColor];
    [myNavView addSubview:titleLabel];
    
    //collectionView
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    infoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    infoCollectionView.backgroundColor = [UIColor clearColor];
    infoCollectionView.showsVerticalScrollIndicator = NO;
    infoCollectionView.showsHorizontalScrollIndicator = NO;    
    [infoCollectionView registerClass:[SettingCollectionViewCell class] forCellWithReuseIdentifier:@"SettingCollectionViewCell"];    
    [self addSubview:infoCollectionView];
    
    [myNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(UIScreenWidth);
        make.height.equalTo(80.);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNavView.mas_top).offset(20.);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(UIScreenWidth);
        make.height.equalTo(50.);
        
    }];
    
    [infoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNavView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        
    }];
    
    return self;
}



@end
