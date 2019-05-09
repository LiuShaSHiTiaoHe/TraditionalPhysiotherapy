//
//  PaymentViewController.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/12/28.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import "PaymentViewController.h"
#import "BillDao.h"
#import "NewBillDetailListCell.h"

@interface PaymentViewController ()<UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate>
{
    BillInfo *lastInfo;
    UITableView *infoTableView;
}
@end

@implementation PaymentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    contentView = [[PaymentView alloc] init];
    contentView.delegate = self;
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

-(void)PaymentMethod:(NSInteger)method//0 会员  1普通客户 扫码支付
{
    if (method==0)
    {

        commonView.hidden = YES;
        
        if (!vipView)
        {
            vipView = [[VIPCustomerPaymentView alloc] init];
            vipView.delegate = self;
            [self.view addSubview:vipView];
            
            [vipView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(self.view.mas_top).offset(64.);
                make.left.equalTo(self.view.mas_left);
                make.right.equalTo(self.view.mas_right);
                make.bottom.equalTo(self.view.mas_bottom);

            }];
        }
        else
        {
            vipView.hidden = NO;
        }
        [vipView refreshData];

    }
    else
    {
        vipView.hidden = YES;
        
        if (!commonView)
        {
            commonView = [[CommonCustomerPaymentView alloc] init];
            [self.view addSubview:commonView];
            
            [commonView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(self.view.mas_top).offset(64.);
                make.left.equalTo(self.view.mas_left);
                make.right.equalTo(self.view.mas_right);
                make.bottom.equalTo(self.view.mas_bottom);
                
            }];
        }
        else
        {
            commonView.hidden = NO;
        }
        [commonView getTotalPrice];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self PaymentMethod:0];
}

-(void)startCutTheImageWithBillId:(NSString *)billId
{
    lastInfo = [[BillDao shareInstanceBillDao] getBillInfo:billId];
    infoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    infoTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    infoTableView.backgroundColor = [UIColor whiteColor];
    infoTableView.delegate = self;
    infoTableView.dataSource = self;
    [self performSelector:@selector(getImage) withObject:nil afterDelay:2];
}

-(void)getImage
{
    NewBillDetailListCell *cell = [infoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UIImage *image=[UIImage getImageViewWithView:cell];
    [self calulateImageFileSize:image];
    NSArray *postItems=@[image];
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:postItems applicationActivities:nil];
    controller.completionWithItemsHandler = ^(UIActivityType  _Nullable   activityType,
                                              BOOL completed,
                                              NSArray * _Nullable returnedItems,
                                              NSError * _Nullable activityError) {
        
        NSLog(@"activityType: %@,\n completed: %d,\n returnedItems:%@,\n activityError:%@",activityType,completed,returnedItems,activityError);
        if (completed)
        {
            
        }
    };
    controller.modalPresentationStyle = UIModalPresentationPopover;
    controller.preferredContentSize = CGSizeMake(400, 300);
    UIPopoverPresentationController *pop = controller.popoverPresentationController;
    pop.sourceView = cell;
    pop.sourceRect = CGRectMake(cell.frame.size.width / 2, cell.frame.size.height/2, 0, 0);
    pop.permittedArrowDirections = UIPopoverArrowDirectionUp;
    pop.backgroundColor = [UIColor whiteColor];
    pop.delegate = self;
    [self presentViewController:controller animated:YES completion:^{
        
    }];
}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}

#pragma mark- UIPopoverPresentationControllerDelegate
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

#pragma mark UITableVieDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"ContactInfoTableViewCell";
    NewBillDetailListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[NewBillDetailListCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell billDetailListCellSetInfo:lastInfo];
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BillInfo *info = lastInfo;
    float height = 150.;
    if (![NSObject isNullOrNilWithObject:info.userSign])
    {
        height = height + 400;
    }
    
    if (info.projectArray.count > 0)
    {
        height = height + 40*info.projectArray.count;
    }
    return height;
}

- (void)calulateImageFileSize:(UIImage *)image
{
    NSData *data = UIImagePNGRepresentation(image);
    if (!data) {
        data = UIImageJPEGRepresentation(image, 1.0);//需要改成0.5才接近原图片大小，原因请看下文
    }
    double dataLength = [data length] * 1.0;
    NSArray *typeArray = @[@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB",@"ZB",@"YB"];
    NSInteger index = 0;
    while (dataLength > 1024) {
        dataLength /= 1024.0;
        index ++;
    }
    NSLog(@"image = %.3f %@",dataLength,typeArray[index]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
