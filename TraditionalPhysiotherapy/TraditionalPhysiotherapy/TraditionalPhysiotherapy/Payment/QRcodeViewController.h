//
//  QRcodeViewController.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/4/26.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QRcodeViewController : UIViewController
{
    UIImageView *aliPayImage;
    UIImageView *aliCode;
    
    UIImageView *weChatPayImage;
    UIImageView *weChatCode;
    UILabel *balanceText;
    
    UIButton *commitButton;
    UIButton *cancleButton;
    NSString *costString;
}

@property (nonatomic,copy)void(^commiteBlock)(void);
@property (nonatomic,strong)NSString *costString;
@end
