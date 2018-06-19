//
//  GraphicLockView.m
//  HaidilaoPadV2
//
//  Created by GuGuiJun on 14/10/28.
//  Copyright (c) 2014年 Hoperun. All rights reserved.
//

#import "GraphicLockView.h"

@interface GraphicLockView()
{
    //绘制图形完成标识
    BOOL isFinishDraw;
    
    //连接点个数大于4标识
    BOOL isTrailLegal;
}

//存放已经选中的按钮
@property (nonatomic, strong) NSMutableArray *selectedButtons;
//记录当前的点击位置
@property (nonatomic, assign) CGPoint currentMovePoint;

@end

@implementation GraphicLockView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

/**
 初始化
 */
- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.selectedButtons = [[NSMutableArray alloc] init];
    
    for (int index = 0; index<9; index++) {
        // 创建按钮
        GraphicLockButton *btn = [GraphicLockButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        // 添加按钮
        [self addSubview:btn];
    }
}

//九宫格布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int index = 0; index<self.subviews.count; index++) {
        // 取出按钮
        GraphicLockButton *btn = self.subviews[index];
        
        // 设置frame
        CGFloat btnW = 60;
        CGFloat btnH = 60;
        
        int totalColumns = 3;
        int col = index % totalColumns;
        int row = index / totalColumns;
        CGFloat marginX = (self.frame.size.width - totalColumns * btnW) / (totalColumns + 1);
        CGFloat marginY = marginX;
        
        CGFloat btnX = marginX + col * (btnW + marginX);
        CGFloat btnY = marginY + row * (btnH + marginY);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

#pragma mark - 私有方法
/**
 根据touches集合获得对应的触摸点位置
 */
- (CGPoint)pointWithTouches:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    return [touch locationInView:touch.view];
}

/**
 根据触摸点位置获得对应的按钮
 */
- (GraphicLockButton *)buttonWithPoint:(CGPoint)point
{
    for (GraphicLockButton *btn in self.subviews) {
        CGFloat wh = 40;
        CGFloat frameX = btn.center.x - wh * 0.5;
        CGFloat frameY = btn.center.y - wh * 0.5;
        if (CGRectContainsPoint(CGRectMake(frameX, frameY, wh, wh), point)) {
            return btn;
        }
    }
    
    return nil;
}

/**
 绘制完成之后，清空绘画痕迹
 */
- (void)clearDrawTrail
{
    
    [self.selectedButtons makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
    
    // 清空选中的按钮
    [self.selectedButtons removeAllObjects];
    
    [self setNeedsDisplay];
}

#pragma mark - 触摸方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.delegate)
    {
        [self.delegate beginTouch:YES];
    }
    
    isFinishDraw = NO;
    
    // 清空当前的触摸点
    self.currentMovePoint = CGPointZero;
    
    // 1.获得触摸点
    CGPoint pos = [self pointWithTouches:touches];
    
    // 2.获得触摸的按钮
    GraphicLockButton *btn = [self buttonWithPoint:pos];
    
    // 3.设置状态
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectedButtons addObject:btn];
    }
    
    // 4.刷新
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

    
    isFinishDraw = NO;
    
    // 1.获得触摸点
    CGPoint pos = [self pointWithTouches:touches];
    
    // 2.获得触摸的按钮以及路径上的按钮
    GraphicLockButton *btn = [self buttonWithPoint:pos];
    
    GraphicLockButton *passBtn = nil;
    if (self.selectedButtons && (self.selectedButtons.count >= 1))
    {
        GraphicLockButton *preBtn = [self.selectedButtons lastObject];
        CGPoint passPos = CGPointMake(preBtn.center.x * 0.5 + btn.center.x * 0.5, preBtn.center.y * 0.5 + btn.center.y * 0.5);
        passBtn = [self buttonWithPoint:passPos];
    }
    
    // 3.设置状态
    if (btn && btn.selected == NO) { // 摸到了按钮
        
        if (passBtn && passBtn.selected == NO) {
            passBtn.selected = YES;
            [self.selectedButtons addObject:passBtn];
        }
        
        btn.selected = YES;
        [self.selectedButtons addObject:btn];
    }
    else
    { // 没有摸到按钮
        self.currentMovePoint = pos;
    }
    
    // 4.刷新
    [self setNeedsDisplay];
}

-(void)setError
{
    for (int index = 0; index<self.selectedButtons.count; index++)
    {
        GraphicLockButton *btn = [self.selectedButtons objectAtIndex:index];
        
        [btn setImage:[UIImage imageNamed:@"kt_btn_circle_error_2x"] forState:UIControlStateSelected];
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    isFinishDraw = YES;
    
    //绘制结束，将终点设置为最后一个连接点
    if (self.selectedButtons && (self.selectedButtons.count > 0)) {
        GraphicLockButton *lastButton = [self.selectedButtons lastObject];
        self.currentMovePoint = lastButton.center;
    }
    
    //滑动路径
    NSMutableString *path = [NSMutableString string];
    for (GraphicLockButton *btn in self.selectedButtons)
    {
        [path appendFormat:@"%ld", (long)btn.tag];
    }
    NSLog(@"连接轨迹：%@", path);
    
//    //连接点大于四个
//    if (path && path.length >= 4)
//    {
//        isTrailLegal = YES;
//        
//    }
//    else
//    {
//        isTrailLegal = NO;
//        [self setError];
//    }
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(lockPath:)])
    {
        [self.delegate lockPath:path];
    }
    
    
    if (self.delegate)
    {
        [self.delegate beginTouch:NO];
    }
    
    
    [self setNeedsDisplay];
    
    //清空页面
    //[self performSelector:@selector(clearDrawTrail) withObject:nil afterDelay:1.0f];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

#pragma mark - 绘图
- (void)drawRect:(CGRect)rect
{
    if (self.selectedButtons.count == 0) return;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 遍历所有的按钮
    for (int index = 0; index<self.selectedButtons.count; index++)
    {
        GraphicLockButton *btn = [self.selectedButtons objectAtIndex:index];
        
        if (index == 0)
        {
            [path moveToPoint:btn.center];
        }
        else
        {
            [path addLineToPoint:btn.center];
        }
    }
    
    // 连接
    if (CGPointEqualToPoint(self.currentMovePoint, CGPointZero) == NO)
    {
        [path addLineToPoint:self.currentMovePoint];
    }
    
    // 绘图
    path.lineWidth = 4;
    path.lineJoinStyle = kCGLineJoinBevel;

    //[[UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:0.5] set];
//    [RGBColor(172, 206, 221) set];
    [RGBColor(42, 153, 255) set];
    
    [path stroke];
}



@end
