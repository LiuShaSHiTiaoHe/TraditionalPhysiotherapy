//
//  BaseDataBaseQueue.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/11/17.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import "BaseDataBaseQueue.h"

static NSString *databasePath = nil;

FMDatabaseQueue *baseQueue = nil;

@implementation BaseDataBaseQueue

/*!
 @method
 @abstract      数据库队列的实体单例
 
 @note          该对象中的对象属性不可被多线程共享访问修改
 
 @result        返回数据库队列的单例对象
 */
+ (FMDatabaseQueue *)shareInstance
{
    
    if (!baseQueue)
    {
    
        databasePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
                        stringByAppendingPathComponent: @"sqlcipher.db"];
        baseQueue = [FMDatabaseQueue databaseQueueWithPath:databasePath];
        
 
    }
    
    return baseQueue;
}

+ (void)resetDatabase {
    
    [baseQueue close];
    
    baseQueue = nil;
    

}

@end
