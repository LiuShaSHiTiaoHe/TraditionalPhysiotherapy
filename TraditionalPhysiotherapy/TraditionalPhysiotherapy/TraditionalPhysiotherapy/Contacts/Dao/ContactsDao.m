//
//  ContactsDao.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 12/12/2017.
//  Copyright © 2017 Gu GuiJun. All rights reserved.
//

#import "ContactsDao.h"
#import "ContactInfo.h"

static ContactsDao *instance = nil;


@implementation ContactsDao


+(ContactsDao *)shareInstanceContactDao
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    
    return instance;
}

-(NSMutableArray *)getAllUser
{
    NSMutableArray *userArray = [[NSMutableArray alloc] init];
    
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        FMResultSet *rs = [db executeQuery:@"SELECT userId,userName,userGender,userAge,userPhone,userWechat,userQQ,userHeight,userWeight,userJob,userBirthday,userHoroscope,userImage,userAccountBalance,isVIP,remark FROM USER WHERE ISDELETE = ? ORDER BY userId ASC",@"0"];
        
        while ([rs next])
        {
            ContactInfo *module = [[ContactInfo alloc] init];
            
            module.userId = [rs stringForColumn:@"userId"];
            module.userName = [rs stringForColumn:@"userName"];
            module.userGender = [rs stringForColumn:@"userGender"];
            module.userAge = [rs stringForColumn:@"userAge"];
            module.userPhone = [rs stringForColumn:@"userPhone"];
            module.userWechat = [rs stringForColumn:@"userWechat"];
            
            module.userQQ = [rs stringForColumn:@"userQQ"];
            module.userHeight = [rs stringForColumn:@"userHeight"];
            module.userWeight = [rs stringForColumn:@"userWeight"];
            module.userJob = [rs stringForColumn:@"userJob"];
            module.userBirthday = [rs stringForColumn:@"userBirthday"];
            module.userHoroscope = [rs stringForColumn:@"userHoroscope"];

            NSString *tempstring = [rs stringForColumn:@"userImage"];
            if (![tempstring isEqualToString:@""])
            {
                module.userImage = [userHeadPicPath stringByAppendingPathComponent:[rs stringForColumn:@"userImage"]];
            }
            else
            {
                module.userImage = @"";
            }
//            module.userImage = [userHeadPicPath stringByAppendingPathComponent:[rs stringForColumn:@"userImage"]];
            module.userAccountBalance = [rs stringForColumn:@"userAccountBalance"];
            module.isVIP = [rs stringForColumn:@"isVIP"];
            module.remark = [rs stringForColumn:@"remark"];
            module.isDelete = @"0";

            if (module.userName.length > 0)
            {
                [userArray addObject:module];
            }
            
        }
        
    }];
    
    return userArray;
}


-(void)addnewUser:(ContactInfo *)userInfo
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        NSString *uuidString = [self uuidString];
        NSString *imageName = @"";
        if (![userInfo.userImage isEqualToString:@""])
        {
            NSString *headPicDirPath= [userHeadPicPath
                                       stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",uuidString]];
            [FileManager copyFile:userInfo.userImage to:headPicDirPath];
            imageName = [NSString stringWithFormat:@"%@.png",uuidString];
        }

   BOOL isSuccess = [db executeUpdate:@"insert into USER (userId,userName,userGender,userAge,userPhone,userWechat,userQQ,userHeight,userWeight,userJob,userBirthday,userHoroscope,userImage,userAccountBalance,isVIP,remark,ISDELETE) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)" ,
         uuidString,
         userInfo.userName,
         userInfo.userGender,
         userInfo.userAge,
         userInfo.userPhone,
         userInfo.userWechat,
         userInfo.userQQ,
         userInfo.userHeight,
         userInfo.userWeight,
         userInfo.userJob,
         userInfo.userBirthday,
         userInfo.userHoroscope,
         imageName,
         userInfo.userAccountBalance,
         userInfo.isVIP,
         userInfo.remark,
         @"0"
         ];
        
        if (isSuccess)
        {
            
        }
        
    }];
}

-(void)updateUserBalance:(NSString *)userid andBalance:(NSString *)balance
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        [db executeUpdate:@"update USER set userAccountBalance = ? where userId = ?",balance,userid];
        
    }];
}


-(void)updateUserInfo:(ContactInfo *)userInfo
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        NSString *uuidString = userInfo.userId;
        NSString *imageName = @"";
        if (![userInfo.userImage isEqualToString:@""])
        {
            NSString *headPicDirPath= [userHeadPicPath
                                       stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",uuidString]];
            [FileManager copyFile:userInfo.userImage to:headPicDirPath];
            imageName = [NSString stringWithFormat:@"%@.png",uuidString];
        }
        
        BOOL isSuccess = [db executeUpdate:@"update USER set userName = ?,userGender= ?,userAge = ?,userPhone = ?,userWechat = ?,userQQ = ?,userHeight = ?,userWeight = ?,userJob = ?,userBirthday = ?,userHoroscope = ?,userImage = ?,userAccountBalance = ?,isVIP = ?,remark = ?,ISDELETE = ? where userId = ?" ,
                          
                          userInfo.userName,
                          userInfo.userGender,
                          userInfo.userAge,
                          userInfo.userPhone,
                          userInfo.userWechat,
                          userInfo.userQQ,
                          userInfo.userHeight,
                          userInfo.userWeight,
                          userInfo.userJob,
                          userInfo.userBirthday,
                          userInfo.userHoroscope,
                          imageName,
                          userInfo.userAccountBalance,
                          userInfo.isVIP,
                          userInfo.remark,
                          @"0",
                          uuidString
                          ];
        
        if (isSuccess)
        {
            
        }
        
    }];
}
-(ContactInfo *)getUserInfo:(NSString *)userId
{
    ContactInfo *module = [[ContactInfo alloc] init];

    
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM USER WHERE userId = ? ",userId];
        
        while ([rs next])
        {
            
            module.userId = [rs stringForColumn:@"userId"];
            module.userName = [rs stringForColumn:@"userName"];
            module.userGender = [rs stringForColumn:@"userGender"];
            module.userAge = [rs stringForColumn:@"userAge"];
            module.userPhone = [rs stringForColumn:@"userPhone"];
            module.userWechat = [rs stringForColumn:@"userWechat"];
        
            module.userQQ = [rs stringForColumn:@"userQQ"];
            module.userHeight = [rs stringForColumn:@"userHeight"];
            module.userWeight = [rs stringForColumn:@"userWeight"];
            module.userJob = [rs stringForColumn:@"userJob"];
            module.userBirthday = [rs stringForColumn:@"userBirthday"];
            module.userHoroscope = [rs stringForColumn:@"userHoroscope"];
            
            NSString *tempstring = [rs stringForColumn:@"userImage"];
            if (![tempstring isEqualToString:@""])
            {
                module.userImage = [userHeadPicPath stringByAppendingPathComponent:[rs stringForColumn:@"userImage"]];
            }
            else
            {
                module.userImage = @"";
            }
            module.userAccountBalance = [rs stringForColumn:@"userAccountBalance"];
            module.isVIP = [rs stringForColumn:@"isVIP"];
            module.remark = [rs stringForColumn:@"remark"];
            module.isDelete = @"0";
            
        }
        
    }];
    
    return module;
}
-(void)deleteSelectedUserInfo:(NSString *)userId
{
    FMDatabaseQueue *queue = [DataBaseQueue shareInstance];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        NSString *uuidString = userId;
        [db executeUpdate:@"update USER set ISDELETE = ? where userId = ?" ,
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
