//
//  NewEditProjectSectionContentViewController.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2019/1/23.
//  Copyright © 2019 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectSectionInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface NewEditProjectSectionContentViewController : UIViewController
{
    ProjectSectionInfo *currentInfo;
}
@property(nonatomic,strong)ProjectSectionInfo *currentInfo;

@end

NS_ASSUME_NONNULL_END
