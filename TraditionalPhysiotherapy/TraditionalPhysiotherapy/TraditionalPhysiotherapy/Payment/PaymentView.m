//
//  PaymentView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/12/28.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import "PaymentView.h"

@implementation PaymentView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
    {
        return nil;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    
    titleImageView = [[UIImageView alloc] init];
    titleImageView.backgroundColor = [UIColor colorWithHexString:@"4977f1"];
    [self addSubview:titleImageView];
    
    
    contentScrollView = [[UIView alloc] init];
    [self addSubview:contentScrollView];
    
    sgControl = [[UISegmentedControl alloc] initWithItems:@[@"会员结账",@"客户结账"]];
    sgControl.selectedSegmentIndex = 0;
    sgControl.tintColor =[UIColor whiteColor];// [UIColor colorWithHexString:@"4977f1"];
    [sgControl setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIFont systemFontOfSize:18], NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [sgControl setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIFont systemFontOfSize:18], NSFontAttributeName, [UIColor colorWithHexString:@"4977f1"],NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    [sgControl addTarget:self
                  action:@selector(segmentedControlClick:)
        forControlEvents:UIControlEventValueChanged];
//    [self addSubview:sgControl];

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"结账";
    titleLabel.font = [UIFont systemFontOfSize:22];
    titleLabel.textColor = [UIColor whiteColor];
    [titleImageView addSubview:titleLabel];
    
    [titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(70.);
        
    }];
    

//    [sgControl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).offset(20.);
//        make.centerX.equalTo(self.mas_centerX);
//        make.width.equalTo(300.);
//        make.height.equalTo(30.);
//
//    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleImageView.mas_top).offset(30.);
        make.centerX.equalTo(titleImageView.mas_centerX);
        make.width.equalTo(100.);
        make.height.equalTo(30.);
        
    }];
    
    [contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleImageView.mas_bottom);
        make.left.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    
    return self;
}

- (void)segmentedControlClick:(UISegmentedControl*)sender
{
    NSInteger index = sender.selectedSegmentIndex;
    if (delegate)
    {
        [delegate PaymentMethod:index];
    }
}

@end
