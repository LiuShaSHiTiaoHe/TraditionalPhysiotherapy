//
//  GraphicLockView.h
//  HaidilaoPadV2
//
//  Created by GuGuiJun on 14/10/28.
//  Copyright (c) 2014年 Hoperun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphicLockButton.h"

@protocol GraphicLockViewDelegate <NSObject>

-(void)beginTouch:(BOOL)isbegan;
-(void)lockPath:(NSString *)path;

@end
@interface GraphicLockView : UIView
{

}


@property(nonatomic,assign)id<GraphicLockViewDelegate> delegate;

-(void)clearDrawTrail;
-(void)setError;
@end
