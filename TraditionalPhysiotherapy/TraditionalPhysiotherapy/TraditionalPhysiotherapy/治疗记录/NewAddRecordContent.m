//
//  NewAddRecordContent.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/18.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import "NewAddRecordContent.h"
#import "RecordInfo.h"
#import "ContactInfo.h"
#import "RecordDao.h"

@interface NewAddRecordContent ()<UIActionSheetDelegate>
{
    NSMutableArray *imageArray;
}

@end

@implementation NewAddRecordContent
@synthesize curentContactInfo;
@synthesize currentRecordInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    imageArray = [NSMutableArray new];
    [self initFormUI];
}

-(void)dealloc
{
    NSLog(@"dealloc ======== NewAddRecordContent ");
}

- (void)initFormUI
{
    NSMutableArray *items = [NSMutableArray array];
    
    SWFormItem *intro = SWFormItem_Add(@"描述", nil, SWFormItemTypeTextViewInput, YES, NO, UIKeyboardTypeDefault);
    intro.placeholder = @"请输入描述";
    intro.showLength = NO;
    [items addObject:intro];
    
    SWFormItem *image = SWFormItem_Add(@"图片", nil, SWFormItemTypeImage, YES, NO, UIKeyboardTypeDefault);
    image.images = @[];
    [items addObject:image];
    
    if (currentRecordInfo)
    {
        intro.info = currentRecordInfo.recordcontent;
        NSMutableArray *tempImages = [NSMutableArray new];
        for (NSString *imagePath in currentRecordInfo.recordimage)
        {
            NSString *filePath = [recordImagePath stringByAppendingPathComponent:imagePath]; //Add the file name
            [tempImages addObject:[GlobalDataManager resizeImageByvImage:[UIImage imageWithContentsOfFile:filePath]]];
        }
        image.images = tempImages;
    }
    
    SWFormSectionItem *sectionItem = SWSectionItem(items);
    [self.mutableItems addObject:sectionItem];
    
    self.formTableView.tableFooterView = [self footerView];
    
    __weak typeof(self) weakSelf = self;

    
    // 确定按钮点击事件回调
    self.submitCompletion = ^{
        
        // 这里只是简单描述校验逻辑，可根据自身需求封装数据校验逻辑
        [SWFormHandler sw_checkFormNullDataWithWithDatas:weakSelf.mutableItems success:^{
            
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            
            NSLog(@"selectImages === %@", image.selectImages);
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
            
            RecordInfo *recordinfo = [[RecordInfo alloc] init];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            recordinfo.recordtime = [dateFormatter stringFromDate:[NSDate date]];
            recordinfo.recordcontent = intro.info;
            recordinfo.recordimage = [[NSMutableArray alloc] init];
            [recordinfo.recordimage addObjectsFromArray:strongSelf ->imageArray];
            recordinfo.userid = strongSelf ->curentContactInfo.userId;
            
            if (strongSelf->currentRecordInfo)
            {
                recordinfo.recordid =strongSelf->currentRecordInfo.recordid;
                [[RecordDao shareInstanceRecordDao] editRecord:recordinfo];
//                [EasyShowTextView showText:@"修改成功"];
                [GlobalDataManager showHUDWithText:@"修改成功" addTo:strongSelf.view dismissDelay:2. animated:YES];
            }
            else
            {
                [[RecordDao shareInstanceRecordDao] addnewRecord:recordinfo];
//                [EasyShowTextView showText:@"添加成功"];
                [GlobalDataManager showHUDWithText:@"添加成功" addTo:strongSelf.view dismissDelay:2. animated:YES];

            }
            
            [strongSelf dismissViewControllerAnimated:YES completion:nil];
            
            
        } failure:^(NSString *error) {
            NSLog(@"error====%@",error);
            
            [EasyShowTextView showText:error];

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

#pragma mark 保存图片
-(NSString *)savescanresultimage:(UIImage *)resultimage imagename:(NSString *)strimagename
{
    NSString *stringNameWithPNG = [NSString stringWithFormat:@"%@.png",strimagename];
    NSData *imageData = UIImagePNGRepresentation(resultimage);
    NSString *filePath = [tempFilePath stringByAppendingPathComponent:stringNameWithPNG]; //Add the file name
    [imageData writeToFile:filePath atomically:YES];
    return filePath;
}


@end
