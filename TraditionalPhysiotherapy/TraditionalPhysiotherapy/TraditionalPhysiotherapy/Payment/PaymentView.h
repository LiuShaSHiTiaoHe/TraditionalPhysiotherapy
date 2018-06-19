//
//  PaymentView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/12/28.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PaymentViewDelegate <NSObject>

-(void)PaymentMethod:(NSInteger)method;//0 会员  1普通客户 扫码支付

@end


@interface PaymentView : UIView
{
    UIImageView *titleImageView;
    UILabel *titleLabel;
    UIView *contentScrollView;
    UISegmentedControl *sgControl;
    __weak id <PaymentViewDelegate> delegate;
}

@property(nonatomic,weak)id<PaymentViewDelegate>delegate;

@end
