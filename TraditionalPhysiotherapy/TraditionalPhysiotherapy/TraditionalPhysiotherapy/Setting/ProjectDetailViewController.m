//
//  ProjectDetailViewController.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/4/25.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "ProjectDetailViewController.h"

@interface ProjectDetailViewController ()

@end

@implementation ProjectDetailViewController
@synthesize currentInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    contentView = [[ProjectDetailView alloc] init];
    [contentView initUIwithInfo:currentInfo];
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
    
}

-(void)setCurrentInfo:(ProjectInfo *)currentinfo
{
    currentInfo = currentinfo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
