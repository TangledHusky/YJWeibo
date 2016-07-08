//
//  YJSliderNaviController.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/16.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJSliderNaviController.h"
#import "AppDelegate.h"
#import "LeftSortsViewController.h"

@implementation YJSliderNaviController



/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    

        
        viewController.hidesBottomBarWhenPushed=YES;
        
        viewController.navigationItem.leftBarButtonItem=[UINavigationItem itemWithTarget:self Action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
        
        
        viewController.navigationItem.rightBarButtonItem=[UINavigationItem itemWithTarget:self Action:@selector(btnMore) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
    
    
    [super pushViewController:viewController animated:YES];
    
    
}


-(void)back{
    //初始化主界面和侧边栏
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];

    //这里如果不重新allco的话，返回后，侧边栏是看不到了，why？？？
    delegate.mainNavigationController = [[YJTabbarViewController alloc] init];
    LeftSortsViewController * lestVC = [[LeftSortsViewController alloc]init];
    delegate.LeftSlideVC = [[LeftSlideViewController alloc]initWithLeftView:lestVC andMainView:delegate.mainNavigationController];
   
    
    [self presentViewController:delegate.LeftSlideVC animated:YES completion:nil];
}

-(void)btnMore{
 
    [self back];
}

@end
