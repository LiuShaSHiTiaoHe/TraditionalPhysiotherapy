//
//  BaseDataBaseQueue.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/11/17.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"

FOUNDATION_EXPORT      NSString             *const databaseKey;


@interface BaseDataBaseQueue : NSObject

/*!
 @method
 @abstract      数据库队列的实体单例
 
 @note          该对象中的对象属性不可被多线程共享访问修改
 
 @result        返回数据库队列的单例对象
 */
+ (FMDatabaseQueue *)shareInstance;



+ (void)resetDatabase;


@end
