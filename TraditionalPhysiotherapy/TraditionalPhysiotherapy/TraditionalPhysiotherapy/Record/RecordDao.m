//
//  RecordDao.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/5.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "RecordDao.h"

static RecordDao *instance = nil;

@implementation RecordDao


+(RecordDao *)shareInstanceRecordDao
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    
    return instance;
}

-(void)addnewRecord:(RecordInfo *)recordInfo
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        NSString *uuidString = [self uuidString];
        for (NSString *path in recordInfo.recordimage)
        {
            NSString *tempPath= [tempFilePath stringByAppendingPathComponent:path];
            NSString *imagePath= [recordImagePath stringByAppendingPathComponent:path];
            [FileManager copyFile:tempPath to:imagePath];

        }
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:recordInfo.recordimage];
        
        [db executeUpdate:@"insert into RECORD (recordid,userid,recordcontent,recordimage,recordtime) values (?, ?, ?, ?, ?)" ,
                          uuidString,
                          recordInfo.userid,
                          recordInfo.recordcontent,
                          data,
                          recordInfo.recordtime
                          ];

        
    }];
}

-(void)editRecord:(RecordInfo *)recordInfo
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        NSString *uuidString = recordInfo.recordid;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:recordInfo.recordimage];
        
        
        [db executeUpdate:@"update RECORD set recordcontent = ?,recordimage= ? where recordid = ?" ,
                          recordInfo.recordcontent,
                          data,
                          uuidString
                          ];
    }];
}


-(NSMutableArray *)getRecordByUserId:(NSString *)userId
{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM RECORD WHERE userId = ? ",userId];
        
        while ([rs next])
        {
            RecordInfo *module = [[RecordInfo alloc] init];
            module.recordid = [rs stringForColumn:@"recordid"];
            module.userid = [rs stringForColumn:@"userid"];
            module.recordcontent = [rs stringForColumn:@"recordcontent"];
            module.recordtime = [rs stringForColumn:@"recordtime"];
            
            NSData *projectData = [rs dataForColumn:@"recordimage"];
            NSArray * arr  = [NSKeyedUnarchiver unarchiveObjectWithData:projectData];
            module.recordimage = [[NSMutableArray alloc] init];
            [module.recordimage addObjectsFromArray:arr];
            
            [retArray addObject:module];
            
        }
        
    }];
    
    return retArray;
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

-(void)addnewRechargeRecord:(NSDictionary *)recordDic
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        NSString *uuidString = [self uuidString];
       
//        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS RechargeRecordTable (rechargeId TEXT, rechargeDate TEXT,rechargeNum TEXT,userId TEXT)"];

        [db executeUpdate:@"insert into RechargeRecordTable (rechargeId,rechargeDate,rechargeNum,userId,totalNum) values (?, ?, ?, ?,?)" ,
         uuidString,
         [recordDic objectForKey:@"rechargeDate"],
         [recordDic objectForKey:@"rechargeNum"],
         [recordDic objectForKey:@"userId"],
         [recordDic objectForKey:@"totalNum"]

         ];
        
        
    }];
}

-(NSMutableArray *)getRechargeRecordByUserId:(NSString *)userId
{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM RechargeRecordTable WHERE userId = ? ",userId];
        
        while ([rs next])
        {
            NSMutableDictionary *retDic = [[NSMutableDictionary alloc] init];
            NSString * recordid = [rs stringForColumn:@"rechargeId"];
            NSString * userid = [rs stringForColumn:@"userid"];
            NSString * rechargeNum = [rs stringForColumn:@"rechargeNum"];
            NSString * rechargeDate = [rs stringForColumn:@"rechargeDate"];
            NSString * totalNum = [rs stringForColumn:@"totalNum"];
            [retDic setObject:recordid forKey:@"rechargeId"];
            [retDic setObject:userid forKey:@"userid"];
            [retDic setObject:rechargeNum forKey:@"rechargeNum"];
            [retDic setObject:rechargeDate forKey:@"rechargeDate"];
            [retDic setObject:totalNum forKey:@"totalNum"];

            
            [retArray addObject:retDic];
            
        }
        
    }];
    
    return retArray;
}


@end
