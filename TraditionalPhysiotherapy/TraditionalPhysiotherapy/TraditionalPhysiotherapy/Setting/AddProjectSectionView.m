//
//  AddProjectSectionView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/22.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "AddProjectSectionView.h"
#import "ProjectDao.h"

@implementation AddProjectSectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
    {
        return nil;
    }
    
    self.backgroundColor = [UIColor colorWithHexString:@"f0f3f3"];

    backView = [[UIView alloc] init];
    [self addSubview:backView];
    
    UIView *myNavView = [[UIView alloc] init];
    myNavView.backgroundColor = [UIColor colorWithHexString:@"4977f1"];
    [backView addSubview:myNavView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"添加项目大类";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:24.];
    [myNavView addSubview:titleLabel];

    nameTextFiled = [[UITextField alloc] init];
    nameTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    nameTextFiled.layer.borderColor = [UIColor lightGrayColor].CGColor;
    nameTextFiled.layer.borderWidth = 1.f;
    nameTextFiled.placeholder = @"输入名称:";
    [backView addSubview:nameTextFiled];
    

    // FSTextView
    textView = [FSTextView textView];
    textView.placeholder = @"输入描述";
    textView.borderWidth = 1.f;
    textView.borderColor = UIColor.lightGrayColor;
    textView.cornerRadius = 5.f;
    textView.canPerformAction = NO;
    [backView addSubview:textView];
    // 限制输入最大字符数.
    textView.maxLength = 400;
    // 添加输入改变Block回调.
    [textView addTextDidChangeHandler:^(FSTextView *textView) {
//        (textView.text.length < textView.maxLength) ? weakNoticeLabel.text = @"":NULL;
    }];
    // 添加到达最大限制Block回调.
    [textView addTextLengthDidMaxHandler:^(FSTextView *textView) {
//        weakNoticeLabel.text = [NSString stringWithFormat:@"最多限制输入%zi个字符", textView.maxLength];
    }];
    
    
    
    commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitButton addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [commitButton setBackgroundColor:[UIColor colorWithHexString:@"4eccff"]];
    [commitButton setTitle:@"确定" forState:UIControlStateNormal];
    commitButton.layer.cornerRadius = 10.;
    commitButton.clipsToBounds = YES;
    [backView addSubview:commitButton];
    
    cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleButton addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [cancleButton setBackgroundColor:[UIColor colorWithHexString:@"44e6cd"]];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    cancleButton.layer.cornerRadius = 10.;
    cancleButton.clipsToBounds = YES;
    [backView addSubview:cancleButton];
    
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
    
    [myNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(backView.mas_top);
        make.left.equalTo(backView.mas_left);
        make.right.equalTo(backView.mas_right);
        make.height.equalTo(70.);
    }];
    
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(myNavView.mas_top);
        make.right.equalTo(myNavView.mas_right);
        make.left.equalTo(myNavView.mas_left);
        make.height.equalTo(70.);
    }];
    
    [nameTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNavView.mas_bottom).offset(20.);
        make.right.equalTo(backView.mas_right).offset(-40.);
        make.left.equalTo(backView.mas_left).offset(20.);
        make.height.equalTo(40.);
        
    }];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(nameTextFiled.mas_bottom).offset(30.);
        make.right.equalTo(backView.mas_right).offset(-40.);
        make.left.equalTo(backView.mas_left).offset(20.);
        make.height.equalTo(200.);
    }];
    
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView.mas_centerX).offset(-20.);
        make.top.equalTo(textView.mas_bottom).offset(70.);
        make.left.equalTo(backView.mas_left).offset(20.);
        make.height.equalTo(50.);
        
    }];
    
    [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_centerX).offset(20.);
        make.top.equalTo(textView.mas_bottom).offset(70.);
        make.right.equalTo(backView.mas_right).offset(-20.);
        make.height.equalTo(50.);
        
    }];
    
    return self;
}

-(void)confirmBtnAction
{
//    MBProgressHUD *my_hud = [[MBProgressHUD alloc] initWithView:self];
//    my_hud.mode = MBProgressHUDModeText;
  
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if ([nameTextFiled.text isEqualToString:@""])
    {
//        my_hud.labelText = @"请输入名称";
//        [my_hud show:YES];
//        [self addSubview:my_hud];
//        [my_hud hide:YES afterDelay:3];
        [GlobalDataManager showHUDWithText:@"请输入名称" addTo:self dismissDelay:2. animated:YES];

        return;
    }
    if ([textView.text isEqualToString:@""])
    {
//        return;
    }
    [dic setObject:nameTextFiled.text forKey:@"sectionname"];
    [dic setObject:textView.text forKey:@"sectiondescription"];
    [[ProjectDao shareInstanceProjectDao] addNewSection:dic];
//    [EasyShowTextView showText:@"添加成功"];
//    my_hud.labelText = @"添加成功";
//    [my_hud show:YES];
//    [self addSubview:my_hud];
//    [my_hud hide:YES afterDelay:2];
    [GlobalDataManager showHUDWithText:@"添加成功" addTo:self dismissDelay:2. animated:YES];

    [self cancleBtnAction];
}



-(void)cancleBtnAction
{
    nameTextFiled.text = @"";
    textView.text = @"";
}



@end




