//
//  SetGestureCodeView.m
//  Haier690iPad
//
//  Created by GuGuiJun on 16/1/11.
//  Copyright © 2016年 Haier. All rights reserved.
//

#import "SetGestureCodeView.h"

@implementation SetGestureCodeView

@synthesize tipsLabel,noticeLabel;
@synthesize lockView,processLabel,headPic,commiteButton;
@synthesize delegate;
@synthesize switchButton;
@synthesize switchStateLabel;
@synthesize backView;


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
    
    
    backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor clearColor];
    [self addSubview:backView];
    
    
    
    UIView *switchBackView = [[UIView alloc] init];
    switchBackView.backgroundColor = [UIColor whiteColor];
    switchBackView.layer.cornerRadius = 10.;
    switchBackView.clipsToBounds = YES;
    [self addSubview:switchBackView];
    
    switchStateLabel = [[UILabel alloc] init];
    switchStateLabel.textAlignment = NSTextAlignmentLeft;
    switchStateLabel.font = [UIFont systemFontOfSize:16.];
    switchStateLabel.textColor = [UIColor grayColor];
    [switchBackView addSubview:switchStateLabel];
    
    
    switchButton = [[UISwitch alloc] init];
    [switchBackView addSubview:switchButton];
    
    
    if ([GlobalDataManager getGestureCode].length > 0)
    {
//        switchStateLabel.text = @"关闭手势密码";
        [switchButton setOn:YES];
    }
    else
    {
//        switchStateLabel.text = @"启用手势密码";
        [switchButton setOn:NO];
        
    }
    
    switchStateLabel.text = @"手势密码";

    
    headPic = [[UIImageView alloc] init];
    headPic.layer.cornerRadius = 60;
    [backView addSubview:headPic];
    


    
    
    processLabel = [[UILabel alloc] init];
    processLabel.textAlignment = NSTextAlignmentCenter;
    processLabel.font = [UIFont systemFontOfSize:16];
    processLabel.textColor = [UIColor grayColor];
    processLabel.text = @"绘制手势密码";
    [backView addSubview:processLabel];
    
    
    
    lockView = [[GraphicLockView alloc] init];
    [backView addSubview: lockView];
    
    
    
    commiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [commiteButton setBackgroundImage:[UIImage imageNamed:@"button4"] forState:UIControlStateNormal];
    [commiteButton setTitle:@"确认保存手势" forState:UIControlStateNormal];
    commiteButton.layer.cornerRadius = 10.;
    commiteButton.clipsToBounds = YES;
    [commiteButton setBackgroundColor:[UIColor colorWithHexString:@"4eccff"]];
    [commiteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backView addSubview:commiteButton];
    
    commiteButton.hidden = YES;
    

    
    [switchBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(30.);
        make.left.equalTo(self.mas_left).offset(30.);
        make.width.equalTo(self.mas_width).offset(-60.);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(60.);
    }];
    
    [switchStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(switchBackView.mas_top).offset(15.);
        make.left.equalTo(switchBackView.mas_left).offset(40.);
        make.width.equalTo(self.mas_width).offset(-100.);
        make.height.equalTo(30.);
    }];
    
    [switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(switchBackView.mas_top).offset(15.);
        make.right.equalTo(switchBackView.mas_right).offset(-10.);
        make.width.equalTo(60.);
        make.height.equalTo(30.);
    }];

    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(switchBackView.mas_bottom).offset(15.);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(self.mas_width);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
    
    
    
    [headPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(20.);
        make.width.equalTo(115);
        make.height.equalTo(115);
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
    
    
    [commiteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_bottom).offset(-75.);
        make.width.equalTo(200);
        make.height.equalTo(50);
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
        [backView addSubview: lockView];
        
        
        [lockView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(processLabel.mas_bottom).offset(25.);
            make.width.equalTo(300);
            make.height.equalTo(300);
            make.centerX.equalTo(self.mas_centerX);
            
        }];
    }
}



@end
