//
//  NewSettingViewController.m
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/10.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import "NewSettingViewController.h"
#import "SettingCollectionViewCell.h"

#import "ProjectSectionViewController.h"
#import "NewAddProjectViewController.h"
#import "NewEditProjectController.h"
#import "NewTechnicianSetViewController.h"
#import "NewEditProjectSectionController.h"
#import "ZipArchive.h"
@interface NewSettingViewController ()

@end

@implementation NewSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    contentView = [[NewSettingView alloc] init];
    contentView.infoCollectionView.dataSource = self;
    contentView.infoCollectionView.delegate = self;
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
//    prepareHud = [[MBProgressHUD alloc] initWithView:self.view];
//    // Set the text mode to show only text.
//    prepareHud.mode = MBProgressHUDModeText;
//    prepareHud.label.text = @"数据准备中...";
//    prepareHud.label.textColor = [UIColor whiteColor];
//    prepareHud.label.font = [UIFont systemFontOfSize:33];
//    prepareHud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    prepareHud.userInteractionEnabled = NO;
//    prepareHud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
//    // Move to bottm center.
//    prepareHud.minSize = CGSizeMake(200., 100.);
}

#pragma mark - UICollectionViewDelegate + UICollectionViewDelegate + UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * infoCollectionViewCellID = @"SettingCollectionViewCell";
    SettingCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:infoCollectionViewCellID forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[SettingCollectionViewCell alloc] init];
    }
 
    switch (indexPath.row)
    {
        case 0:
        {
            cell.nameLabel.text  =@"添加类别";
            cell.imageView.image = [UIImage imageNamed:@"111" imageBundle:@"Menu"];
        }
            break;
//        case 1:
//        {
//            cell.nameLabel.text  =@"编辑类别";
//            cell.imageView.image = [UIImage imageNamed:@"333" imageBundle:@"Menu"];
//        }
//            break;
        case 1:
        {
            cell.nameLabel.text  =@"添加项目";
            cell.imageView.image = [UIImage imageNamed:@"222" imageBundle:@"Menu"];
        }
            break;
        case 2:
        {
            cell.nameLabel.text  =@"编辑项目";
            cell.imageView.image = [UIImage imageNamed:@"333" imageBundle:@"Menu"];
        }
            break;
        case 3:
        {
            cell.nameLabel.text  =@"技师管理";
            cell.imageView.image = [UIImage imageNamed:@"123" imageBundle:@"Menu"];
        }
            break;
        case 4:
        {
            cell.nameLabel.text  =@"文件备份";
            cell.imageView.image = [UIImage imageNamed:@"beifen" imageBundle:@"Menu"];
        }
            break;
        default:
            break;
    }
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    return CGSizeMake((UIScreenWidth-100)/3, (UIScreenWidth-100)/3 +30);
    return CGSizeMake(300, 350);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 20, 10, 20);
//    return UIEdgeInsetsMake(30, 100, 30, 100);

}

//每个cell的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 30.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 40.0f;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row)
    {
        case 0:
        {
            ProjectSectionViewController *temp = [[ProjectSectionViewController alloc] init];
            [self.navigationController pushViewController:temp animated:YES];
        }
            break;
//        case 1:
//        {
//            NewEditProjectSectionController *temp = [[NewEditProjectSectionController alloc] init];
//            [self.navigationController pushViewController:temp animated:YES];
//        }
//            break;
        case 1:
        {
            NewAddProjectViewController *temp = [[NewAddProjectViewController alloc] init];
            [self.navigationController pushViewController:temp animated:YES];
        }
            break;
        case 2:
        {
            NewEditProjectController *temp = [[NewEditProjectController alloc] init];
            [self.navigationController pushViewController:temp animated:YES];
        }
            break;
        case 3:
        {
            NewTechnicianSetViewController *temp = [[NewTechnicianSetViewController alloc] init];
            [self.navigationController pushViewController:temp animated:YES];
        }
            break;
        case 4:
        {
            [self resizeRecordImage];
        }
            break;
        default:
            break;
    }
    
}

