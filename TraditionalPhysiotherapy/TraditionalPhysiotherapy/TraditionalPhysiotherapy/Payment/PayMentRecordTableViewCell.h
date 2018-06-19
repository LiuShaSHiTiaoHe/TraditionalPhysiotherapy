//
//  PayMentRecordTableViewCell.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/4.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProjectInfo;

@interface PayMentRecordTableViewCell : UITableViewCell
{
    UILabel *nameLabel;
    UILabel *priceLabel;
    UILabel *countLabel;
    UILabel *technicianLabel;
}

-(void)setProjectListInfo:(NSMutableDictionary *)infoDic;


@end
