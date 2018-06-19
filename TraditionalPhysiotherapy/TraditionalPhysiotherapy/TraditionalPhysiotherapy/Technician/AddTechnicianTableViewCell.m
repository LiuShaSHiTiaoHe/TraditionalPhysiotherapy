//
//  AddTechnicianTableViewCell.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/3/23.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "AddTechnicianTableViewCell.h"

@implementation AddTechnicianTableViewCell
@synthesize messageTextFiled;
@synthesize delegate;
//height 80
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self)
    {
        return nil;
    }
    iconImage = [[UIImageView alloc] init];
    [self addSubview:iconImage];
    
    nameLabel = [[UILabel alloc] init];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.textColor = [UIColor lightGrayColor];
    nameLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:nameLabel];
    
    messageTextFiled = [[UITextField alloc] init];
    messageTextFiled.borderStyle = UITextBorderStyleNone;
    messageTextFiled.textColor = [UIColor blackColor];
    messageTextFiled.textAlignment = NSTextAlignmentLeft;
    [self addSubview:messageTextFiled];
    [messageTextFiled addTarget:self action:@selector(textfieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(30.);
        make.height.equalTo(30.);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).equalTo(20.);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(iconImage.mas_right).equalTo(10.);
        make.height.equalTo(30.);
        make.width.equalTo(100.);
    }];
    
    [messageTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(nameLabel.mas_right).equalTo(10.);
        make.height.equalTo(30.);
        make.right.equalTo(self.mas_right).offset(-20.);
    }];
    
    return self;
}

#pragma mark - private method
- (void)textfieldTextDidChange:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentDidChanged:forIndexPath:)])
    {
        [self.delegate contentDidChanged:messageTextFiled.text forIndexPath:indexPath];
    }
}

-(void)setCellInfoImageName:(NSString *)imageName Name:(NSString *)name Message:(NSString *)message IndexPath:(NSInteger)index
{
    indexPath = index;
    iconImage.image = [UIImage imageNamed:imageName imageBundle:@"contact"];
    nameLabel.text = name;
    messageTextFiled.text = message;
    messageTextFiled.placeholder = [NSString stringWithFormat:@"请输入%@",name];
    if (index == 2 ||index == 6)
    {
        messageTextFiled.userInteractionEnabled = NO;
    }
    else
    {
        messageTextFiled.userInteractionEnabled = YES;
    }
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
