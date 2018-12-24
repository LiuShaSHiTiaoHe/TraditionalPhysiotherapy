//
//  ProjectSectionViewController.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/10.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import "ProjectSectionViewController.h"

@interface ProjectSectionViewController ()

@end

@implementation ProjectSectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    contentView = [[ProjectSectionView alloc] init];
    __weak typeof(self) weakself = self;
    contentView.backBlock=^(){
        
        [weakself.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


@end
