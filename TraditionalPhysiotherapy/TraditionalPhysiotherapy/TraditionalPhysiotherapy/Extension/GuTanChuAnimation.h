//
//  GuTanChuAnimation.h
//  弹出框
//
//  Created by GuGuiJun on 14/10/23.
//  Copyright (c) 2014年 GuGuiJun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    SHOWTWICE = 1,
    DEFAULTSHOW
}SHOWTYPE;

@protocol TanChuAnimationDelegate <NSObject>

@optional

-(void)viewRemoved;

@end

@interface GuTanChuAnimation : NSObject

-(void)showViewWithTitle:(UIView *)view fromViewCtrol :(UIViewController *)fromCtrol withframe : (CGRect)frame;

-(void)showView:(UIView *)view fromViewCtrol :(UIViewController *)fromCtrol withframe:(CGRect)frame withtype :(SHOWTYPE) type ;
-(void)showView:(UIView *)view withtype :(SHOWTYPE) type ;

+ (instancetype)shareInstance;

//取消时的消失动画
- (void)addDismissAnimationToLayer;

-(void)setdismisstype :(SHOWTYPE) dismisstype ;

@property(nonatomic,assign)id<TanChuAnimationDelegate>delegate;


@end
