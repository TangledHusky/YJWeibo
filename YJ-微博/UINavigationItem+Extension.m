//
//  UINavigationItem+Extension.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/22.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "UINavigationItem+Extension.h"

@implementation UINavigationItem (Extension)

+(UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage{
    
    //返回按钮
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    //设置尺寸
    btn.size=btn.currentBackgroundImage.size;
    
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}


@end
