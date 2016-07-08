//
//  AppDelegate.h
//  YJ-微博
//
//  Created by MACBOOK on 15/12/19.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import "YJTabbarViewController.h"

//@class SendMessageToWeiboViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) YJTabbarViewController * mainNavigationController;

@property (nonatomic,strong) LeftSlideViewController * LeftSlideVC;



@end

