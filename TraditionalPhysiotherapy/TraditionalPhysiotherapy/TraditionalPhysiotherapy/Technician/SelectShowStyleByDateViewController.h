//
//  SelectShowStyleByDateViewController.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/31.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGDatePicker.h"

@protocol SelectShowStyleByDateViewControllerDelegate <NSObject>

-(void)selectedDay:(NSString *)dateString;

-(void)dismissSelectShowStyleByDateView;

@end

@interface SelectShowStyleByDateViewController : UIViewController<PGDatePickerDelegate>
{
    UIView *contentView;
    UIDatePicker *picker;
    UIButton *commiteBtn;
    UIButton *cancleBtn;
    PGDatePicker *datePicker;
    BOOL viewMode;
    
    __weak id<SelectShowStyleByDateViewControllerDelegate>delegate;
}
@property(nonatomic,assign)BOOL viewMode;
@property(nonatomic,weak)id<SelectShowStyleByDateViewControllerDelegate>delegate;
//-(void)setViewMode:(BOOL)mode;///yes year  No year month

@end
