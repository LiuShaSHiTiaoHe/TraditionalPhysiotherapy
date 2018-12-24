//
//  MenuCollectionViewCell.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/16.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "MenuCollectionViewCell.h"


#import "ProjectDao.h"
#import "ProjectInfo.h"

#import "ShoppingCartTool.h"
#import "OrderRecordInfo.h"


@interface MenuCollectionViewCell ()



@end

@implementation MenuCollectionViewCell
@synthesize name,buttomRect;
@synthesize delegate;
@synthesize imageView;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        
        self.backgroundColor = [UIColor whiteColor];
//        self.backgroundColor = [UIColor colorWithHexString:@"4ddcff"];

        self.layer.cornerRadius = 10.;
        self.clipsToBounds = YES;
        
        imageView = [[UIImageView alloc] init];
//        imageView.layer.cornerRadius = 5.;
//        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        
        
        
        name = [[UILabel alloc] init];
        name.font = [UIFont systemFontOfSize:20];
        name.textAlignment = NSTextAlignmentLeft;
        [self addSubview:name];
        
        UIImageView *line = [[UIImageView alloc] init];
        line.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
        [self addSubview:line];
        
        UIView *tabBackView = [[UIView alloc] init];
//        tabBackView.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
        tabBackView.backgroundColor = [UIColor colorWithHexString:@"e2e5e5"];

        [self addSubview:tabBackView];
        
        
        priceLabel = [[UILabel alloc] init];
        priceLabel.font = [UIFont systemFontOfSize:14];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        priceLabel.textColor = [UIColor colorWithHexString:@"fe4365"];
        priceLabel.adjustsFontSizeToFitWidth = YES;
        [tabBackView addSubview:priceLabel];

        vippriceLabel = [[UILabel alloc] init];
        vippriceLabel.font = [UIFont systemFontOfSize:14];
        vippriceLabel.textAlignment = NSTextAlignmentLeft;
        vippriceLabel.textColor = [UIColor colorWithHexString:@"fe4365"];
        vippriceLabel.adjustsFontSizeToFitWidth = YES;
        [tabBackView addSubview:vippriceLabel];
        
        
        addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setImage:[UIImage imageNamed:@"addRed" imageBundle:@"Menu"] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addtoCartAction) forControlEvents:UIControlEventTouchUpInside];
        [tabBackView addSubview: addBtn];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
//            make.top.equalTo(self.mas_top).offset(10.);
//            make.left.equalTo(self.mas_left).offset(10.);
//            make.right.equalTo(self.mas_right).offset(-10.);
//            make.height.equalTo(240);
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(240);
        }];
        
        
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(imageView.mas_bottom).offset(10.);
            make.left.equalTo(self.mas_left).offset(10.);
            make.right.equalTo(self.mas_right).offset(-40.);
            make.height.equalTo(30);
        }];
        
//        [line mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.equalTo(name.mas_bottom).offset(5);
//            make.left.equalTo(self.mas_left).offset(10);
//            make.right.equalTo(self.mas_right).offset(-10);
//            make.height.equalTo(1);
//        }];
        
        
        [tabBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(60);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
            
        }];
        
        
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(tabBackView.mas_top);
            make.left.equalTo(self.mas_left).offset(10.);
            make.right.equalTo(self.mas_right).offset(-50.);
            make.height.equalTo(30);
        }];
        
        [vippriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(priceLabel.mas_bottom);
            make.left.equalTo(self.mas_left).offset(10.);
            make.right.equalTo(self.mas_right).offset(-50.);
            make.height.equalTo(30);
        }];
        
        
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(tabBackView.mas_centerY);
            make.width.equalTo(30.);
            make.height.equalTo(30.);
            make.right.equalTo(self.mas_right).offset(-20);
        }];
        
    }
    return self;
}

-(void)addtoCartAction
{
    if (delegate)
    {
        [delegate addToCart:currentInfo andImage:self];
    }
//    [ShoppingCartTool addToShoppingCartWithGoodsImage:[UIImage getImageViewWithView:self] startPoint:buttomRect endPoint:CGPointMake(UIScreenWidth-40, 30) completion:^(BOOL finished) {
//
//        OrderRecordInfo *orInfo = [OrderRecordInfo shareOrderRecordInfo];
//        [orInfo configureOrder:currentInfo];
//
////        [[OrderRecordInfo shareOrderRecordInfo].projectArray addObject:currentInfo];
//        
////        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
////        scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
////        scaleAnimation.toValue = [NSNumber numberWithFloat:0.7];
////        scaleAnimation.duration = 0.1;
////        scaleAnimation.repeatCount = 2; // 颤抖两次
////        scaleAnimation.autoreverses = YES;
////        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
////        [self.goodsNumLabel.layer addAnimation:scaleAnimation forKey:nil];
//    }];
}


-(void)setCellProjectInfo:(ProjectInfo *)info
{
    currentInfo = info;
    priceLabel.text = [NSString stringWithFormat:@"非会员 %@ ",info.projectprice];
    vippriceLabel.text = [NSString stringWithFormat:@"会员 %@ ",info.vipprice];

//    _datas = info.projectimages;
//    if (info.projectimages.count > 0)
//    {
//        NSString *filePath = [projectPicPath stringByAppendingPathComponent:[info.projectimages objectAtIndex:0]];
//        imageView.image = [UIImage imageWithContentsOfFile:filePath];
//    }
//    _pageControl.numberOfPages = _datas.count;
//    [_pagerView reloadData];
}

//-(void)setButtomRect:(CGPoint)buttomrect
//{
//    buttomRect = buttomrect;
//}





@end
