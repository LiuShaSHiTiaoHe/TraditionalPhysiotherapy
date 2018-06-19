//
//  BillDetailPayMentCell.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/4/26.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillDetailPayMentCell : UITableViewCell
{
    UILabel *nameLabel;
    UILabel *priceLabel;
    UILabel *countLabel;
    UILabel *technicianLabel;
}

-(void)setProjectListInfo:(NSMutableDictionary *)infoDic;
@end
