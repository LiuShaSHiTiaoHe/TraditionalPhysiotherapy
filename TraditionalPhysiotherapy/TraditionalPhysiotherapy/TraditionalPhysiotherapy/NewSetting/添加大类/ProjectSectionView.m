//
//  ProjectSectionView.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/10.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import "ProjectSectionView.h"
#import "ProjectDao.h"

@implementation ProjectSectionView
@synthesize backBlock;

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
    
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back" imageBundle:@"Project"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [myNavView addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"添加项目大类";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:30];
    [myNavView addSubview:titleLabel];
    
    nameTextFiled = [[UITextField alloc] init];
    nameTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    nameTextFiled.layer.borderColor = [UIColor lightGrayColor].CGColor;
    nameTextFiled.layer.borderWidth = 1.f;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:30];
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:@"输入名称:" attributes:dict];
    [nameTextFiled setAttributedPlaceholder:attribute];
    nameTextFiled.font = [UIFont systemFontOfSize:30];
    [backView addSubview:nameTextFiled];
    
    
    // FSTextView
    textView = [FSTextView textView];
    textView.placeholder = @"输入描述";
    textView.placeholderFont = [UIFont systemFontOfSize:30];
    textView.placeholderColor = [UIColor lightGrayColor];
    textView.borderWidth = 1.f;
    textView.borderColor = UIColor.lightGrayColor;
    textView.cornerRadius = 5.f;
    textView.canPerformAction = NO;
    textView.font = [UIFont systemFontOfSize:30];
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
    commitButton.titleLabel.font = [UIFont systemFontOfSize:30];
    commitButton.layer.cornerRadius = 10.;
    commitButton.clipsToBounds = YES;
    [backView addSubview:commitButton];
    
    cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleButton addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [cancleButton setBackgroundColor:[UIColor colorWithHexString:@"44e6cd"]];
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:30];
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
        
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(UIScreenWidth);
        make.height.equalTo(100.);
    }];
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(myNavView.mas_centerY).offset(20.);
        make.left.equalTo(myNavView.mas_left).offset(30.);
        make.width.height.equalTo(50);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNavView.mas_top).offset(40.);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(UIScreenWidth);
        make.height.equalTo(50.);
        
    }];
    
    [nameTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNavView.mas_bottom).offset(20.);
        make.right.equalTo(backView.mas_right).offset(-40.);
        make.left.equalTo(backView.mas_left).offset(20.);
        make.height.equalTo(80.);
        
    }];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(nameTextFiled.mas_bottom).offset(30.);
        make.right.equalTo(backView.mas_right).offset(-40.);
        make.left.equalTo(backView.mas_left).offset(20.);
        make.height.equalTo(300.);
    }];
    
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView.mas_centerX).offset(-20.);
        make.top.equalTo(textView.mas_bottom).offset(70.);
        make.left.equalTo(backView.mas_left).offset(20.);
        make.height.equalTo(100.);
        
    }];
    
    [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_centerX).offset(20.);
        make.top.equalTo(textView.mas_bottom).offset(70.);
        make.right.equalTo(backView.mas_right).offset(-20.);
        make.height.equalTo(100.);
        
    }];
    
    return self;
}

-(void)confirmBtnAction
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if ([nameTextFiled.text isEqualToString:@""])
    {
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
    [GlobalDataManager showHUDWithText:@"添加成功" addTo:self dismissDelay:2. animated:YES];
    [self cancleBtnAction];
}



-(void)cancleBtnAction
{
    [self backBtnAction];
}

-(void)backBtnAction
{
    backBlock();
}
@end
