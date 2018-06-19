//
//  EditProjectViewController.h
//  TraditionalPhysiotherapy
//
//  Created by GuGuiJun on 2018/4/25.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditProject.h"

@interface EditProjectViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    EditProject *contentView;
    NSMutableArray *currentArray;

}
@end
