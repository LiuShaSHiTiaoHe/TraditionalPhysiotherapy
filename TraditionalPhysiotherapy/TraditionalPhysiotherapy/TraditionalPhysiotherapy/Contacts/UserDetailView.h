//
//  UserDetailView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 12/12/2017.
//  Copyright © 2017 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BalanceShortView.h"
#import "RecordListView.h"

@class ContactInfo;

@protocol UserDetailViewDelegate <NSObject>

-(void)editContactInfo:(ContactInfo *)info;

@end


@interface UserDetailView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BalanceShortViewDelegate,RecordListViewDelegate>
{
    UIImageView *backImageView;
    UIImageView *headImage;
    UILabel *userName;
    
    UICollectionView *infoCollectionView;
    ContactInfo *currentInfo;
    __unsafe_unretained id<UserDetailViewDelegate>delegate;
}
@property(nonatomic,assign)id<UserDetailViewDelegate>delegate;


-(void)setViewData:(ContactInfo *)info;

@end
