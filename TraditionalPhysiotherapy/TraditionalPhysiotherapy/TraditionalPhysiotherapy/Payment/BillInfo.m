//
//  BillInfo.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/5.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "BillInfo.h"

@implementation BillInfo

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.billid forKey:@"billid"];
    [encoder encodeObject:self.userid forKey:@"userid"];
    [encoder encodeObject:self.projectArray forKey:@"projectArray"];
    [encoder encodeObject:self.userSign forKey:@"userSign"];
    [encoder encodeObject:self.recordTime forKey:@"recordTime"];
    [encoder encodeObject:self.premoney forKey:@"premoney"];
    [encoder encodeObject:self.balance forKey:@"balance"];
    [encoder encodeObject:self.total forKey:@"total"];
    [encoder encodeObject:self.isOtherPay forKey:@"isOtherPay"];


    
}
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.billid = [decoder decodeObjectForKey:@"billid"];
        self.userid = [decoder decodeObjectForKey:@"userid"];
        self.projectArray = [decoder decodeObjectForKey:@"projectArray"];
        self.userSign = [decoder decodeObjectForKey:@"userSign"];
        self.recordTime = [decoder decodeObjectForKey:@"recordTime"];
        self.premoney = [decoder decodeObjectForKey:@"premoney"];
        self.balance = [decoder decodeObjectForKey:@"balance"];
        self.total = [decoder decodeObjectForKey:@"total"];
        self.isOtherPay = [decoder decodeObjectForKey:@"isOtherPay"];

    }
    
    return self;
}

@end
