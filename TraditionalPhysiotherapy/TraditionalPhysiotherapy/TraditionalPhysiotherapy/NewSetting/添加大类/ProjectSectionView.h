//
//  ProjectSectionView.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/12/10.
//  Copyright © 2018 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjectSectionView : UIView
{
    UIView *backView;
    UIButton *commitButton;
    UIButton *cancleButton;
    UIButton *backButton;
    UITextField *nameTextFiled;
    FSTextView *textView;
}

@property(nonatomic,strong) void (^backBlock)(void);

@end

NS_ASSUME_NONNULL_END
