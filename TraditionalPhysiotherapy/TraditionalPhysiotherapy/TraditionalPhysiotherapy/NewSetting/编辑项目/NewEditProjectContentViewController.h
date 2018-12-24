//
//  NewEditProjectContentViewController.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/12.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectSectionInfo.h"
#import "ProjectInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface NewEditProjectContentViewController : UIViewController
{
    ProjectInfo *currentInfo;
}
@property(nonatomic,strong)ProjectInfo *currentInfo;

@end

NS_ASSUME_NONNULL_END
