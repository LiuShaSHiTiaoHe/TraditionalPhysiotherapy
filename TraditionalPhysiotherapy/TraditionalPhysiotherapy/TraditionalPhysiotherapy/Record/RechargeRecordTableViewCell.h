//
//  RechargeRecordTableViewCell.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/6/4.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RechargeRecordTableViewCell : UITableViewCell
{
    UILabel *timeLabel;    
    UILabel *numLabel;
}

@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *numLabel;


@end
