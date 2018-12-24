//
//  NewAddRecordContent.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/18.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWFormBaseController.h"
@class ContactInfo;
@class RecordInfo;
NS_ASSUME_NONNULL_BEGIN

@interface NewAddRecordContent : SWFormBaseController
{
    ContactInfo *curentContactInfo;
    RecordInfo *currentRecordInfo;
}
@property(nonatomic,strong)ContactInfo *curentContactInfo;
@property(nonatomic,strong)RecordInfo *currentRecordInfo;

@end

NS_ASSUME_NONNULL_END
