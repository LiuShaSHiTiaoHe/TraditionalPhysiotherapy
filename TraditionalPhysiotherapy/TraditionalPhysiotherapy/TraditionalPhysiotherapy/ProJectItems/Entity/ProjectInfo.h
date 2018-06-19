//
//  ProjectInfo.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/29.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectInfo : NSObject

@property(nonatomic,strong)NSString *projectid;
@property(nonatomic,strong)NSString *sectionid;
@property(nonatomic,strong)NSString *projectprice;
@property(nonatomic,strong)NSString *vipprice;
@property(nonatomic,strong)NSString *projectname;
@property(nonatomic,strong)NSString *projectdescription;
@property(nonatomic,strong)NSMutableArray *projectimages;
@property(nonatomic,strong)NSString *isdelete;

@end
