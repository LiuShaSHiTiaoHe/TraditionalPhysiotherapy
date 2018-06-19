//
//  BillDetailListCell.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/2/5.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "BillDetailListCell.h"
#import "PayMentRecordTableViewCell.h"
#import "ProjectInfo.h"
#import "BillInfo.h"
#import "BillDetailPayMentCell.h"

@implementation BillDetailListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        timeLabel = [[UILabel alloc] init];
        timeLabel.font = [UIFont systemFontOfSize:18];
        timeLabel.numberOfLines = 0;
//        timeLabel.textColor = [UIColor colorWithHexString:@"4977f1"];
        timeLabel.textColor = [UIColor lightGrayColor];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:timeLabel];
        
        timeImage = [[UIImageView alloc] init];
//        timeImage.image = [UIImage imageNamed:@"time_axis" imageBundle:@"payment"];
        [self addSubview:timeImage];
        
        UIView *dot = [UIView new];
//        dot.backgroundColor = [UIColor colorWithHexString:@"4977f1"];
        dot.backgroundColor = [UIColor colorWithHexString:@"83af9b"];

        dot.layer.cornerRadius = 14/2;
        dot.clipsToBounds = YES;
        [timeImage addSubview:dot];
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor colorWithHexString:@"83af9b"];
        [timeImage addSubview:line];
        
        totalPrice = [[UILabel alloc] init];
        totalPrice.font = [UIFont systemFontOfSize:18];
        totalPrice.textColor = [UIColor colorWithHexString:@"ffad5b"];
        totalPrice.textAlignment = NSTextAlignmentLeft;
        [self addSubview:totalPrice];
        
        otherPayLabel= [[UILabel alloc] init];
        otherPayLabel.font = [UIFont systemFontOfSize:16];
        otherPayLabel.textColor = [UIColor colorWithHexString:@"3edad4"];
        otherPayLabel.textAlignment = NSTextAlignmentRight;
        otherPayLabel.text = @"其他方式付款";
        [self addSubview:otherPayLabel];
        
        
        detialLabel = [[UILabel alloc] init];
        detialLabel.font = [UIFont systemFontOfSize:16];
        detialLabel.textColor = [UIColor lightGrayColor];
        detialLabel.text = @"账单明细";
        detialLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:detialLabel];
        
        detailList = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        detailList.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        detailList.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        detailList.dataSource = self;
        detailList.delegate = self;
        [self addSubview:detailList];
        
        balanceLabel = [[UILabel alloc] init];
        balanceLabel.font = [UIFont systemFontOfSize:16];
        balanceLabel.textColor = [UIColor colorWithHexString:@"fe4365"];
        balanceLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:balanceLabel];
        
        UILabel *signtextLabel =[[UILabel alloc] init];
        signtextLabel.font = [UIFont systemFontOfSize:16];
        signtextLabel.text = @"签名";
        signtextLabel.textColor = [UIColor lightGrayColor];
        signtextLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:signtextLabel];
        
        signImageView = [[UIImageView alloc] init];
        [self addSubview:signImageView];
        
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).offset(10.);
            make.top.equalTo(self.mas_top).offset(10.);
            make.height.equalTo(60);
            make.width.equalTo(100);

        }];
        
        [timeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(timeLabel.mas_right);
            make.top.equalTo(self.mas_top);
            make.width.equalTo(10);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        [dot mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(timeImage.mas_centerX);
            make.top.equalTo(timeImage.mas_top);
            make.width.equalTo(14);
            make.height.equalTo(14);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(timeImage.mas_centerX);
            make.top.equalTo(dot.mas_bottom);
            make.width.equalTo(2);
            make.bottom.equalTo(timeImage.mas_bottom).offset(-1);
        }];
        
        [totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(timeImage.mas_right).offset(20);
            make.top.equalTo(self.mas_top).offset(10);
//            make.right.equalTo(self.mas_right).offset(-20);
            make.width.equalTo(200);
            make.height.equalTo(30.);
        }];
        
        [otherPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(totalPrice.mas_right);
            make.top.equalTo(self.mas_top).offset(10);
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.equalTo(30.);
        }];
        
        [detialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(timeImage.mas_right).offset(20);
            make.top.equalTo(totalPrice.mas_bottom).offset(10);
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.equalTo(30.);
        }];
        
        [detailList mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(detialLabel.mas_bottom).offset(10.);
            make.left.equalTo(timeImage.mas_right).offset(20);
            make.bottom.equalTo(self.mas_bottom).offset(-260);
            make.right.equalTo(self.mas_right).offset(-20);
            
        }];

        [balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(timeImage.mas_right).offset(20);
            make.top.equalTo(detailList.mas_bottom).offset(10);
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.equalTo(30.);
        }];
        
        [signtextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(timeImage.mas_right).offset(20);
            make.top.equalTo(signImageView.mas_top);
            make.width.equalTo(50.);
            make.height.equalTo(40.);
            
        }];
        
        [signImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(timeImage.mas_right).offset(70);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.equalTo(200.);
        }];
        

        
        curentArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)billDetailListCellSetInfo:(BillInfo *)info
{
    [curentArray removeAllObjects];
    timeLabel.text = info.recordTime;
    NSArray *timearr = [info.recordTime componentsSeparatedByString:@" "];
    timeLabel.text = [NSString stringWithFormat:@"%@\r%@",[timearr objectAtIndex:0],[timearr objectAtIndex:1]];
    totalPrice.text = [NSString stringWithFormat:@"账单金额:   %@ 元",info.total];
    balanceLabel.text = [NSString stringWithFormat:@"账户余额:   %@ 元",info.balance];
    NSString *signImagePath= [userSignPath stringByAppendingPathComponent:info.userSign];
    signImageView.image = [UIImage imageWithContentsOfFile:signImagePath];
    [curentArray addObjectsFromArray:info.projectArray];
    
    if ([info.isOtherPay isEqualToString:@"NO"])
    {
        otherPayLabel.hidden = YES;
    }
    else
    {
        otherPayLabel.hidden = NO;
    }
    
    [detailList reloadData];
}


#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark UITableVieDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return curentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"ContactInfoTableViewCell";
    BillDetailPayMentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[BillDetailPayMentCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    [cell setProjectListInfo:[curentArray objectAtIndex:indexPath.row]];
    return cell;

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
