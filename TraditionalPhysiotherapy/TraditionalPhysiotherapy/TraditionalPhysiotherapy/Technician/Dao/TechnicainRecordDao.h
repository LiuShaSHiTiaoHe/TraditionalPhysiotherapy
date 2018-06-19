//
//  TechnicainRecordDao.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/28.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TechnicainRecordDao : NSObject

+(TechnicainRecordDao *)shareInstanceTechnicainRecordDao;

-(NSMutableArray *)getAllTechnicainRecord;

-(void)addNewTechnichian:(NSMutableDictionary *)info;

-(NSMutableArray *)getTechNicianRecordById:(NSString *)technicianID andByYear:(NSString *)yearStr andByMonth:(NSString *)monthStr;
@end
