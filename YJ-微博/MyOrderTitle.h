//
//  MyOrderTitle.h
//  YJ-微博
//
//  Created by MACBOOK on 16/3/25.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyOrderTitle;

@protocol MyOrderTitleDelegate <NSObject>

@optional
-(void)MyOrderTitleDidClick:(MyOrderTitle *)myOrderTitle withClickIndex:(NSInteger)index;

@end

@interface MyOrderTitle : UIView

- (IBAction)btnClick:(UIButton *)sender;

@property (nonatomic,weak) id<MyOrderTitleDelegate>  delegate;

@end
