//
//  NewEditProjectSectionContentForm.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2019/1/23.
//  Copyright © 2019 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectSectionInfo.h"
#import "SWFormBaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewEditProjectSectionContentForm : SWFormBaseController
{
    ProjectSectionInfo *projectInfo;
}
@property(nonatomic,strong)ProjectSectionInfo *projectInfo;
@end

NS_ASSUME_NONNULL_END
