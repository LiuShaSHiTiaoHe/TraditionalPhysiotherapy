//
//  InfoCollectionViewCell.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/12/12.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoCollectionViewCell : UICollectionViewCell
{
    UILabel *detailText;
    UILabel *infoText;
    
    UIImageView *hLine;
    UIImageView *vLine;
    
}

@property (nonatomic ,retain)UILabel *detailText;
@property (nonatomic ,retain)UILabel *infoText;

@property (nonatomic ,retain)UIImageView *hLine;;
@property (nonatomic ,retain)UIImageView *vLine;;


@end
