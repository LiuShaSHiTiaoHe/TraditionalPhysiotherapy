//
//  OrderRecordInfo.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/4.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactInfo.h"

@class ProjectInfo;

@interface OrderRecordInfo : NSObject

@property(nonatomic,strong)NSMutableArray *projectArray;
@property(nonatomic,strong)ContactInfo *contactInfo;
//@property(nonatomic,strong)NSMutableDictionary *projectDic;
@property(nonatomic,strong)NSMutableDictionary *technicianDic;

+ (OrderRecordInfo *)shareOrderRecordInfo;


-(void)configureOrder:(ProjectInfo *)info;

@end
