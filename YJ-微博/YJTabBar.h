//
//  YJTabBar.h
//  YJ-微博
//
//  Created by MACBOOK on 15/12/23.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJTabBar;

//#warning 因为YJTabBar继承自UITabBar，所以称为YJTabBar的代理，也必须实现uitabBar的代理协议
@protocol YJTabBarDelegate <UITabBarDelegate>

@optional
-(void)tabBarDidClickPlusButton:(YJTabBar *)tabBar;

@end


@interface YJTabBar : UITabBar
@property (nonatomic,weak) id<YJTabBarDelegate> delegate;
@end

