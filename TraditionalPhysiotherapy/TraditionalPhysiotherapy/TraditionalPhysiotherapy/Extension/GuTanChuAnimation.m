//
//  GuTanChuAnimation.m
//  弹出框
//
//  Created by GuGuiJun on 14/10/23.
//  Copyright (c) 2014年 GuGuiJun. All rights reserved.
//

#import "GuTanChuAnimation.h"


#define kDismissDuration 0.35
#define kViewMargin      20

@implementation GuTanChuAnimation
{
    //显示的遮罩层
    UIView *maskView_;
    
    UIView *contentView;//要弹出的View
    UIView *currentView;//二次弹出时，前一个View
    UIViewController *tempcontroller;
    
    
    SHOWTYPE showtype;
}

@synthesize delegate;

static GuTanChuAnimation *baseView = nil;

+ (instancetype)shareInstance {
    
    if (!baseView)
    {
        baseView = [self new];
    }
    return baseView;
    
}

-(void)showViewWithTitle:(UIView *)view fromViewCtrol :(UIViewController *)fromCtrol withframe : (CGRect)frame
{

    
    [self showView:view fromViewCtrol:fromCtrol withframe:frame withtype:DEFAULTSHOW];
    
}

-(void)showView:(UIView *)view withtype :(SHOWTYPE) type
{
    [self showView:view fromViewCtrol:ROOTCONTROLLER withframe:view.frame withtype:type];
}
-(void)showView:(UIView *)view fromViewCtrol :(UIViewController *)fromCtrol withframe:(CGRect)frame withtype :(SHOWTYPE) type
{
    
//    if (type == SHOWTWICE)
//    {
//        
//    }
//    else if (type == DEFAULTSHOW)
//    {
//        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideWithFade) object:nil];
//        [self hideWithFade];
//    }
    
    
    
    if (type == SHOWTWICE)
    {
        showtype = type;
        [self hideLastView];
        
    }
    else if (type == DEFAULTSHOW)
    {
        
        
        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideWithFade) object:nil];
        //[self cleanTheView];
        //[self removeLastView];
        
        if (!currentView)
        {
            currentView = view ;
        }
        else
        {
            if (![currentView isEqual:view])
            {
                [self removeLastView];
                currentView = view ;
            }
        }
    
        
    }

    
    if (view)
    {
        view.alpha = 1;
        //contentView = [[UIView alloc] init];
        contentView = view;
        //[contentView addSubview:view];
        contentView.frame = frame;
        contentView.alpha = 1;
        contentView.userInteractionEnabled = YES;
        maskView_ = [[UIView alloc] init];
        maskView_.backgroundColor = [UIColor blackColor];
        maskView_.alpha = 0.7;
        maskView_.frame = frame;
        
        [fromCtrol.view addSubview:maskView_];
        [fromCtrol.view addSubview:contentView];
        //[maskView_ release];
        
//        [[[[[UIApplication sharedApplication] delegate] window] viewForBaselineLayout] addSubview:maskView_];
//        [[[[[UIApplication sharedApplication] delegate] window] viewForBaselineLayout] addSubview:contentView];
    }
    tempcontroller = fromCtrol;
    
    [self viewshow];
    
}


-(void)viewshow
{
    [contentView.layer addAnimation:[self animationFadeInWithDuration:0.4 fromAlpha:0 toAlpha:1] forKey:@"fadeout"];
    
    [self addBounceAnimationToLayer:contentView.layer];
    [maskView_.layer addAnimation:[self animationFadeInWithDuration:0.4 fromAlpha:0.0 toAlpha:0.7] forKey:@"fadeout"];
}


//出现时的弹出动画
- (void)addBounceAnimationToLayer:(CALayer*)layer
{
    NSArray *frameValues = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 1)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.15, 1.15, 1)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)]];
    NSArray *frameTimes = @[@(0.0), @(0.5), @(0.9), @(1.0)];
    [layer addAnimation:[self animationWithValues:frameValues times:frameTimes duration:0.5] forKey:@"popup"];
}

- (CAKeyframeAnimation*)animationWithValues:(NSArray*)values times:(NSArray*)times duration:(CGFloat)duration
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = values;
    animation.keyTimes = times;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.removedOnCompletion = NO;
    animation.duration = duration;
    return animation;
}

- (CABasicAnimation *)animationFadeInWithDuration:(CGFloat)duration fromAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:fromAlpha];
    animation.toValue = [NSNumber numberWithFloat:toAlpha];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    return animation;
}


//取消时的消失动画
- (void)addDismissAnimationToLayer
{
    
    
    NSArray *frameValues = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1)],
                             
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.4, 0.4, 1.0)]];
    
    NSArray *frameTimes = @[@(0.0), @(0.3), @(0.8), @(1.0)];
    CAKeyframeAnimation *animation = [self animationWithValues:frameValues times:frameTimes duration:kDismissDuration];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.duration = 0.4;
    
    
    [contentView.layer addAnimation:[self animationFadeInWithDuration:0.4 fromAlpha:1 toAlpha:0.0] forKey:@"fadeout"];
    [contentView.layer addAnimation:animation forKey:@"popup"];
    
    
    [maskView_.layer addAnimation:[self animationFadeInWithDuration:0.5 fromAlpha:0.7 toAlpha:0.0] forKey:@"fadeout"];
    
    
    
    [self performSelector:@selector(hideWithFade) withObject:nil afterDelay:0.2];
}


-(void)setdismisstype :(SHOWTYPE)dismisstype
{
    showtype = dismisstype;
    [self addDismissAnimationToLayer];
}


- (void)hideWithFade
{
    if (showtype == SHOWTWICE)
    {
        showtype = 3;
        
        [maskView_ removeFromSuperview];
        maskView_ = nil;
        
        [contentView removeFromSuperview];
        //[contentView release];
        contentView = nil;
        
        [self showView:currentView fromViewCtrol:tempcontroller withframe:currentView.frame withtype:showtype];
        
    }
    else
    {
        if (currentView)
        {
            currentView = nil;
        }
        [maskView_ removeFromSuperview];
        maskView_ = nil;
        
        if (contentView) {
            [contentView removeFromSuperview];
            contentView = nil;
        }
        
        
        tempcontroller = nil;
    }
    
    if (delegate && [delegate respondsToSelector:@selector(viewRemoved)])
    {
        [delegate viewRemoved];
    }
}


//-(void)cleanTheView  //新页面弹出时，清除上次使用的页面
//{
//    if (maskView_)
//    {
//        maskView_ = nil;
//    }
//    if (contentView)
//    {
//        contentView = nil;
//    }
//
//    tempcontroller = nil;
//    
//}


-(void)removeLastView
{
    if (currentView)
    {
    }
    
    if (contentView)
    {
        [contentView removeFromSuperview];
        //[contentView release];
        contentView = nil;
        
    }
    if (maskView_)
    {
        [maskView_ removeFromSuperview];
        maskView_ = nil;
    }
    
    tempcontroller = nil;
}


-(void)dealloc
{
}

-(void)hideLastView
{

    if (contentView)
    {
        [contentView removeFromSuperview];
        //[contentView release];
        contentView = nil;

    }
    if (maskView_)
    {
        [maskView_ removeFromSuperview];
        maskView_ = nil;
    }
    
    tempcontroller = nil;
    
}


@end
