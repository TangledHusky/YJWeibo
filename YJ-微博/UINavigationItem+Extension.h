//
//  UINavigationItem+Extension.h
//  YJ-微博
//
//  Created by MACBOOK on 15/12/22.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (Extension)

+(UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

@end
