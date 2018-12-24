//
//  ProjectDao.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/21.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "ProjectDao.h"
#import "ProjectSectionInfo.h"
#import "ProjectInfo.h"


static ProjectDao *instance = nil;
@implementation ProjectDao

+(ProjectDao *)shareInstanceProjectDao
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    
    return instance;
}

-(NSMutableArray *)getAllSection
{
    NSMutableArray *userArray = [[NSMutableArray alloc] init];
    
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        FMResultSet *rs = [db executeQuery:@"SELECT sectionid,sectionname,sectionimage,sectiondescription,ISDELETE FROM ProjectSection "];
        
        while ([rs next])
        {
            ProjectSectionInfo *module = [[ProjectSectionInfo alloc] init];
            module.sectionname = [rs stringForColumn:@"sectionname"];
            module.sectiondescription = [rs stringForColumn:@"sectiondescription"];
            module.isdelete = [rs stringForColumn:@"isdelete"];
            module.sectionid = [rs stringForColumn:@"sectionid"];
           
            [userArray addObject:module];
            
        }
        
    }];
    
    return userArray;
}

-(void)addNewSection:(NSDictionary *)dic
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        NSString *uuidString = [self uuidString];
        [db executeUpdate:@"insert into ProjectSection (sectionid,sectionname,sectiondescription,ISDELETE) values (?, ?, ?,?)" ,
                          uuidString,
                          [dic objectForKey:@"sectionname"],
                          [dic objectForKey:@"sectiondescription"],
                          @"0"
                          ];
        
    }];
}

-(void)updateProjectSection:(NSString *)sectiontId andState:(NSString *)isdelete
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        [db executeUpdate:@"update ProjectSection set isdelete = ? where projectid = ?",isdelete,sectiontId];
        
    }];
}


-(NSMutableArray *)getAllProject
{
    NSMutableArray *userArray = [[NSMutableArray alloc] init];
    
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM Project "];
        
        while ([rs next])
        {
            ProjectInfo *module = [[ProjectInfo alloc] init];
            module.projectid = [rs stringForColumn:@"projectid"];
            module.projectname = [rs stringForColumn:@"projectname"];
            module.sectionid = [rs stringForColumn:@"sectionid"];
            module.projectprice = [rs stringForColumn:@"projectprice"];
            if ([NSObject isNullOrNilWithObject:[rs stringForColumn:@"vipprice"]])
            {
                module.vipprice = @"";
            }
            else
            {
                module.vipprice = [rs stringForColumn:@"vipprice"];
            }
            module.projectdescription = [rs stringForColumn:@"projectdescription"];
            module.isdelete = [rs stringForColumn:@"isdelete"];
            NSString *imageString = [rs stringForColumn:@"projectimage"];
            module.projectimages = [[NSMutableArray alloc] init];
            [module.projectimages addObjectsFromArray:[imageString componentsSeparatedByString:@","]];

            if ([module.isdelete isEqualToString:@"1"])
            {
                
            }
            else
            {
                [userArray addObject:module];
            }
        }
        
    }];
    
    return userArray;
}


-(void)addNewProject:(ProjectInfo *)info
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        NSString *uuidString = [self uuidString];
        NSMutableString *imageString =[[NSMutableString alloc]initWithString:@""];
        for (NSString *imagePath in info.projectimages)
        {
            if ([imageString isEqualToString:@""])
            {
                [imageString appendFormat:@"%@",imagePath];
            }
            else
            {
                [imageString appendFormat:@",%@",imagePath];
            }
            NSString *projectimagePath= [projectPicPath
                                       stringByAppendingPathComponent:imagePath];
            NSString *tempimagePath= [tempFilePath
                                       stringByAppendingPathComponent:imagePath];
            
            [FileManager copyFile:tempimagePath to:projectimagePath];

        }
                
        [db executeUpdate:@"insert into Project (projectid,projectname,sectionid,projectimage,projectprice,projectdescription,ISDELETE,vipprice) values (?, ?, ?,?,?,?,?,?)" ,
         uuidString,
         info.projectname,
         info.sectionid,
         imageString,
         info.projectprice,
         info.projectdescription,
         info.isdelete,
         info.vipprice
         ];
        
    }];
}


-(void)updateNewProject:(ProjectInfo *)info
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        NSString *uuidString = info.projectid;
        NSMutableString *imageString =[[NSMutableString alloc]initWithString:@""];
        for (NSString *imagePath in info.projectimages)
        {
            if ([imageString isEqualToString:@""])
            {
                [imageString appendFormat:@"%@",imagePath];
            }
            else
            {
                [imageString appendFormat:@",%@",imagePath];
            }
//            NSString *projectimagePath= [projectPicPath
//                                         stringByAppendingPathComponent:imagePath];
//            NSString *tempimagePath= [tempFilePath
//                                      stringByAppendingPathComponent:imagePath];
//            
//            [FileManager copyFile:tempimagePath to:projectimagePath];
            
        }
        
        
        [db executeUpdate:@"update Project set projectname = ?,sectionid= ?,projectimage = ?,projectprice = ?,projectdescription = ?,ISDELETE = ? ,vipprice = ? where projectid = ?" ,
                          
                          info.projectname,
                          info.sectionid,
                          imageString,
                          info.projectprice,
                          info.projectdescription,
                          info.isdelete,
                          info.vipprice,
                          uuidString
                          ];
        
        
    }];
}




-(NSMutableArray *)getProjectWithId:(NSString *)sectionid
{
    NSMutableArray *userArray = [[NSMutableArray alloc] init];
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM Project where sectionid = ?",sectionid];
        
        while ([rs next])
        {
            ProjectInfo *module = [[ProjectInfo alloc] init];
            module.projectid = [rs stringForColumn:@"projectid"];
            module.projectname = [rs stringForColumn:@"projectname"];
            module.sectionid = [rs stringForColumn:@"sectionid"];
            module.projectprice = [rs stringForColumn:@"projectprice"];
            if ([NSObject isNullOrNilWithObject:[rs stringForColumn:@"vipprice"]])
            {
                module.vipprice = @"";
            }
            else
            {
                module.vipprice = [rs stringForColumn:@"vipprice"];
            }
            module.projectdescription = [rs stringForColumn:@"projectdescription"];
            module.isdelete = [rs stringForColumn:@"isdelete"];
            NSString *imageString = [rs stringForColumn:@"projectimage"];
            module.projectimages = [[NSMutableArray alloc] init];
            [module.projectimages addObjectsFromArray:[imageString componentsSeparatedByString:@","]];
            
            if (![module.isdelete isEqualToString:@"1"])
            {
                [userArray addObject:module];
            }

        }
        
    }];
    
    return userArray;
}

-(void)updateProject:(NSString *)projectId andState:(NSString *)isdelete
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        [db executeUpdate:@"update Project set isdelete = ? where projectid = ?",isdelete,projectId];
        
    }];
}


- (NSString *)uuidString
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

@end
