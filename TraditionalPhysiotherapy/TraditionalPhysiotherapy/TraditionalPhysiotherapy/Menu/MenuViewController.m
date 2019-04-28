//
//  MenuViewController.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/16.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "MenuViewController.h"
#import "LJCollectionViewFlowLayout.h"
#import "LeftMenuTableViewCell.h"
#import "MenuCollectionViewCell.h"
#import "CollectionViewHeaderView.h"


#import "ProjectDao.h"
#import "ProjectSectionInfo.h"
#import "ProjectInfo.h"

#import "ShoppingCartTool.h"

#import "MenuItemView.h"
#import "OrderView.h"
#import "OrderRecordInfo.h"

@interface MenuViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,MenuCollectionViewCellDelegate,OrderViewDelegate>
{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
    NSMutableDictionary *projectImageDic;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *collectionDatas;
@property (nonatomic, strong) LJCollectionViewFlowLayout *flowLayout;

@end

@implementation MenuViewController
@synthesize cartButton;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    
    _selectIndex = 0;
    _isScrollDown = YES;
    projectImageDic = [NSMutableDictionary new];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blackColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.rowHeight = 80;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[LeftMenuTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Left];
    [self.view addSubview:self.tableView];

    self.tableView.backgroundColor= [UIColor colorWithHexString:@"3d455c"];

    
//    self.tableView.backgroundColor= [UIColor clearColor];
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tableViewBack" imageBundle:@"Menu"]];
//    self.tableView.backgroundView = imageView;
    
    
    
    _flowLayout = [[LJCollectionViewFlowLayout alloc] init];
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _flowLayout.minimumInteritemSpacing = 2;
    _flowLayout.minimumLineSpacing = 2;
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView setBackgroundColor:[UIColor colorWithHexString:@"edf5f5"]];

    //注册cell
    [_collectionView registerClass:[MenuCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier_CollectionView];
    //注册分区头标题
    [_collectionView registerClass:[CollectionViewHeaderView class]
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:@"CollectionViewHeaderView"];
    
    [self.view addSubview:self.collectionView];
    
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(titleImageView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.equalTo(300.);
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_tableView.mas_right);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(titleImageView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"liwushuo" ofType:@"json"];
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//    NSArray *categories = dict[@"data"][@"categories"];
//    for (NSDictionary *dict in categories)
//    {
//        CollectionCategoryModel *model =
//        [CollectionCategoryModel objectWithDictionary:dict];
//        [self.dataSource addObject:model];
//
//        NSMutableArray *datas = [NSMutableArray array];
//        for (SubCategoryModel *sModel in model.subcategories)
//        {
//            [datas addObject:sModel];
//        }
//        [self.collectionDatas addObject:datas];
//    }
    
    _dataSource = [NSMutableArray array];
    _collectionDatas = [NSMutableArray array];

//    [self.tableView reloadData];
//    [self.collectionView reloadData];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                animated:YES
                          scrollPosition:UITableViewScrollPositionNone];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCartNumber) name:CartProjectChanged object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self initData];
}

