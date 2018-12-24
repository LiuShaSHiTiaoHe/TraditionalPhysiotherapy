//
//  NewContactDetailViewController.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/17.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@class ContactInfo;

@interface NewContactDetailViewController : UIViewController
{
    ContactInfo *currentInfo;
}
@property(nonatomic,strong)ContactInfo *currentInfo;

@end

NS_ASSUME_NONNULL_END
