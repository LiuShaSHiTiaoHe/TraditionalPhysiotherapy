//
//  PaymentViewController.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/12/28.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentView.h"
#import "CommonCustomerPaymentView.h"
#import "VIPCustomerPaymentView.h"

@interface PaymentViewController : UIViewController<PaymentViewDelegate>
{
    PaymentView *contentView;
    CommonCustomerPaymentView *commonView;
    VIPCustomerPaymentView *vipView;
}
@end