-(void)initUI
{
    titleImageView = [[UIImageView alloc] init];
    titleImageView.backgroundColor = [UIColor clearColor];
    titleImageView.userInteractionEnabled = YES;
    [self.view addSubview:titleImageView];
    
    
    UIView *leftBackView = [[UIView alloc] init];
    leftBackView.backgroundColor = [UIColor colorWithHexString:@"3d455c"];
    [titleImageView addSubview:leftBackView];
    
    UIImageView *logoView = [[UIImageView alloc] init];
    logoView.image = [UIImage imageNamed:@"logo" imageBundle:@"Menu"];
    [leftBackView addSubview:logoView];
    
    CGFloat lineWidth = SINGLE_LINE_WIDTH;
    CGFloat pixelAdjustOffset = SINGLE_LINE_WIDTH;
    //仅当要绘制的线宽为奇数像素时，绘制位置需要调整
    if (((int)(lineWidth * [UIScreen mainScreen].scale) + 1) % 2 == 0)
    {
        pixelAdjustOffset = SINGLE_LINE_ADJUST_OFFSET;
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
    //    xPos yPos
    line.frame = CGRectMake(0-pixelAdjustOffset, 68-pixelAdjustOffset, 300, lineWidth);
//    line.backgroundColor = [UIColor colorWithHexString:@"323b4d"];
    line.backgroundColor = [UIColor colorWithHexString:@"4977f1"];

    [leftBackView addSubview:line];

    
//    UILabel *logoTitle = [[UILabel alloc] init];
//    logoTitle.text = @"家传古方";
//    logoTitle.font = [UIFont systemFontOfSize:22];
//    logoTitle.textColor = [UIColor whiteColor];
//    [leftBackView addSubview:logoTitle];
    
    
    UIView *rightBackView = [[UIView alloc] init];
    rightBackView.backgroundColor = [UIColor colorWithHexString:@"4977f1"];
//    rightBackView.backgroundColor = [UIColor colorWithHexString:@"3d455c"];
    [titleImageView addSubview:rightBackView];
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"菜单";
    titleLabel.font = [UIFont systemFontOfSize:22];
    titleLabel.textColor = [UIColor whiteColor];
    [rightBackView addSubview:titleLabel];
    
    cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cartButton setImage:[UIImage imageNamed:@"cart" imageBundle:@"Menu"] forState:UIControlStateNormal];
    [cartButton addTarget:self action:@selector(addCartAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBackView addSubview:cartButton];
    
    cartNumberLabel = [[UILabel alloc] init];
    cartNumberLabel.backgroundColor = [UIColor redColor];
    cartNumberLabel.textColor = [UIColor whiteColor];
    cartNumberLabel.font = [UIFont systemFontOfSize:12];
    cartNumberLabel.layer.cornerRadius = 10.;
    cartNumberLabel.clipsToBounds = YES;
    cartNumberLabel.textAlignment = NSTextAlignmentCenter;
    [titleImageView addSubview:cartNumberLabel];
    cartNumberLabel.hidden = YES;

    [titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0.);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(70.);
        
    }];
    
    [leftBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(titleImageView.mas_top).offset(0.);
        make.width.equalTo(300.);
        make.left.equalTo(titleImageView.mas_left);
        make.height.equalTo(70.);
    }];
    
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(leftBackView.mas_top).offset(29.);
        make.width.equalTo(160);
        make.height.equalTo(32);
        make.left.equalTo(leftBackView.mas_left).offset(30.);
    }];
    
   
//    [logoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.centerY.equalTo(leftBackView.mas_centerY);
//        make.left.equalTo(leftBackView.mas_left).offset(30.);
//        make.height.equalTo(40);
//        make.right.equalTo(leftBackView.mas_right).offset(-10);
//    }];
    
    [rightBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(titleImageView.mas_top).offset(0.);
        make.right.equalTo(titleImageView.mas_right);
        make.left.equalTo(leftBackView.mas_right);
        make.height.equalTo(70.);
    }];
    
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightBackView.mas_top).offset(30.);
        make.centerX.equalTo(rightBackView.mas_centerX);
        make.width.equalTo(100.);
        make.height.equalTo(30.);
        
    }];
    
    [cartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightBackView.mas_right).offset(-50.);
        make.top.equalTo(rightBackView.mas_top).offset(30.);
        make.width.equalTo(30.);
        make.height.equalTo(30.);
        
    }];
    
    [cartNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(cartButton.mas_right);
        make.centerY.equalTo(cartButton.mas_top);
        make.width.equalTo(20);
        make.height.equalTo(20);

    }];
    
}

