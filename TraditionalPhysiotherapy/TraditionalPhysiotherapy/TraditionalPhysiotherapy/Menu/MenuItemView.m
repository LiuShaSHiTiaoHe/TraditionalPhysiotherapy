//
//  MenuItemView.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/2.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "MenuItemView.h"
#import "OrderRecordInfo.h"

@implementation MenuItemView

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self)
    {
        backView = [UIView new];
        backView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];;
        [self addSubview:backView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [backView addGestureRecognizer:tap];
        
        contentView = [UIImageView new];
        contentView.userInteractionEnabled = YES;
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius = 20.;
        contentView.clipsToBounds = YES;
        [backView addSubview:contentView];
        
        
        _pagerView = [[TYCyclePagerView alloc]init];
        _pagerView.isInfiniteLoop = YES;
        _pagerView.dataSource = self;
        _pagerView.delegate = self;
        [_pagerView registerClass:[TYCyclePagerViewCell class] forCellWithReuseIdentifier:@"cellId"];
        [contentView addSubview:_pagerView];
        
        _pageControl = [[TYPageControl alloc]init];
        _pageControl.currentPageIndicatorSize = CGSizeMake(8, 8);
        _pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"8a8a8a"];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"1296db"];
        [_pagerView addSubview:_pageControl];
        
        nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont systemFontOfSize:26];
        [contentView addSubview:nameLabel];
        
        UIImageView *line = [[UIImageView alloc] init];
        line.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
        [contentView addSubview:line];
        
        desTextView = [[UITextView alloc] init];
        desTextView.font = [UIFont systemFontOfSize:20.];
        desTextView.textColor = [UIColor lightGrayColor];
        desTextView.userInteractionEnabled = NO;
        [contentView addSubview: desTextView];
        
        UIView *tabBackView = [[UIView alloc] init];
        tabBackView.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
        [contentView addSubview:tabBackView];
        
        priceLabel = [[UILabel alloc] init];
        priceLabel.font = [UIFont systemFontOfSize:22];
        priceLabel.textColor = [UIColor redColor];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        priceLabel.adjustsFontSizeToFitWidth = YES;
        [tabBackView addSubview:priceLabel];
        
        vippriceLabel= [[UILabel alloc] init];
        vippriceLabel.font = [UIFont systemFontOfSize:22];
        vippriceLabel.textColor = [UIColor redColor];
        vippriceLabel.textAlignment = NSTextAlignmentLeft;
        vippriceLabel.adjustsFontSizeToFitWidth = YES;
        [tabBackView addSubview:vippriceLabel];
        
        addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addButton setImage:[UIImage imageNamed:@"addRed" imageBundle:@"Menu"] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addtoCartAction) forControlEvents:UIControlEventTouchUpInside];
        [tabBackView addSubview: addButton];
        
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.width.equalTo(400);
            make.height.equalTo(600);
        }];
        
        [_pagerView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(contentView.mas_top);
            make.left.equalTo(contentView.mas_left);
            make.right.equalTo(contentView.mas_right);
            make.height.equalTo(300);
            
        }];
        
        
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_pagerView.mas_left);
            make.right.equalTo(_pagerView.mas_right);
            make.bottom.equalTo(_pagerView.mas_bottom);
            make.height.equalTo(16);
            
        }];

        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_pagerView.mas_bottom);
            make.left.equalTo(contentView.mas_left).offset(20);
            make.right.equalTo(contentView.mas_right);
            make.height.equalTo(60);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(nameLabel.mas_bottom).offset(5);
            make.left.equalTo(contentView.mas_left);
            make.right.equalTo(contentView.mas_right);
            make.height.equalTo(1);
        }];
        
        [desTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(line.mas_bottom).offset(5);
            make.left.equalTo(contentView.mas_left).offset(10.);
            make.right.equalTo(contentView.mas_right).offset(-10.);
            make.bottom.equalTo(contentView.mas_bottom).offset(-60);
        }];
        
        [tabBackView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.height.equalTo(80);
            make.left.equalTo(contentView.mas_left);
            make.right.equalTo(contentView.mas_right);
            make.bottom.equalTo(contentView.mas_bottom);
            
        }];
        
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(tabBackView.mas_top);
            make.left.equalTo(tabBackView.mas_left).offset(20.);
            make.right.equalTo(tabBackView.mas_right).offset(-100.);
            make.height.equalTo(40);
        }];
        
        [vippriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(priceLabel.mas_bottom);
            make.left.equalTo(tabBackView.mas_left).offset(20.);
            make.right.equalTo(tabBackView.mas_right).offset(-100.);
            make.height.equalTo(40);
        }];
        
        [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(tabBackView.mas_centerY);
            make.width.equalTo(50.);
            make.height.equalTo(50.);
            make.right.equalTo(contentView.mas_right).offset(-20);
        }];
        

    }
    return self;
}

-(void)setViewProjectInfo:(ProjectInfo *)info
{
    currentInfo = info;
    nameLabel.text = info.projectname;
    desTextView.text = info.projectdescription;
    priceLabel.text = [NSString stringWithFormat:@"非会员 ¥ %@",info.projectprice];
    vippriceLabel.text = [NSString stringWithFormat:@"会员 ¥ %@",info.vipprice];

    _datas = info.projectimages;
    _pageControl.numberOfPages = _datas.count;
    [_pagerView reloadData];
}



-(void)tapAction
{
    [self hideInController];
}

-(void)addtoCartAction
{
    OrderRecordInfo *orInfo = [OrderRecordInfo shareOrderRecordInfo];
    [orInfo configureOrder:currentInfo];
    
}



#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView
{
    return _datas.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index
{
    TYCyclePagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    NSString *stringNameWithPNG = _datas[index];
    NSString *filePath = [projectPicPath stringByAppendingPathComponent:stringNameWithPNG];
    cell.imageview.image = [UIImage imageWithContentsOfFile:filePath];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView
{
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame)*1, CGRectGetHeight(pageView.frame)*1);
    layout.itemSpacing = 5;
    layout.itemHorizontalCenter = YES;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}


@end
