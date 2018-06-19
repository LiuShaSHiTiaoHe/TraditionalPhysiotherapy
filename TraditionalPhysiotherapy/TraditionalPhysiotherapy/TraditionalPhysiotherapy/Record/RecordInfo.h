//
//  RecordInfo.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/5.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordInfo : NSObject

@property(nonatomic,strong)NSString *recordid;
@property(nonatomic,strong)NSString *userid;
@property(nonatomic,strong)NSString *recordcontent;
@property(nonatomic,strong)NSString *recordtime;
@property(nonatomic,strong)NSMutableArray *recordimage;

@end
