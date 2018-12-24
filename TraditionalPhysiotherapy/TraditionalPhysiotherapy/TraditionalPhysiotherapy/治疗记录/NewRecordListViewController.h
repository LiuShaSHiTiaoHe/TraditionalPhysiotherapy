//
//  NewRecordListViewController.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/17.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactInfo.h"
#import "RecordInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface NewRecordListViewController : UIViewController
{
    ContactInfo *curentInfo;
}
@property(nonatomic,strong)ContactInfo *curentInfo;
@end

NS_ASSUME_NONNULL_END
