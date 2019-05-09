//
//  BillDao.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/5.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BillInfo;

@interface BillDao : NSObject

+(BillDao *)shareInstanceBillDao;

-(void)addnewRecord:(BillInfo *)billInfo;

-(NSMutableArray *)getBillInfoByUser:(NSString *)userid;

-(BillInfo *)getBillInfo:(NSString *)billId;

@end
