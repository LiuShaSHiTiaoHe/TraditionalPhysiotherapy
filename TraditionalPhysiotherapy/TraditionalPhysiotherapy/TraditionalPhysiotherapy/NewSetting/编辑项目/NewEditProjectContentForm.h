//
//  NewEditProjectContentForm.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/12.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWFormBaseController.h"
#import "ProjectInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewEditProjectContentForm : SWFormBaseController
{
    ProjectInfo *projectInfo;
}
@property(nonatomic,strong)ProjectInfo *projectInfo;

@end

NS_ASSUME_NONNULL_END
