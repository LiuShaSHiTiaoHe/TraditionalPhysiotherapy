//
//  SelectContactView.h
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/4.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContactInfo;

@protocol SelectContactViewDelegate <NSObject>

-(void)SelectContact:(ContactInfo *)contact;

@end

@interface SelectContactView : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UIView *backView;
    UIView *maskView;
    UIView *contentView;
    
    UIImageView *titleView;
    UILabel *titleLabel;
    
    UITextField *searchField;
    UIButton *searchCancleBtn;
    UIButton *cancleBtn;
    UIButton *commiteBtn;
    
    UITableView *infoTableView;
    NSMutableArray *contactArray;
    NSMutableArray *allPeopleArray;
    NSMutableArray *searchArray;
    
    NSString *searchString;
    __unsafe_unretained id<SelectContactViewDelegate>delegate;
}

@property(nonatomic,assign)id<SelectContactViewDelegate>delegate;

@end



