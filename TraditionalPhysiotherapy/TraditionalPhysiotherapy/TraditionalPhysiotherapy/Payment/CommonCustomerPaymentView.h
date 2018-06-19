//
//  CommonCustomerPaymentView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/12/28.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonCustomerPaymentView : UIView
{
    UIImageView *aliPayImage;
    UIImageView *aliCode;
    
    UIImageView *weChatPayImage;
    UIImageView *weChatCode;
    UILabel *balanceText;
    UIButton *otherPay;
}

-(void)getTotalPrice;

@end
