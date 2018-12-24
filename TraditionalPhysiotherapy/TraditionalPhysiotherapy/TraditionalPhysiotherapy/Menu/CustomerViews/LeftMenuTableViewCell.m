//
//  LeftMenuTableViewCell.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/16.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "LeftMenuTableViewCell.h"

#define defaultColor rgba(253, 212, 49, 1)


@interface LeftMenuTableViewCell ()

//@property (nonatomic, strong) UIView *yellowView;

@end

@implementation LeftMenuTableViewCell
@synthesize name;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.backgroundColor = [UIColor colorWithHexString:@"fc9d9a"];

        name = [[UILabel alloc] init];
//        name.numberOfLines = 0;
//        name.font = [UIFont systemFontOfSize:20];
        name.font =[UIFont fontWithName:@"FZKTJW--GB1-0" size:23];
//        name.textColor = rgba(130, 130, 130, 1);
        name.textColor = [UIColor whiteColor];
        name.highlightedTextColor = [UIColor colorWithHexString:@"4977f1"];
        [self.contentView addSubview:name];
        
        line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithHexString:@"4977f1"];
        [self.contentView addSubview:line];
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.equalTo(40);

        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.mas_left);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.equalTo(60);
            make.width.equalTo(5);
        }];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
    self.contentView.backgroundColor = selected ? [UIColor colorWithHexString:@"323b4d"] : [UIColor clearColor];
    self.highlighted = selected;
    self.name.highlighted = selected;
    line.hidden = !selected;
}

@end
