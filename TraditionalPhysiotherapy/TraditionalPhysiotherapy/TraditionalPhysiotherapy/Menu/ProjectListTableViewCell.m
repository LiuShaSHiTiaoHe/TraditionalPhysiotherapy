//
//  ProjectListTableViewCell.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/4.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "ProjectListTableViewCell.h"

@implementation ProjectListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        nameLabel= [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:18];
        [nameLabel setTextColor:[UIColor darkGrayColor]];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:nameLabel];
        

        
        priceLabel= [[UILabel alloc] init];
        priceLabel.font = [UIFont systemFontOfSize:16];
        [priceLabel setTextColor:[UIColor lightGrayColor]];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        [priceLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:priceLabel];
        
        step = [[GNRCountStepper alloc]initWithFrame:CGRectZero];
        step.style = GNRCountStepperStyleShoppingCart;
        [self addSubview:step];

        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).offset(20);
            make.right.equalTo(self.mas_right).offset(-200);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(40);
            
        }];
        
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(nameLabel.mas_right);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(40);
            make.width.equalTo(60);
        }];
        
        [step mas_makeConstraints:^(MASConstraintMaker *make) {

            make.width.equalTo(100);
            make.right.equalTo(self.mas_right);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(40);
        }];
        
    }
    return self;
}

-(void)setProjectListInfo:(NSMutableDictionary *)infoDic
{
    ProjectInfo *info = [infoDic objectForKey:@"info"];
    nameLabel.text = info.projectname;
    priceLabel.text = [NSString stringWithFormat:@"%@元",info.projectprice];
    step.count = [[infoDic objectForKey:@"count"] integerValue];
    
    [step countChangedBlock:^(NSInteger count) {
  
        NSString *countStr = [NSString stringWithFormat:@"%ld",count];
        [infoDic setObject:countStr forKey:@"count"];
        NSLog(@"countChangedBlock %ld",count);
        [[NSNotificationCenter defaultCenter] postNotificationName:CartProjectChanged object:nil];

    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
