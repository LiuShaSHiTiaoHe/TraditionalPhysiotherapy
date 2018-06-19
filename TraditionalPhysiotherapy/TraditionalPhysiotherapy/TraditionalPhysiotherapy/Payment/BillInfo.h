//
//  BillInfo.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/5.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillInfo : NSObject
//[db executeUpdate:@"CREATE TABLE IF NOT EXISTS BILL (billid TEXT, userid TEXT,items blob,usersign TEXT,recordtime TEXT)"];

@property(nonatomic,strong)NSString *billid;
@property(nonatomic,strong)NSString *userid;
@property(nonatomic,strong)NSMutableArray *projectArray;
@property(nonatomic,strong)NSString *userSign;
@property(nonatomic,strong)NSString *recordTime;
@property(nonatomic,strong)NSString *premoney;//付款前
@property(nonatomic,strong)NSString *balance;//付款后
@property(nonatomic,strong)NSString *total;//总价
@property(nonatomic,strong)NSString *isOtherPay;//其他方式付款

@end
