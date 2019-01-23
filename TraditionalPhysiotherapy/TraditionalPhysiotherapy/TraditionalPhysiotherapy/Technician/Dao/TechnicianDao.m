//
//  TechnicianDao.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/5.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "TechnicianDao.h"
#import "TechnicianInfo.h"

static TechnicianDao *instance = nil;

@implementation TechnicianDao

+(TechnicianDao *)shareInstanceTechnicianDao
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    return instance;
}

-(NSMutableArray *)getAllTechnichian
{
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        FMResultSet *rs = [db executeQuery:@"SELECT technicianid,technicianname,technicianGender,technicianAge,technicianPhone,technicianImage,remark FROM Technician WHERE ISDELETE = ? ORDER BY technicianid ASC",@"0"];
        
        while ([rs next])
        {
            TechnicianInfo *module = [[TechnicianInfo alloc] init];
            
            module.technicianid = [rs stringForColumn:@"technicianid"];
            module.technicianname = [rs stringForColumn:@"technicianname"];
            module.technicianGender = [rs stringForColumn:@"technicianGender"];
            module.technicianAge = [rs stringForColumn:@"technicianAge"];
            module.technicianPhone = [rs stringForColumn:@"technicianPhone"];
            
            NSString *tempstring = [rs stringForColumn:@"technicianImage"];
            if (![tempstring isEqualToString:@""])
            {
                module.technicianImage = [userHeadPicPath stringByAppendingPathComponent:[rs stringForColumn:@"technicianImage"]];
            }
            else
            {
                module.technicianImage = @"";
            }
            module.remark = [rs stringForColumn:@"remark"];
            module.isdelete = @"0";
            
            [retArray addObject:module];
            
        }
        
    }];
    
    return retArray;
}

-(void)addNewTechnichian:(TechnicianInfo *)info
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        NSString *uuidString = [self uuidString];
        NSString *imageName = @"";
        if (![info.technicianImage isEqualToString:@""])
        {
            NSString *headPicDirPath= [userHeadPicPath
                                       stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",uuidString]];
            [FileManager copyFile:info.technicianImage to:headPicDirPath];
            imageName = [NSString stringWithFormat:@"%@.png",uuidString];
        }
        
        BOOL isSuccess = [db executeUpdate:@"insert into Technician (technicianid,technicianname,technicianGender,technicianAge,technicianPhone,technicianImage,remark,ISDELETE) values (?, ?, ?, ?, ?, ?, ?, ?)" ,
                          uuidString,
                          info.technicianname,
                          info.technicianGender,
                          info.technicianAge,
                          info.technicianPhone,
                          imageName,
                          info.remark,
                          @"0"
                          ];
        
        if (isSuccess)
        {
            
        }
        
    }];
}


-(void)updateTechnichian:(TechnicianInfo *)info
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        NSString *uuidString = info.technicianid;
        NSString *imageName = @"";
        if (![info.technicianImage isEqualToString:@""])
        {
            NSString *headPicDirPath= [userHeadPicPath
                                       stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",uuidString]];
            [FileManager copyFile:info.technicianImage to:headPicDirPath];
            imageName = [NSString stringWithFormat:@"%@.png",uuidString];
        }
        
        [db executeUpdate:@"update Technician set technicianname = ?,technicianGender= ?,technicianAge = ?,technicianPhone = ?,technicianImage = ?,remark = ?,ISDELETE = ? where technicianid = ?" ,
         
         info.technicianname,
         info.technicianGender,
         info.technicianAge,
         info.technicianPhone,
         imageName,
         info.remark,
         @"0",
         uuidString
         ];
        
    }];
}


-(void)deletTechnician:(NSString *)techID
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        NSString *uuidString = techID;
        
        [db executeUpdate:@"update Technician set ISDELETE = ? where technicianid = ?" ,
         @"1",
         uuidString
         ];
        
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