-(void)initData
{
    [_dataSource removeAllObjects];
    NSMutableArray *sectionArray = [[ProjectDao shareInstanceProjectDao] getAllSection];
    for (ProjectSectionInfo *info in sectionArray)
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        NSMutableArray *tempProjectArray = [[ProjectDao shareInstanceProjectDao] getProjectWithId:info.sectionid];
        NSMutableArray *projectArray = [[NSMutableArray alloc] init];

        for (ProjectInfo *info in tempProjectArray)
        {
            if ([info.isdelete isEqualToString:@"0"])
            {
                [self getProjectImage:info];
                [projectArray addObject:info];
            }
        }
        
        [dic setObject:projectArray forKey:@"ProjectArray"];
        [dic setObject:info forKey:@"SectionInfo"];
        [_dataSource addObject:dic];
    }
    [_tableView reloadData];
    [_collectionView reloadData];
}

-(void)getProjectImage:(ProjectInfo *)info
{
    if (info.projectimages.count > 0)
    {
        NSString *filePath = [projectPicPath stringByAppendingPathComponent:[info.projectimages objectAtIndex:0]];
//        UIImage *proimage = [UIImage imageWithContentsOfFile:filePath];
//        NSData *data = UIImageJPEGRepresentation(proimage, 0.4);
//        UIImage *resultImage = [GlobalDataManager resizeImageByvImage:[UIImage imageWithContentsOfFile:filePath]];
        UIImage *resultImage = [GlobalDataManager resizeImageByvImage:[UIImage imageWithContentsOfFile:filePath] withScale:0.5];

        [projectImageDic setObject:resultImage forKey:info.projectid];
    }
}

-(void)updateCartNumber
{
    OrderRecordInfo *info = [OrderRecordInfo shareOrderRecordInfo];
    if (info.projectArray.count == 0)
    {
        cartNumberLabel.hidden = YES;
        return;
    }
    else
    {
        cartNumberLabel.hidden = NO;

    }
    NSInteger count = 0;
    for (NSMutableDictionary *dic in info.projectArray)
    {
        count = count + [[dic objectForKey:@"count"] integerValue];
    }
    cartNumberLabel.text = [NSString stringWithFormat:@"%ld",count];
}

-(void)addCartAction
{
    OrderView *itemView = [[OrderView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    itemView.delegate = self;
    [itemView showInController:self preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationDropDown backgoundTapDismissEnable:YES];
    
//    menuVC = [[SelectShowStyleByDateViewController alloc] init];
//    menuVC.viewMode = viewMode;
//    menuVC.delegate = self;
//    menuVC.modalPresentationStyle = UIModalPresentationPopover;
//    menuVC.preferredContentSize = CGSizeMake(400, 300);
//
//    UIPopoverPresentationController *pop = menuVC.popoverPresentationController;
//    pop.sourceView = chooseDateBtn;
//    pop.sourceRect = CGRectMake(chooseDateBtn.frame.size.width / 2, chooseDateBtn.frame.size.height, 0, 0);
//    pop.permittedArrowDirections = UIPopoverArrowDirectionUp;
//    pop.backgroundColor = [UIColor whiteColor];
//    pop.delegate = self;
//    [self presentViewController:menuVC animated:YES completion:^{
//
//    }];
    
}

#pragma mark OrderViewDelegate
-(void)willGotoPayMentView
{
    self.tabBarController.selectedIndex = 2;
}

#pragma mark - UITableView DataSource Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left forIndexPath:indexPath];
//    CollectionCategoryModel *model = self.dataSource[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    NSMutableDictionary *dic = [_dataSource objectAtIndex:indexPath.row];
    ProjectSectionInfo *info = [dic objectForKey:@"SectionInfo"];
    cell.name.text = info.sectionname;
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndex = indexPath.row;
    
    // http://stackoverflow.com/questions/22100227/scroll-uicollectionview-to-section-header-view
    // 解决点击 TableView 后 CollectionView 的 Header 遮挡问题。
    [self scrollToTopOfSection:_selectIndex animated:YES];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]
                          atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - 解决点击 TableView 后 CollectionView 的 Header 遮挡问题

- (void)scrollToTopOfSection:(NSInteger)section animated:(BOOL)animated
{
    CGRect headerRect = [self frameForHeaderForSection:section];
    CGPoint topOfHeader = CGPointMake(0, headerRect.origin.y - _collectionView.contentInset.top);
    [self.collectionView setContentOffset:topOfHeader animated:animated];
}

- (CGRect)frameForHeaderForSection:(NSInteger)section
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    UICollectionViewLayoutAttributes *attributes = [self.collectionView.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
    return attributes.frame;
}

#pragma mark - UICollectionView DataSource Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSMutableArray *projectArray = [[_dataSource objectAtIndex:section] objectForKey:@"ProjectArray"];

    return projectArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_CollectionView forIndexPath:indexPath];
    
    NSMutableArray *projectArray = [[_dataSource objectAtIndex:indexPath.section] objectForKey:@"ProjectArray"];
    ProjectInfo *info = [projectArray objectAtIndex:indexPath.row];
    [cell setCellProjectInfo:info];
    cell.name.text = info.projectname;
    cell.delegate = self;
    UIImage *proImage = [projectImageDic objectForKey:info.projectid];
    if (proImage)
    {
        cell.imageView.image = proImage;
    }
