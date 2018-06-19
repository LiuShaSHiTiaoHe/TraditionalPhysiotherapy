//
//  ContactInfoTableViewCell.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/12/13.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContactInfo;

@interface ContactInfoTableViewCell : UITableViewCell
{
    UIImageView *headPic;
    UILabel *nameLabel;
    UIImageView *arrowImage;
    
}

-(void)configWithEntity:(ContactInfo *)entity;

@end
