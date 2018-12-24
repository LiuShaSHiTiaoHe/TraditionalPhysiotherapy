//
//  ContactsDao.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 12/12/2017.
//  Copyright © 2017 Gu GuiJun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ContactInfo;

@interface ContactsDao : NSObject

+(ContactsDao *)shareInstanceContactDao;

-(NSMutableArray *)getAllUser;

-(void)addnewUser:(ContactInfo *)userInfo;

-(void)updateUserBalance:(NSString *)userid andBalance:(NSString *)balance;

-(ContactInfo *)getUserInfo:(NSString *)userId;

-(void)deleteSelectedUserInfo:(NSString *)userId;
-(void)updateUserInfo:(ContactInfo *)userInfo;

@end