//    cell.layer.borderColor=[UIColor blackColor].CGColor;
//    cell.layer.borderWidth=0.3;
//    CGRect rect = [cell convertRect:cell.bounds toView:[collectionView superview]];
//    CGPoint rect = [collectionView convertPoint:cell.center toView:self.view];
//    cell.buttomRect = rect;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((UIScreenWidth-300)/3-13,
                      350);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    { // header
        reuseIdentifier = @"CollectionViewHeaderView";
    }
    CollectionViewHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                        withReuseIdentifier:reuseIdentifier
                                                                               forIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
//        CollectionCategoryModel *model = self.dataSource[indexPath.section];
        NSMutableDictionary *dic = [_dataSource objectAtIndex:indexPath.section];
        ProjectSectionInfo *info = [dic objectForKey:@"SectionInfo"];
        view.title.text = info.sectionname;
    }
    return view;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(UIScreenWidth-300, 60);
}

// CollectionView分区标题即将展示
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    // 当前CollectionView滚动的方向向上，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (!_isScrollDown && (collectionView.dragging || collectionView.decelerating))
    {
        [self selectRowAtIndexPath:indexPath.section];
    }
}

// CollectionView分区标题展示结束
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 当前CollectionView滚动的方向向下，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (_isScrollDown && (collectionView.dragging || collectionView.decelerating))
    {
        [self selectRowAtIndexPath:indexPath.section + 1];
    }
}

// 当拖动CollectionView的时候，处理TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //    return UIEdgeInsetsMake(10, 10, 10, 10);
    return UIEdgeInsetsMake(0, 10, 20, 10);
    
}



//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuItemView *itemView = [[MenuItemView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    NSMutableArray *projectArray = [[_dataSource objectAtIndex:indexPath.section] objectForKey:@"ProjectArray"];
    ProjectInfo *info = [projectArray objectAtIndex:indexPath.row];
    [itemView setViewProjectInfo:info];
    [itemView showInController:self preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationScaleFade backgoundTapDismissEnable:YES];
}

#pragma mark - UIScrollView Delegate
// 标记一下CollectionView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static float lastOffsetY = 0;
    
    if (self.collectionView == scrollView)
    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark MenuCollectionViewCellDelegate
-(void)addToCart:(ProjectInfo *)info andImage:(MenuCollectionViewCell *)shortCut
{
    CGPoint rect = [_collectionView convertPoint:shortCut.center toView:self.view];
    [ShoppingCartTool addToShoppingCartWithGoodsImage:[UIImage getImageViewWithView:shortCut] startPoint:rect endPoint:CGPointMake(UIScreenWidth-40, 30) completion:^(BOOL finished) {
        
        OrderRecordInfo *orInfo = [OrderRecordInfo shareOrderRecordInfo];
        [orInfo configureOrder:info];
        
      
    }];
}










@end
