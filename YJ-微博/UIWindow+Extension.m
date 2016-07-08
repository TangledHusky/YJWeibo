//
//  UIWindow+Extension.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/25.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "YJNewFeatureController.h"
#import "YJTabbarViewController.h"
#import "AppDelegate.h"

@implementation UIWindow (Extension)

+(void)switchRootController{

        //这里要根据版本判断是否显示新特性
        NSString *keyVersion=@"CFBundleVersion";

        //获取历史版本（从沙盒获取）
        NSString *oldVersion=[[NSUserDefaults standardUserDefaults] objectForKey:keyVersion];


        //获取新版本，从plist的version获取
        NSString *currentVersion=[NSBundle mainBundle].infoDictionary[keyVersion];

        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        //比较两个版本是否一致
        if ([oldVersion isEqualToString:currentVersion]) {
            //直接进入主界面控制器
//            YJTabbarViewController *tabBar=[[YJTabbarViewController alloc] init];
//            window.rootViewController=tabBar;
            
        AppDelegate * tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        window.rootViewController=tempAppDelegate.LeftSlideVC;

        
        }else{
            //进入新特新界面


            //保存新版本到沙盒
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:keyVersion];
            //设置同步进行，否则会过个几分钟才保存进去，不保险
            [[NSUserDefaults standardUserDefaults] synchronize];

            YJNewFeatureController *scroll=[[YJNewFeatureController alloc] init];
            window.rootViewController=scroll;
                
        }
    
}

@end
