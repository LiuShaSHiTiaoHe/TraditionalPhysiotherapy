//
//  VIPCustomerPaymentView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/12/28.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignatureViewQuartz.h"
#import "SelectContactView.h"
#import "BillInfo.h"
#import "PaySucceedView.h"
#import "SelectTechnicianView.h"

@protocol VIPCustomerPaymentViewDelegate <NSObject>

-(void)startCutTheImageWithBillId:(NSString *)billId;
//-(void)checkOutSuccess;

@end

@interface VIPCustomerPaymentView : UIView<UITableViewDelegate,UITableViewDataSource,SelectContactViewDelegate,PaySucceedViewDelegate,SelectTechnicianViewDelegate>
{
    UIImageView *headPic;
    UILabel *nameLabel;
    UIButton *changeCustomer;
    UITableView *listView;
    UILabel *totalLabel;
    
    UILabel *signLabel;
    UILabel *timeLabel;
    SignatureViewQuartz *signatureView;
    UIButton *clearBtn;
    UIButton *otherPay;
    UIButton *vipPay;
    ContactInfo *currentContactInfo;
    __weak id<VIPCustomerPaymentViewDelegate> delegate;
}
@property(nonatomic,weak)id<VIPCustomerPaymentViewDelegate> delegate;


-(void)refreshData;

@end
