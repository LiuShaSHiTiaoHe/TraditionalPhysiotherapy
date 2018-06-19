//
//  UnlockView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/6.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GraphicLockView.h"
@protocol UnLockViewDelegate <NSObject>

-(void)fogetGraphicPassword;


@end

@interface UnlockView : UIView<GraphicLockViewDelegate>
{
    GraphicLockView *lockView;//九宫格
    
    UILabel *tipsLabel;
    UILabel *noticeLabel;
    
    UIButton *backButton;
    UIView *titleView;
    UILabel *titleLabel;
    
    
    UILabel *processLabel;
    UIImageView *headPic;
    
    __weak id<UnLockViewDelegate>delegate;
    
    
}


@property(nonatomic,retain)GraphicLockView *lockView;
@property(nonatomic,retain)UILabel *tipsLabel;
@property(nonatomic,retain)UILabel *noticeLabel;
@property(nonatomic,weak)id<UnLockViewDelegate>delegate;
@property(nonatomic,retain)UILabel *processLabel;
@property(nonatomic,retain)UIImageView *headPic;
@property(nonatomic,retain)UIButton *commiteButton;
@property(nonatomic,retain)UIButton *backButton;
@property(nonatomic,retain)UILabel *titleLabel;

-(void)resetLockView;

@end
