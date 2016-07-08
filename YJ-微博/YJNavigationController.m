//
//  YJNavigationController.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/21.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "YJNavigationController.h"


@implementation YJNavigationController

+(void)initialize{
    
    //设置整个项目的所有item主题样式
    UIBarButtonItem *item=[UIBarButtonItem appearance];
    
    //设置普通状态
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName]=[UIColor orangeColor];
    textAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置不可用状态
    NSMutableDictionary *disabledtextAttrs=[NSMutableDictionary dictionary];
    disabledtextAttrs[NSForegroundColorAttributeName]=[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
    disabledtextAttrs[NSFontAttributeName]=textAttrs[NSFontAttributeName];
    [item setTitleTextAttributes:disabledtextAttrs forState:UIControlStateDisabled];
    
}


/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    
       if (self.viewControllers.count>0) {
        
        viewController.hidesBottomBarWhenPushed=YES;
        
        viewController.navigationItem.leftBarButtonItem=[UINavigationItem itemWithTarget:self Action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
             
        
        viewController.navigationItem.rightBarButtonItem=[UINavigationItem itemWithTarget:self Action:@selector(btnMore) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
           
    }
    
    [super pushViewController:viewController animated:YES];
    

}


-(void)back{
    [self popViewControllerAnimated:YES];
    
}

-(void)btnMore{
    [self popToRootViewControllerAnimated:YES];
    
}

@end
