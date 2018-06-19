//
//  ProjectListTableViewCell.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/4.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNRCountStepper.h"
@class ProjectInfo;

@interface ProjectListTableViewCell : UITableViewCell
{
    UILabel *nameLabel;
    UILabel *priceLabel;
    GNRCountStepper *step;
    
}

-(void)setProjectListInfo:(NSMutableDictionary *)infoDic;

@end
