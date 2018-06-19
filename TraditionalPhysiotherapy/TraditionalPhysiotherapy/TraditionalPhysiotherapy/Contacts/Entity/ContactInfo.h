//
//  ContactInfo.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 12/12/2017.
//  Copyright © 2017 Gu GuiJun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactInfo : NSObject

@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *userGender;
@property(nonatomic,strong)NSString *userAge;
@property(nonatomic,strong)NSString *userPhone;
@property(nonatomic,strong)NSString *userWechat;

@property(nonatomic,strong)NSString *userQQ;
@property(nonatomic,strong)NSString *userHeight;
@property(nonatomic,strong)NSString *userWeight;
@property(nonatomic,strong)NSString *userJob;
@property(nonatomic,strong)NSString *userBirthday;
@property(nonatomic,strong)NSString *userHoroscope;

@property(nonatomic,strong)NSString *userImage;
@property(nonatomic,strong)NSString *userAccountBalance;
@property(nonatomic,strong)NSString *isVIP;//1 YES  0 NO
@property(nonatomic,strong)NSString *remark;
@property(nonatomic,strong)NSString *isDelete;//1 YES 0 NO

@end