-(void)resizeRecordImage
{
    [GlobalDataManager showHUDWithText:@"数据准备中..." addTo:self.view dismissDelay:3. animated:YES];

    
    dispatch_queue_t concurrencyQueue = dispatch_queue_create("resizeRecordImage-queue",
                                                              DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrencyQueue, ^{
        // 这里放异步执行任务代码
        // 工程目录
        NSString *BASE_PATH = recordImagePath;
        NSFileManager *myFileManager = [NSFileManager defaultManager];
        NSDirectoryEnumerator *myDirectoryEnumerator = [myFileManager enumeratorAtPath:BASE_PATH];
        
        BOOL isDir = NO;
        BOOL isExist = NO;
        NSMutableArray *imageArray = [NSMutableArray new];
        //列举目录内容，可以遍历子目录
        for (NSString *path in myDirectoryEnumerator.allObjects)
        {
            isExist = [myFileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/%@", BASE_PATH, path] isDirectory:&isDir];
            if (isDir) {
                NSLog(@"%@", path);    // 目录路径
            } else {
                NSLog(@"%@", path);    // 文件路径
                CGFloat filesize = [[NSFileManager defaultManager] attributesOfItemAtPath:[NSString stringWithFormat:@"%@/%@", BASE_PATH, path] error:nil].fileSize;
                CGFloat realSize =filesize/1000/1000;
                NSLog(@"filesize %f MB",realSize);
                if (realSize > 3.)
                {
                    [imageArray addObject:path];
                }
            }
        }
        
        if (imageArray.count > 0)
        {
            for (NSString *path in imageArray)
            {
                NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", BASE_PATH, path]];
                UIImage *image = [UIImage imageWithData:data];
                UIImage *resizedImage = [GlobalDataManager resizeImageByvImage:image withScale:0.3];
                NSData *imageData = UIImageJPEGRepresentation(resizedImage, 1.);
                [imageData writeToFile:[NSString stringWithFormat:@"%@/%@", BASE_PATH, path] atomically:YES];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self fileUploadBackUp];

        });
        
    });
}

-(void)fileUploadBackUp
{
    
    NSString *imageZipPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
                              stringByAppendingPathComponent: @"Images.zip"];
    [SSZipArchive createZipFileAtPath:imageZipPath withContentsOfDirectory:userDocumentPath];
    NSString *databasePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
                    stringByAppendingPathComponent: @"sqlcipher.db"];
    NSString *zipPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
                         stringByAppendingPathComponent: @"jiachuangufa.zip"];
    [SSZipArchive createZipFileAtPath:zipPath withFilesAtPaths:@[imageZipPath,databasePath]];
    //获取要保存的数据
//    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cloud" ofType:@"png"]];
    NSData *data = [NSData dataWithContentsOfFile:zipPath];
    //用数据创建文件
    AVFile *file = [AVFile fileWithData:data name:@"jiachuangufa.zip"];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    hud.label.text = @"正在备份";
    [file uploadWithProgress:^(NSInteger percentDone) {
        // 上传进度数据，percentDone 介于 0 和 100。
        NSLog(@"backUp percent is %ld",(long)percentDone);
//        hud.progress = percentDone/100;
        [hud setProgress:percentDone/100.];
 
    } completionHandler:^(BOOL succeeded, NSError *error) {
        // 成功或失败处理...
        [hud hideAnimated:YES];

        if (succeeded)
        {
            [GlobalDataManager showHUDWithText:@"备份成功" addTo:self.view dismissDelay:2. animated:YES];
        }
        else
        {
            [GlobalDataManager showHUDWithText:@"备份失败，请重新备份" addTo:self.view dismissDelay:2. animated:YES];
        }
    }];

}

@end
