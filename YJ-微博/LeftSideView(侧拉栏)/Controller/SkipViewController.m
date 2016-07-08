//
//  SkipViewController.m
//
//
//  
//  Copyright (c) 2015年 mumu. All rights reserved.
//
// 只需要继承该类就可以侧滑返回，不需要写任何代码(模态过去的不可以)

#import "SkipViewController.h"
@interface SkipViewController ()

@end

@implementation SkipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
    // 获取系统自带滑动手势的target对象.
    // Acquisition system with sliding gesture to the target object.
     id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法.
    // To create a full-screen slide gestures, sliding gesture to the target system at call the action method.
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发.
    // Set up the gestures agent, intercept gestures trigger.
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势.
    // Add a full-screen slide gestures to view navigation controller.
    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势.
    // To ban the use of system with sliding gesture.
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    // Note: only the root controller is sliding back function, the root controller.
    // To determine whether a navigation controller is only a child controller, if there is only a child controller, must be the root controller.
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势
        // User in the root controller interface, do not need to trigger sliding gesture.
        return NO;
    }
    return YES;
}


- (void)handleNavigationTransition:(UIPanGestureRecognizer *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
