//
//  NewSettingViewController.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/10.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewSettingView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewSettingViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NewSettingView *contentView;
    MBProgressHUD *hud;
    MBProgressHUD *prepareHud;

}
@end

NS_ASSUME_NONNULL_END
