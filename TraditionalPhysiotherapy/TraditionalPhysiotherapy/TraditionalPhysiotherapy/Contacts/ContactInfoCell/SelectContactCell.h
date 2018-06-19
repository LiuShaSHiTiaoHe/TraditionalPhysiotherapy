//
//  SelectContactCell.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/4.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectContactCell : UITableViewCell
{
    UIImageView *headPic;
    UILabel *nameLabel;
    UIImageView *arrowImage;
    
}

-(void)configWithEntity:(NSDictionary *)entity;

-(void)configWithTechnicianEntity:(NSDictionary *)entity;


@end
