//
//  BillDao.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/5.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "BillDao.h"
#import "BillInfo.h"


@implementation BillDao

static BillDao *instance = nil;

+(BillDao *)shareInstanceBillDao
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    
    return instance;
}


-(void)addnewRecord:(BillInfo *)billInfo
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        
        NSData *projectData = [NSKeyedArchiver archivedDataWithRootObject:billInfo.projectArray];

        
        BOOL isSuccess = [db executeUpdate:@"insert into BILL (billid,userid,items,usersign,recordtime,premoney,balance,total,OtherPay) values (?, ?, ?, ?, ?, ?,?,?,?)" ,
                          billInfo.billid,
                          billInfo.userid,
                          projectData,
                          billInfo.userSign,
                          billInfo.recordTime,
                          billInfo.premoney,
                          billInfo.balance,
                          billInfo.total,
                          billInfo.isOtherPay

                          ];
        
        if (isSuccess)
        {
            
        }
        
    }];
}

-(NSMutableArray *)getBillInfoByUser:(NSString *)userid
{
    NSMutableArray *userArray = [[NSMutableArray alloc] init];
    
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM BILL WHERE userid = ? ",userid];
        
        while ([rs next])
        {
            BillInfo *module = [[BillInfo alloc] init];
            
            module.billid = [rs stringForColumn:@"billid"];
            module.userid = [rs stringForColumn:@"userid"];
            
            NSData *projectData = [rs dataForColumn:@"items"];
            NSArray * arr  = [NSKeyedUnarchiver unarchiveObjectWithData:projectData];
            module.projectArray = [[NSMutableArray alloc] init];
            [module.projectArray addObjectsFromArray:arr];
            
            module.userSign = [rs stringForColumn:@"usersign"];
            module.recordTime = [rs stringForColumn:@"recordtime"];
            module.premoney = [rs stringForColumn:@"premoney"];
            module.balance = [rs stringForColumn:@"balance"];
            module.total= [rs stringForColumn:@"total"];
            module.isOtherPay = [rs stringForColumn:@"OtherPay"];

            [userArray addObject:module];
            
        }
        
    }];
    
    return userArray;
}


-(BillInfo *)getBillInfo:(NSString *)billId
{
    BillInfo *module = [[BillInfo alloc] init];

    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM BILL WHERE billid = ? ",billId];
        while ([rs next])
        {
            module.billid = [rs stringForColumn:@"billid"];
            module.userid = [rs stringForColumn:@"userid"];
            NSData *projectData = [rs dataForColumn:@"items"];
            NSArray * arr  = [NSKeyedUnarchiver unarchiveObjectWithData:projectData];
            module.projectArray = [[NSMutableArray alloc] init];
            [module.projectArray addObjectsFromArray:arr];
            module.userSign = [rs stringForColumn:@"usersign"];
            module.recordTime = [rs stringForColumn:@"recordtime"];
            module.premoney = [rs stringForColumn:@"premoney"];
            module.balance = [rs stringForColumn:@"balance"];
            module.total= [rs stringForColumn:@"total"];
            module.isOtherPay = [rs stringForColumn:@"OtherPay"];
        }
    }];
    
    return module;
}

@end
