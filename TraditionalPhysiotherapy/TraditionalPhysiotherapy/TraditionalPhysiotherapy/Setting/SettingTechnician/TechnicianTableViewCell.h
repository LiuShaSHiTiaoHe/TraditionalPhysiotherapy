//
//  TechnicianTableViewCell.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/25.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TechnicianInfo;

@interface TechnicianTableViewCell : UITableViewCell
{
    UIImageView *headPic;
    UILabel *nameLabel;
    UIImageView *arrowImage;
    
}

-(void)configWithEntity:(TechnicianInfo *)entity;
@end
