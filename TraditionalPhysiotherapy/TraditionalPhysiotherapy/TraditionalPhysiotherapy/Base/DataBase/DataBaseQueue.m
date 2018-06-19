//
//  DataBaseQueue.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/11/17.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import "DataBaseQueue.h"
#import "FMDatabaseAdditions.h"
NSString *const databaseKey = @"Comprise";

@implementation DataBaseQueue

+ (void)example
{
    
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        [db executeUpdate:@"create table if not exists test (a text, b text, c integer, d double, e double)"];
        
        int i = 0;
        while (i++ < 20)
        {
            [db executeUpdate:@"insert into test (a, b, c, d, e) values (?, ?, ?, ?, ?)" ,
             @"hi'", // look!  I put in a ', and I'm not escaping it!
             [NSString stringWithFormat:@"number %d", i],
             [NSNumber numberWithInt:i],
             [NSDate date],
             [NSNumber numberWithFloat:2.2f]];
        }
        
        FMResultSet *rs = [db executeQuery:@"select rowid,* from test where a = ?", @"hi'"];
        
        while ([rs next])
        {
            if (!([[rs columnNameForIndex:0] isEqualToString:@"rowid"] &&
                  [[rs columnNameForIndex:1] isEqualToString:@"a"])
                )
            {
                NSLog(@"WHOA THERE BUDDY, columnNameForIndex ISN'T WORKING!");
            }
        }
        
        [rs close];
        
    }];
}

+ (void)createAllTable
{
    [self createUserTable];
    [self createTechnicianTable];
    [self createRecordTable];
    [self createConsumptionTable];

    [self createProjectTable];
    [self createProjectSectionTable];
    [self createTechnicainRecordTable];
    [self createRechargeRecordTable];
}



+ (void)createUserTable
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS USER (userid TEXT, username TEXT, userGender TEXT, userAge TEXT, userPhone TEXT,userWechat TEXT,userQQ TEXT,userheight TEXT,userweight TEXT,userjob TEXT,userbirthday TEXT,userHoroscope TEXT,userImage TEXT,userAccountBalance TEXT,isVIP TEXT,remark TEXT,isdelete TEXT)"];
    }];
}

+ (void)createTechnicianTable
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS Technician (technicianid TEXT, technicianname TEXT, technicianGender TEXT, technicianAge TEXT, technicianPhone TEXT,technicianImage TEXT,remark TEXT,isdelete TEXT)"];
    }];
}


+ (void)createProjectTable
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS Project (projectid TEXT, projectname TEXT ,sectionid TEXT, projectimage TEXT, projectprice TEXT, projectdescription TEXT,isdelete TEXT)"];
        
        // 判断是否包含表字段
        if (![db columnExists:@"vipprice" inTableWithName:@"Project"])
        {
            NSString *alertStr = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ TEXT",@"Project",@"vipprice"];
            BOOL worked = [db executeUpdate:alertStr];
            if(worked)
            {
                NSLog(@"插入成功");
            }
            else
            {
                NSLog(@"插入失败");
            }
        }

    }];
}

+ (void)createProjectSectionTable
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS ProjectSection (sectionid TEXT, sectionname TEXT, sectionimage TEXT, sectiondescription TEXT,isdelete TEXT)"];
    }];
}



+ (void)createConsumptionTable//消费
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS BILL (billid TEXT, userid TEXT,items blob,usersign TEXT,recordtime TEXT,premoney TEXT,balance TEXT,total TEXT,otherpay TEXT)"];
    }];
}

+ (void)createRecordTable//记录
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS RECORD (recordid TEXT, userid TEXT,recordcontent TEXT,recordimage blob,recordtime TEXT)"];
    }];
}


+ (void)createTechnicainRecordTable//技师的工作记录
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS TechnicainRecord (recordid TEXT, technicianid TEXT,technicianname TEXT,recordtime TEXT,recordyear TEXT,recordmonth TEXT,userid TEXT,username TEXT,projectid TEXT,projectname TEXT,projectprice TEXT,mark TEXT)"];
    }];
}

#pragma mark 充值记录
+(void)createRechargeRecordTable
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS RechargeRecordTable (rechargeId TEXT, rechargeDate TEXT,rechargeNum TEXT,userId TEXT,totalNum TEXT)"];
    }];
}

@end



















