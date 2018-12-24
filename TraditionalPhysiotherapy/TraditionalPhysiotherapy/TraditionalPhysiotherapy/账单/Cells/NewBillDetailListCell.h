//
//  NewBillDetailListCell.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/17.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BillInfo;

@interface NewBillDetailListCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
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

NS_ASSUME_NONNULL_END
