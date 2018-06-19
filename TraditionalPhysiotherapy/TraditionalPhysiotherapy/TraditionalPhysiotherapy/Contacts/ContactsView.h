//
//  ContactsView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 11/12/2017.
//  Copyright © 2017 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContactsViewDelegate <NSObject>

-(void)ContactViewAdd;

@end

@interface ContactsView : UIView
{
//    UIImageView *titleImageView;
    UIView *myNavView;
    UILabel *titleLabel;
    UISearchBar *searchBar;
    UITableView *contactListView;
    UIView *contentScrollView;
    UIButton *addContactBtn;
    
    __unsafe_unretained id<ContactsViewDelegate>delegate;
}

@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UITableView *contactListView;
@property(nonatomic,strong)UIView *contentScrollView;
@property(nonatomic,strong)UIButton *addContactBtn;
@property(nonatomic,assign)id<ContactsViewDelegate>delegate;


-(void)isSearching:(BOOL)searchFlag;


@end
