//
//  RecordDao.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/5.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordInfo.h"

@interface RecordDao : NSObject

+(RecordDao *)shareInstanceRecordDao;

-(void)addnewRecord:(RecordInfo *)recordInfo;
-(void)editRecord:(RecordInfo *)recordInfo;
-(NSMutableArray *)getRecordByUserId:(NSString *)userId;


-(void)addnewRechargeRecord:(NSDictionary *)recordDic;
-(NSMutableArray *)getRechargeRecordByUserId:(NSString *)userId;


@end
