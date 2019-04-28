//
//  ProjectDao.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/21.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProjectInfo;
@interface ProjectDao : NSObject

+(ProjectDao *)shareInstanceProjectDao;
-(NSMutableArray *)getAllSection;
-(void)addNewSection:(NSDictionary *)dic;
-(void)updateSection:(NSDictionary *)dic;
-(void)updateProjectSection:(NSString *)sectiontId andState:(NSString *)isdelete;


-(NSMutableArray *)getAllProject;
-(void)addNewProject:(ProjectInfo *)info;
-(void)updateNewProject:(ProjectInfo *)info;
-(NSMutableArray *)getProjectWithId:(NSString *)sectionid;
-(void)updateProject:(NSString *)projectId andState:(NSString *)isdelete;


@end
