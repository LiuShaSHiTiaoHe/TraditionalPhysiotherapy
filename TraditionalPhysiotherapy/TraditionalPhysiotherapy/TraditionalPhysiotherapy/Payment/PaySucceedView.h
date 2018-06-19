//
//  PaySucceedView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/5.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContactInfo;

@protocol PaySucceedViewDelegate <NSObject>

-(void)PaySucceedViewRecord;

@end

@interface PaySucceedView : UIView
{
    UIView *backGroundView;
    UIView *whiteBackView;
    UIImageView *iconImageView;
    UILabel *balanceLabel;
    UILabel *balanceText;
    
    UIButton *confirmBtn;
    UIButton *rechargeBtn;
    
    ContactInfo *currentInfo;
    __unsafe_unretained id<PaySucceedViewDelegate>delegate;
}

@property(nonatomic,assign)id<PaySucceedViewDelegate>delegate;

-(void)setPaySucceedViewInfo:(ContactInfo *)info;

@end
