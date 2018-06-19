//
//  TechnicainRecordDao.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/28.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "TechnicainRecordDao.h"

static TechnicainRecordDao *instance = nil;

@implementation TechnicainRecordDao

+(TechnicainRecordDao *)shareInstanceTechnicainRecordDao
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    return instance;
}

//[queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
//
//    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS TechnicainRecord (recordid TEXT, technicianid TEXT,recordtime TEXT,recordyear TEXT,recordmonth TEXT,userid TEXT,username TEXT,projectid TEXT,projectname TEXT,projectprice TEXT,mark TEXT)"];
//}];

-(NSMutableArray *)getTechNicianRecordById:(NSString *)technicianID andByYear:(NSString *)yearStr andByMonth:(NSString *)monthStr
{
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        FMResultSet *rs;
        
        if ([monthStr isEqualToString:@""])
        {
            rs = [db executeQuery:@"SELECT * FROM TechnicainRecord where technicianid = ? and recordyear = ?",technicianID,yearStr];

        }
        else
        {
            rs = [db executeQuery:@"SELECT * FROM TechnicainRecord where technicianid = ? and recordyear = ? and recordmonth = ?",technicianID,yearStr,monthStr];

        }
        
        
        while ([rs next])
        {
            NSMutableDictionary *dic = [NSMutableDictionary new];
            NSString *recordid = [rs stringForColumn:@"recordid"];
            NSString *technicianid = [rs stringForColumn:@"technicianid"];
            NSString *technicianname = [rs stringForColumn:@"technicianname"];
            NSString *recordtime = [rs stringForColumn:@"recordtime"];
            NSString *recordyear = [rs stringForColumn:@"recordyear"];
            NSString *recordmonth = [rs stringForColumn:@"recordmonth"];
            NSString *userid = [rs stringForColumn:@"userid"];
            NSString *username = [rs stringForColumn:@"username"];
            NSString *projectid = [rs stringForColumn:@"projectid"];
            NSString *projectname = [rs stringForColumn:@"projectname"];
            NSString *projectprice = [rs stringForColumn:@"projectprice"];
            NSString *mark = [rs stringForColumn:@"mark"];
            
            [dic setObject:recordid forKey:@"recordid"];
            [dic setObject:technicianid forKey:@"technicianid"];
            [dic setObject:technicianname forKey:@"technicianname"];
            [dic setObject:recordtime forKey:@"recordtime"];
            [dic setObject:recordyear forKey:@"recordyear"];
            [dic setObject:recordmonth forKey:@"recordmonth"];
            [dic setObject:userid forKey:@"userid"];
            [dic setObject:username forKey:@"username"];
            [dic setObject:projectid forKey:@"projectid"];
            [dic setObject:projectname forKey:@"projectname"];
            [dic setObject:projectprice forKey:@"projectprice"];
            [dic setObject:mark forKey:@"mark"];
            
            [retArray addObject:dic];
            
        }
        
    }];
    
    return retArray;
}


-(NSMutableArray *)getAllTechnicainRecord
{
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM TechnicainRecord"];
        
        while ([rs next])
        {
            NSMutableDictionary *dic = [NSMutableDictionary new];
            NSString *recordid = [rs stringForColumn:@"recordid"];
            NSString *technicianid = [rs stringForColumn:@"technicianid"];
            NSString *technicianname = [rs stringForColumn:@"technicianname"];
            NSString *recordtime = [rs stringForColumn:@"recordtime"];
            NSString *recordyear = [rs stringForColumn:@"recordyear"];
            NSString *recordmonth = [rs stringForColumn:@"recordmonth"];
            NSString *userid = [rs stringForColumn:@"userid"];
            NSString *username = [rs stringForColumn:@"username"];
            NSString *projectid = [rs stringForColumn:@"projectid"];
            NSString *projectname = [rs stringForColumn:@"projectname"];
            NSString *projectprice = [rs stringForColumn:@"projectprice"];
            NSString *mark = [rs stringForColumn:@"mark"];

            [dic setObject:recordid forKey:@"recordid"];
            [dic setObject:technicianid forKey:@"technicianid"];
            [dic setObject:technicianname forKey:@"technicianname"];
            [dic setObject:recordtime forKey:@"recordtime"];
            [dic setObject:recordyear forKey:@"recordyear"];
            [dic setObject:recordmonth forKey:@"recordmonth"];
            [dic setObject:userid forKey:@"userid"];
            [dic setObject:username forKey:@"username"];
            [dic setObject:projectid forKey:@"projectid"];
            [dic setObject:projectname forKey:@"projectname"];
            [dic setObject:projectprice forKey:@"projectprice"];
            [dic setObject:mark forKey:@"mark"];

            [retArray addObject:dic];
            
        }
        
    }];
    
    return retArray;
}

-(void)addNewTechnichian:(NSMutableDictionary *)info
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        NSString *uuidString = [self uuidString];
        

        
        BOOL isSuccess = [db executeUpdate:@"insert into TechnicainRecord (recordid,technicianid,technicianname,recordtime,recordyear,recordmonth,userid,username,projectid,projectname,projectprice,mark) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)" ,
                          uuidString,
                          [info objectForKey:@"technicianid"],
                          [info objectForKey:@"technicianname"],
                          [info objectForKey:@"recordtime"],
                          [info objectForKey:@"recordyear"],
                          [info objectForKey:@"recordmonth"],
                          [info objectForKey:@"userid"],
                          [info objectForKey:@"username"],
                          [info objectForKey:@"projectid"],
                          [info objectForKey:@"projectname"],
                          [info objectForKey:@"projectprice"],
                          [info objectForKey:@"mark"]
                          ];
        
        if (isSuccess)
        {
            
        }
        
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






