//
//  TechnicianDao.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/5.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TechnicianInfo;

@interface TechnicianDao : NSObject

+(TechnicianDao *)shareInstanceTechnicianDao;

-(NSMutableArray *)getAllTechnichian;

-(void)addNewTechnichian:(TechnicianInfo *)info;
-(void)updateTechnichian:(TechnicianInfo *)info;
-(void)deletTechnician:(NSString *)techID;
@end
