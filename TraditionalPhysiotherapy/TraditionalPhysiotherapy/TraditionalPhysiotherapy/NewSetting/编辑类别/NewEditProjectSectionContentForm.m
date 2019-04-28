//
//  NewEditProjectSectionContentForm.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2019/1/23.
//  Copyright © 2019 Gu GuiJun. All rights reserved.
//

#import "NewEditProjectSectionContentForm.h"
#import "ProjectSectionInfo.h"
#import "ProjectInfo.h"
#import "ProjectDao.h"

typedef void(^GenderSelectCompletion)(NSInteger index);

@interface NewEditProjectSectionContentForm ()
{
    NSMutableArray *sectionArray;
    NSMutableArray *sectionNameArray;
    NSString *currentSectionName;
    
    ProjectSectionInfo *currentSelectedSectionInfo;
}
@property (nonatomic, copy) GenderSelectCompletion genderSelectCompletion;

@end

@implementation NewEditProjectSectionContentForm
@synthesize projectInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    sectionArray= [[NSMutableArray alloc] init];
    sectionNameArray = [[NSMutableArray alloc] init];
    [self getAllSction];
    [self initFormUI];
}

-(void)getAllSction
{
    sectionArray = [[ProjectDao shareInstanceProjectDao] getAllSection];
    for (ProjectSectionInfo *info in sectionArray)
    {
        [sectionNameArray addObject:info.sectionname];
    }
}

- (void)initFormUI
{
    NSMutableArray *items = [NSMutableArray array];
    
    SWFormItem *name = SWFormItem_Add(@"类别名称", projectInfo.sectionname, SWFormItemTypeTextViewInput, YES, YES, UIKeyboardTypeDefault);
    name.placeholder = @"请输入名称";
    //    name.showLength = YES;
    name.defaultHeight = 240;
    [items addObject:name];
    
    
    SWFormItem *intro = SWFormItem_Add(@"类别描述", projectInfo.sectiondescription, SWFormItemTypeTextViewInput, YES, NO, UIKeyboardTypeDefault);
    intro.placeholder = @"请输入项目描述";
    intro.showLength = NO;
    [items addObject:intro];
    
    SWFormSectionItem *sectionItem = SWSectionItem(items);
    [self.mutableItems addObject:sectionItem];
    
    self.formTableView.tableFooterView = [self footerView];
    
    __weak typeof(self) weakSelf = self;
    
    // 确定按钮点击事件回调
    self.submitCompletion = ^{
        
        NSLog(@"提交按钮点击");
        // 这里只是简单描述校验逻辑，可根据自身需求封装数据校验逻辑
        [SWFormHandler sw_checkFormNullDataWithWithDatas:weakSelf.mutableItems success:^{

            __strong __typeof(weakSelf)strongSelf = weakSelf;

            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];

            [dic setObject:name.info forKey:@"sectionname"];
            [dic setObject:intro.info forKey:@"sectiondescription"];
            [dic setObject:strongSelf->projectInfo.sectionid forKey:@"uuidString"];

            [[ProjectDao shareInstanceProjectDao] updateSection:dic];
            
            NSLog(@"name === %@", name.info);
            
        } failure:^(NSString *error) {
            NSLog(@"error====%@",error);
        }];
    };
}


/**
 创建footer
 */
- (UIView *)footerView
{
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    submitBtn.bounds = CGRectMake(0, 0, 400, 80);
    submitBtn.center = footer.center;
    submitBtn.backgroundColor = [UIColor orangeColor];
    [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius = 10.;
    submitBtn.clipsToBounds = YES;
    [footer addSubview:submitBtn];
    
    return footer;
}


- (void)submitAction
{
    self.submitCompletion();
}

@end
