//
//  BalanceShortView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/12/21.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContactInfo;

@protocol BalanceShortViewDelegate <NSObject>

-(void)BalanceShortViewRecharge;

-(void)BalanceShortViewShowRechargeRecord;

@end

@interface BalanceShortView : UIView
{
    UIView *backGroundView;
    UIView *whiteBackView;
    UIImageView *iconImageView;
    UILabel *balanceLabel;
    UILabel *balanceText;

    UIButton *confirmBtn;
    UIButton *rechargeBtn;
    ContactInfo*currentInfo;
    
    UIButton *rechargeRecordbtn;
    
    __unsafe_unretained id<BalanceShortViewDelegate>delegate;
}

@property(nonatomic,assign)id<BalanceShortViewDelegate>delegate;

-(void)setContactInfo:(ContactInfo *)info;

@end
