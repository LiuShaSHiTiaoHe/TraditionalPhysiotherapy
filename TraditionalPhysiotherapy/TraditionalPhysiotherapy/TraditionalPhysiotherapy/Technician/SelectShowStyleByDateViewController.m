//
//  SelectShowStyleByDateViewController.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/31.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "SelectShowStyleByDateViewController.h"

@interface SelectShowStyleByDateViewController ()

@end

@implementation SelectShowStyleByDateViewController
@synthesize viewMode,delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.preferredContentSize = CGSizeMake(400, 300);
    contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 20.;
    contentView.clipsToBounds = YES;
    [self.view addSubview:contentView];
    
    datePicker = [[PGDatePicker alloc]init];
    if (viewMode)
    {
        datePicker.datePickerMode = PGDatePickerModeYear;

    }
    else
    {
        datePicker.datePickerMode = PGDatePickerModeYearAndMonth;

    }
    datePicker.delegate = self;
    [contentView addSubview:datePicker];
    
    cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setImage:[UIImage imageNamed:@"cancle_blue" imageBundle:@"contact"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:cancleBtn];
    
    commiteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commiteBtn addTarget:self action:@selector(commiteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [commiteBtn setBackgroundColor:[UIColor colorWithHexString:@"44e6cd"]];
    [commiteBtn setTitle:@"确定" forState:UIControlStateNormal];
    [contentView addSubview:commiteBtn];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).offset(160.);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(400.);
        make.height.equalTo(300.);
        
    }];
    
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(contentView.mas_left);
        make.right.equalTo(contentView.mas_right);
        make.top.equalTo(contentView.mas_top).offset(30.);
        make.height.equalTo(200);
        
    }];
    
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(contentView.mas_right).offset(-20.);
        make.top.equalTo(contentView.mas_top).offset(10.);
        make.width.equalTo(80/3);
        make.height.equalTo(80/3);
    }];
    
    
    [commiteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(contentView.mas_left);
        make.right.equalTo(contentView.mas_right);
        make.height.equalTo(60.);
        make.bottom.equalTo(contentView.mas_bottom);
    }];
    
}

-(void)commiteBtnAction
{
    [datePicker tapSelectedHandler];
    //    [self hideInController];
}

-(void)cancleBtnAction
{
    if (delegate)
    {
        [delegate dismissSelectShowStyleByDateView];
    }
}

- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents
{
    NSLog(@"dateComponents = %@", dateComponents);
    NSString *dateString = [NSString stringWithFormat:@"%ld-%ld-%ld",dateComponents.year,dateComponents.month,dateComponents.day];
    if (delegate)
    {
        [delegate selectedDay:dateString];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
