//
//  BillDetailListCell.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/5.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BillInfo;

@interface BillDetailListCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *timeLabel;
    UIImageView *timeImage;
    UILabel *totalPrice;
    UILabel *detialLabel;
    UITableView *detailList;
    UILabel *balanceLabel;
    UIImageView *signImageView;
    UILabel *otherPayLabel;

    NSMutableArray *curentArray;
}

-(void)billDetailListCellSetInfo:(BillInfo *)info;

@end
