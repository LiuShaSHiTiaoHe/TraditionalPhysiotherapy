//
//  ContactsViewController.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 11/12/2017.
//  Copyright © 2017 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsView.h"

@interface ContactsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,ContactsViewDelegate>
{
    ContactsView *contentView;
}


@end
