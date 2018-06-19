//
//  AddVIPChooseGenderView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/11.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "AddVIPChooseGenderView.h"

@implementation AddVIPChooseGenderView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
    {
        return nil;
    }
    
    contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 20.;
    contentView.clipsToBounds = YES;
    [self addSubview:contentView];
    
    
    maleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [maleButton addTarget:self action:@selector(maleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [maleButton setImage:[UIImage imageNamed:@"chooseMaleUnSelected" imageBundle:@"contact"] forState:UIControlStateNormal];
    [maleButton setImage:[UIImage imageNamed:@"chooseMaleSelected" imageBundle:@"contact"] forState:UIControlStateSelected];
    [contentView addSubview:maleButton];
    
    femaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [femaleButton addTarget:self action:@selector(femaleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [femaleButton setImage:[UIImage imageNamed:@"chooseFemaleUnSelected" imageBundle:@"contact"] forState:UIControlStateNormal];
    [femaleButton setImage:[UIImage imageNamed:@"chooseFemaleSelected" imageBundle:@"contact"] forState:UIControlStateSelected];
    [contentView addSubview:femaleButton];
    
    cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setImage:[UIImage imageNamed:@"cancle_blue" imageBundle:@"contact"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:cancleBtn];
    
    
    commiteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commiteBtn addTarget:self action:@selector(commiteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [commiteBtn setBackgroundColor:[UIColor colorWithHexString:@"44e6cd"]];
    [commiteBtn setTitle:@"确定" forState:UIControlStateNormal];
    [contentView addSubview:commiteBtn];
    
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(160.);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(400.);
        make.height.equalTo(300.);
        
    }];
    
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(contentView.mas_right).offset(-20.);
        make.top.equalTo(contentView.mas_top).offset(10.);
        make.width.equalTo(80/3);
        make.height.equalTo(80/3);
    }];
    
    [maleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(contentView.mas_centerX);
        make.width.equalTo(180.);
        make.height.equalTo(180.);
        make.top.equalTo(contentView.mas_top).offset(40.);
    }];
    
    [femaleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(contentView.mas_centerX);
        make.width.equalTo(180.);
        make.height.equalTo(180.);
        make.top.equalTo(contentView.mas_top).offset(40.);
    }];
    
    [commiteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(contentView.mas_left);
        make.right.equalTo(contentView.mas_right);
        make.height.equalTo(60.);
        make.bottom.equalTo(contentView.mas_bottom);
    }];
    
    return self;
    
}

-(void)commiteBtnAction
{
    if (delegate)
    {
        [delegate selectedGender:maleButton.selected];
    }
    [self hideInController];
}

-(void)cancleBtnAction
{
    [self hideInController];
}

-(void)maleButtonAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    femaleButton.selected = btn.selected;
    maleButton.selected = !btn.selected;
}

-(void)femaleButtonAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    maleButton.selected = btn.selected;
    femaleButton.selected = !btn.selected;
}
@end
