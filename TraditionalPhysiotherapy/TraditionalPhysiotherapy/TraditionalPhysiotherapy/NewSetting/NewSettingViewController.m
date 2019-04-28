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
}

#pragma mark - UICollectionViewDelegate + UICollectionViewDelegate + UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
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
        
        default:
            break;
    }
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((UIScreenWidth-100)/3, (UIScreenWidth-100)/3 +50);
//    return CGSizeMake((UIScreenWidth-400)/3, 360);

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
        default:
            break;
    }
    
}

@end
