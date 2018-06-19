//
//  AddTechnicianTableViewCell.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/23.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddTechnicianTableViewCellDelegate <NSObject>

@required
// cell 的contentTextField的文本发生改变时调用
- (void)contentDidChanged:(NSString *)text forIndexPath:(NSInteger)indexPath;

@end


@interface AddTechnicianTableViewCell : UITableViewCell
{
    UIImageView *iconImage;
    UILabel *nameLabel;
    UILabel *messageLabel;
    UITextField *messageTextFiled;
    NSInteger indexPath;
    
    __weak id<AddTechnicianTableViewCellDelegate>delegate;
}

@property (nonatomic,strong)UITextField *messageTextFiled;
@property (nonatomic,weak)id<AddTechnicianTableViewCellDelegate>delegate;


-(void)setCellInfoImageName:(NSString *)imageName Name:(NSString *)name Message:(NSString *)message IndexPath:(NSInteger)index;
@end
