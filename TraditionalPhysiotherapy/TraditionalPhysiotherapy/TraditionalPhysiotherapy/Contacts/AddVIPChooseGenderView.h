//
//  AddVIPChooseGenderView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/11.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddVIPChooseGenderViewDelegate <NSObject>

-(void)selectedGender:(BOOL)chooseGender;//yes male no female

@end


@interface AddVIPChooseGenderView : UIView
{
    UIView *contentView;

    UIButton *maleButton;
    UIButton *femaleButton;
    
    UIButton *commiteBtn;
    UIButton *cancleBtn;
    
    __weak id<AddVIPChooseGenderViewDelegate>delegate;
    
}

@property(nonatomic,weak)id<AddVIPChooseGenderViewDelegate>delegate;

@end
