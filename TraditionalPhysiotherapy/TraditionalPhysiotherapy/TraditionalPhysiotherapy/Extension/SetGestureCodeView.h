//
//  SetGestureCodeView.h
//  Haier690iPad
//
//  Created by GuGuiJun on 16/1/11.
//  Copyright © 2016年 Haier. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GraphicLockView.h"

@protocol SetGestureCodeViewDelegate <NSObject>

-(void)fogetGraphicPassword;



@end


@interface SetGestureCodeView : UIView
{
    GraphicLockView *lockView;//九宫格
    
    UILabel *tipsLabel;
    UILabel *noticeLabel;
    UILabel *processLabel;
    

    UIImageView *headPic;
    
    UIButton *commiteButton;
    __weak id<SetGestureCodeViewDelegate>delegate;
    
    UIView *backView;
    UISwitch *switchButton;
    UILabel *switchStateLabel;
}


@property(nonatomic,retain)GraphicLockView *lockView;
@property(nonatomic,retain)UILabel *tipsLabel;
@property(nonatomic,retain)UILabel *noticeLabel;
@property(nonatomic,retain)UILabel *processLabel;

@property(nonatomic,retain)UIImageView *headPic;
@property(nonatomic,retain)UIButton *commiteButton;

@property(nonatomic,weak)id<SetGestureCodeViewDelegate>delegate;
@property(nonatomic,retain) UISwitch *switchButton;
@property(nonatomic,retain)UILabel *switchStateLabel;
@property(nonatomic,retain)UIView *backView;
-(void)resetLockView;



@end
