//
//  NewEditProjectContentForm.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/12.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import "NewEditProjectContentForm.h"
#import "ProjectSectionInfo.h"
#import "ProjectInfo.h"
#import "ProjectDao.h"

typedef void(^GenderSelectCompletion)(NSInteger index);

@interface NewEditProjectContentForm ()
{
    NSMutableArray *imageArray;
    NSMutableArray *sectionArray;
    NSMutableArray *sectionNameArray;
    NSString *currentSectionName;
    
    ProjectSectionInfo *currentSelectedSectionInfo;
}
@property (nonatomic, copy) GenderSelectCompletion genderSelectCompletion;

@end

@implementation NewEditProjectContentForm
@synthesize projectInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    imageArray = [[NSMutableArray alloc] init];
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
        if ([info.sectionid isEqualToString:projectInfo.sectionid])
        {
            currentSectionName = info.sectionname;
        }
        [sectionNameArray addObject:info.sectionname];
    }
}

- (void)initFormUI
{
    NSMutableArray *items = [NSMutableArray array];
    
    SWFormItem *name = SWFormItem_Add(@"项目名称", projectInfo.projectname, SWFormItemTypeTextViewInput, YES, YES, UIKeyboardTypeDefault);
    name.placeholder = @"请输入名称";
    //    name.showLength = YES;
    name.defaultHeight = 240;
    [items addObject:name];
    
    
    SWFormItem *price = SWFormItem_Add(@"项目价格", projectInfo.projectprice, SWFormItemTypeTextViewInput, YES, YES, UIKeyboardTypeNumberPad);
    price.maxInputLength = 5;
    price.placeholder = @"请输入价格";
    price.itemUnitType = SWFormItemUnitTypeYuan;
    price.defaultHeight = 240;
    
    [items addObject:price];
    
    SWFormItem *vipPrice = SWFormItem_Add(@"会员价格", projectInfo.vipprice, SWFormItemTypeTextViewInput, YES, YES, UIKeyboardTypeNumberPad);
    vipPrice.maxInputLength = 5;
    vipPrice.placeholder = @"请输入会员价格";
    vipPrice.itemUnitType = SWFormItemUnitTypeYuan;
    vipPrice.defaultHeight = 240;
    
    [items addObject:vipPrice];
    
    
    
    SWFormItem *gender = SWFormItem_Add(@"项目类别", currentSectionName, SWFormItemTypeSelect, NO, YES, UIKeyboardTypeDefault);
    gender.itemSelectCompletion = ^(SWFormItem *item) {
        [self selectGenderWithItem:item];
    };
    [items addObject:gender];
    
    SWFormItem *intro = SWFormItem_Add(@"项目描述", projectInfo.projectdescription, SWFormItemTypeTextViewInput, YES, NO, UIKeyboardTypeDefault);
    intro.placeholder = @"请输入项目描述";
    intro.showLength = NO;
    [items addObject:intro];
    
    SWFormItem *image = SWFormItem_Add(@"项目图片", nil, SWFormItemTypeImage, YES, NO, UIKeyboardTypeDefault);
    NSMutableArray *tempImages = [NSMutableArray new];
    for (NSString *imagePath in projectInfo.projectimages)
    {
        NSString *filePath = [projectPicPath stringByAppendingPathComponent:imagePath]; //Add the file name
        NSLog(@"original filePath is %@",filePath);
//        [tempImages addObject:[GlobalDataManager resizeImageByvImage:[UIImage imageWithContentsOfFile:filePath]]];
        [tempImages addObject:[UIImage imageWithContentsOfFile:filePath]];

    }
    image.images = tempImages;
    [items addObject:image];
    
    SWFormSectionItem *sectionItem = SWSectionItem(items);
    [self.mutableItems addObject:sectionItem];
    
    self.formTableView.tableFooterView = [self footerView];
    
    __weak typeof(self) weakSelf = self;
    self.genderSelectCompletion = ^(NSInteger index) {
        
        __strong __typeof(weakSelf)strongSelf = weakSelf;

        if (index!=0)
        {
            gender.info = strongSelf->sectionNameArray[index-1];
            [weakSelf.formTableView reloadData];
        }
    };
    
    // 确定按钮点击事件回调
    self.submitCompletion = ^{
        
        NSLog(@"提交按钮点击");
        // 这里只是简单描述校验逻辑，可根据自身需求封装数据校验逻辑
        [SWFormHandler sw_checkFormNullDataWithWithDatas:weakSelf.mutableItems success:^{
            
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            
            long long time_stamp_now = [[NSDate date] timeIntervalSince1970];
            NSNumber *longlongNumber = [NSNumber numberWithLongLong:time_stamp_now];
            NSString *time_stamp_string = [longlongNumber stringValue];
            
            for (NSInteger i = 0;i< image.selectImages.count;i++)
            {
                UIImage *simage = image.selectImages[i];
                NSString *stringNameWithPNG = [NSString stringWithFormat:@"%@_%ld.png",time_stamp_string,i];
                [weakSelf savescanresultimage:simage imagename:[NSString stringWithFormat:@"%@_%ld",time_stamp_string,i]];
                [strongSelf->imageArray addObject:stringNameWithPNG];
                NSLog(@"stringNameWithPNG %@",stringNameWithPNG);
            }
            ProjectInfo *currentProjectInfo = [[ProjectInfo alloc] init];
            currentProjectInfo.projectid = strongSelf->projectInfo.projectid;
            currentProjectInfo.projectname = name.info;
            currentProjectInfo.projectdescription = intro.info;
            currentProjectInfo.projectprice = price.info;
            currentProjectInfo.vipprice = vipPrice.info;
            currentProjectInfo.isdelete = @"0";
            currentProjectInfo.projectimages = [[NSMutableArray alloc] init];
            [currentProjectInfo.projectimages addObjectsFromArray:strongSelf->imageArray];
            for (ProjectSectionInfo *info in strongSelf->sectionArray)
            {
                [strongSelf->sectionNameArray addObject:info.sectionname];
                if ([info.sectionname isEqualToString:gender.info])
                {
                    currentProjectInfo.sectionid = info.sectionid;
                    break;
                }
            }
            
            [[ProjectDao shareInstanceProjectDao] updateNewProject:currentProjectInfo];
            [GlobalDataManager showHUDWithText:@"添加成功" addTo:strongSelf.view dismissDelay:2. animated:YES];
            [strongSelf.navigationController popViewControllerAnimated:YES];

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

- (void)selectGenderWithItem:(SWFormItem *)item
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:[NSString stringWithFormat:@"请选择%@",item.title] delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
    for (int i = 0; i < sectionNameArray.count; i++)
    {
        [actionSheet addButtonWithTitle:sectionNameArray[i]];
    }
    actionSheet.tag = 10;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 10) {
        self.genderSelectCompletion(buttonIndex);
    }
}

- (void)submitAction
{
    self.submitCompletion();
}

#pragma mark 保存图片
-(NSString *)savescanresultimage:(UIImage *)resultimage imagename:(NSString *)strimagename
{
    NSString *stringNameWithPNG = [NSString stringWithFormat:@"%@.png",strimagename];
    NSData *imageData = UIImagePNGRepresentation(resultimage);
    NSString *filePath = [projectPicPath stringByAppendingPathComponent:stringNameWithPNG]; //Add the file name
    [imageData writeToFile:filePath atomically:YES];
    return filePath;
}

@end
