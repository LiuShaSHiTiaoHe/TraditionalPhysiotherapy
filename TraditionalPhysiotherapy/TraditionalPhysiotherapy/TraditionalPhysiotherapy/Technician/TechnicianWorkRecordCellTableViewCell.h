//
//  TechnicianWorkRecordCellTableViewCell.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/31.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TechnicianWorkRecordCellTableViewCell : UITableViewCell
{
    UILabel *timeLabel;
    UILabel *projectNameLabel;
    UILabel *priceLabel;
    UILabel *userLabel;
}

-(void)setProjectListInfo:(NSDictionary *)infoDic;

@end
