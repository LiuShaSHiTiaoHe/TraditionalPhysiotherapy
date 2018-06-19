//
//  RechargeView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/5.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContactInfo;

@interface RechargeView : UIView
{
    UIView *backView;
    UIView *maskView;
    UIView *contentView;
    
    UIImageView *titleView;
    UILabel *titleLabel;
    UIButton *cancleBtn;
    UIButton *commiteBtn;
    
    UIImageView *headPic;
    UILabel *nameLabel;
    UILabel *balanceLabel;
    UITextField *rechargeTF;
    ContactInfo *curentInfo;
}

-(void)setViewContactInfo:(ContactInfo *)info;


@end
