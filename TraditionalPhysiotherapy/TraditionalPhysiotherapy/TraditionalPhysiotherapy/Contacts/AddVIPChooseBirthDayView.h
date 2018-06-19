//
//  AddVIPChooseBirthDayView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/11.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGDatePicker.h"

@protocol AddVIPChooseBirthDayViewDelegate <NSObject>

-(void)selectedBirthDay:(NSString *)dateString;

@end


@interface AddVIPChooseBirthDayView : UIView<PGDatePickerDelegate>
{
    UIView *contentView;
    UIDatePicker *picker;
    UIButton *commiteBtn;
    UIButton *cancleBtn;
    PGDatePicker *datePicker;
    
    __weak id<AddVIPChooseBirthDayViewDelegate>delegate;
}

@property(nonatomic,weak)id<AddVIPChooseBirthDayViewDelegate>delegate;


@end



