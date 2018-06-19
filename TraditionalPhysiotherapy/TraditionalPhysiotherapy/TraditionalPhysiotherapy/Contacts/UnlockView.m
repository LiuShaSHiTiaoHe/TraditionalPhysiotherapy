//
//  UnlockView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/6.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "UnlockView.h"

@implementation UnlockView
@synthesize tipsLabel,noticeLabel;
@synthesize lockView,delegate,processLabel,headPic,commiteButton;
@synthesize backButton,titleLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initui];
    }
    return self;
}
- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.backgroundColor = [UIColor colorWithHexString:@"e6e9ea"];
        [self initui];
    }
    return self;
}


-(void)initui
{
    self.backgroundColor = [UIColor colorWithHexString:@"eff0f1"];
    
    titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor colorWithHexString:@"4977f1"];
    [self addSubview:titleView];
    
    headPic = [[UIImageView alloc] init];
    //    headPic.frame = CGRectMake(0, 0,115*SizePer(),115*SizePer());
    //    headPic.center = CGPointMake(UIScreenWidth/2, autoYH(220));
    headPic.layer.cornerRadius = 60;
    [self addSubview:headPic];
    
    
    tipsLabel = [[UILabel alloc] init];
    tipsLabel.backgroundColor=[UIColor clearColor];
    tipsLabel.text = @"输入解锁图案";
    tipsLabel.textColor = [UIColor whiteColor];
    tipsLabel.font = [UIFont systemFontOfSize:22];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tipsLabel];
    


    processLabel = [[UILabel alloc] init];
    processLabel.textAlignment = NSTextAlignmentCenter;
    processLabel.font = [UIFont systemFontOfSize:16];
    processLabel.textColor = [UIColor grayColor];
    processLabel.text = @"请输入手势";
    [self addSubview:processLabel];
    
    
    lockView = [[GraphicLockView alloc] init];
    lockView.delegate = self;
    [self addSubview: lockView];
    //    lockView.center = CGPointMake(UIScreenWidth/2, UIScreenHeight/2 + 100);
    
    noticeLabel  = [[UILabel alloc] init];
//    noticeLabel.text = @"忘记密码请联系管理员:18678985399";
    noticeLabel.textColor = RGBColor(0, 126, 255);
    noticeLabel.textAlignment = NSTextAlignmentCenter;
    noticeLabel.font = [UIFont boldSystemFontOfSize:15];
    self.noticeLabel.userInteractionEnabled = YES;
    [self addSubview:noticeLabel];
    
    //    UIButton *abc = [UIButton buttonWithType:UIButtonTypeCustom];
    ////    [abc setFrame:CGRectMake(0, 0, UIScreenWidth - 80, 30)];
    //    [abc addTarget:self action:@selector(forgetLabPressed) forControlEvents:UIControlEventTouchUpInside];
    //    [noticeLabel addSubview:abc];
    
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(60);
        make.centerX.equalTo(self.mas_centerX);
        
    }];
    
    
    [headPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom).offset(20.);
        make.width.equalTo(115);
        make.height.equalTo(115);
        make.centerX.equalTo(self.mas_centerX);
        
    }];
    
    
    
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20.);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(40);
        make.centerX.equalTo(self.mas_centerX);
        
    }];
    
    [processLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headPic.mas_bottom).offset(5.);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(40);
        make.centerX.equalTo(self.mas_centerX);
        
    }];
    
    
    
    [lockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(processLabel.mas_bottom).offset(25.);
        make.width.equalTo(300);
        make.height.equalTo(300);
        make.centerX.equalTo(self.mas_centerX);
        
    }];
    
    
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom).offset(-65.);
        make.width.equalTo(200);
        make.height.equalTo(30);
        make.centerX.equalTo(self.mas_centerX);
        
    }];

    
}



- (void)forgetLabPressed
{
    if (delegate)
    {
        [delegate fogetGraphicPassword];
    }
}




-(void)resetLockView
{
    if (lockView)
    {
        [lockView removeFromSuperview];
        lockView = nil;
        
        lockView = [[GraphicLockView alloc] init];
        [self addSubview: lockView];
        
        
        [lockView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(processLabel.mas_bottom).offset(25.);
            make.width.equalTo(300);
            make.height.equalTo(300);
            make.centerX.equalTo(self.mas_centerX);
            
        }];
        
    }
}

#pragma mark 手势密码代理

-(void)beginTouch:(BOOL)isbegan
{
    
}


-(void)lockPath:(NSString *)path
{
    
    if ([[GlobalDataManager getGestureCode] isEqualToString:path])
    {
        [self removeFromSuperview];
    }
    else
    {
        MBProgressHUD *my_hud = [[MBProgressHUD alloc] initWithView:self];
        my_hud.mode = MBProgressHUDModeText;
        my_hud.labelText = @"手势密码错误,请重新绘制";
        [my_hud show:YES];
        [self addSubview:my_hud];
        [my_hud hide:YES afterDelay:2];
        
        [self resetLockView];
    }
    
    
    
    
    
}


@end
