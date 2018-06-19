//
//  OrderRecordInfo.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/4.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "OrderRecordInfo.h"
#import "ProjectInfo.h"

static OrderRecordInfo *orderRecordInfo = nil;

@implementation OrderRecordInfo

+ (OrderRecordInfo *)shareOrderRecordInfo
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        orderRecordInfo = [[self alloc] init];
        orderRecordInfo.projectArray = [[NSMutableArray alloc] init];//Key(count  info  name technician)
        orderRecordInfo.contactInfo = [[ContactInfo alloc] init];
        orderRecordInfo.technicianDic = [[NSMutableDictionary alloc] init];
    });
    
    return orderRecordInfo;
}

-(void)configureOrder:(ProjectInfo *)info
{
    BOOL hasProject = NO;
    for (NSMutableDictionary *dic in _projectArray)
    {
        if ([[dic objectForKey:@"name"] isEqualToString:info.projectid])
        {
            NSInteger count = [[dic objectForKey:@"count"] integerValue];
            count ++;
            [dic setObject:[NSString stringWithFormat:@"%ld",count] forKey:@"count"];
            hasProject = YES;
            break;
        }
    }
    if (!hasProject)
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:info.projectid forKey:@"name"];
        [dic setObject:info forKey:@"info"];
        [dic setObject:@"1" forKey:@"count"];
        [dic setObject:@"" forKey:@"technician"];

        [_projectArray addObject:dic];
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CartProjectChanged object:nil];

}


@end
