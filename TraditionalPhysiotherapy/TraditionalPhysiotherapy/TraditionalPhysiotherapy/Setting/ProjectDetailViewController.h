//
//  ProjectDetailViewController.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/4/25.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectDetailView.h"

@interface ProjectDetailViewController : UIViewController
{
    ProjectDetailView *contentView;
    ProjectInfo *currentInfo;
}
@property(nonatomic,strong)ProjectInfo *currentInfo;

@end
