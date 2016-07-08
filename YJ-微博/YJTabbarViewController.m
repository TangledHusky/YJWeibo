//
//  YJTabbarViewController.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/21.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "YJTabbarViewController.h"
#import "YJHomeViewController.h"
#import "YJMessageCenterViewController.h"
#import "YJDiscoverViewController.h"
#import "YJMeViewController.h"
#import "YJNavigationController.h"
#import "YJTabBar.h"
#import "YJComposeViewController.h"



@interface YJTabbarViewController () <YJTabBarDelegate>

@end

@implementation YJTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //子控制器
    YJHomeViewController *home=[[YJHomeViewController alloc] init];
    [self createChildVcWithVc:home Title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
//    YJMessageCenterViewController *message=[[YJMessageCenterViewController alloc] init];
//    [self createChildVcWithVc:message Title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
//
    YJMessageCenterViewController *message=[[YJMessageCenterViewController alloc] init];
    [self createChildVcWithVc:message Title:@"工具" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    


    
    YJDiscoverViewController *discover=[[YJDiscoverViewController alloc] init];
    [self createChildVcWithVc:discover Title:@"备忘录" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    YJMeViewController *me=[[YJMeViewController alloc] init];
    [self createChildVcWithVc:me Title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    
    //更换系统自带的tabbar（因为是只读，所以直接=不行）
    //self.tabBar=[[YJTabBar alloc] init];
    //用kvc去赋值  中间的加号按钮
    YJTabBar *tabBar=[[YJTabBar alloc] init];
    tabBar.delegate=self;
    [self setValue:[[YJTabBar alloc] init] forKeyPath:@"tabBar"];
    
    
   
}





-(void)createChildVcWithVc:(UIViewController *)vc Title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    
    //图片渲染
    vc.tabBarItem.title=title;
    vc.navigationItem.title=title;
    vc.tabBarItem.image=[UIImage imageNamed:image];
    vc.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //文字渲染
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName]=[UIColor blackColor];
    [vc.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    //选中的文字渲染
    dict[NSForegroundColorAttributeName]=[UIColor orangeColor];
    [vc.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    
//    vc.view.backgroundColor=randomColor;
    
    
    YJNavigationController *nav=[[YJNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

#pragma mark - tabBar代理方法
-(void)tabBarDidClickPlusButton:(YJTabBar *)tabBar{
    
    YJComposeViewController *compose=[[YJComposeViewController alloc] init];
    YJNavigationController *nav=[[YJNavigationController alloc] initWithRootViewController:compose];
    
    [self presentViewController:nav animated:YES completion:nil];
    
    
}

@end
