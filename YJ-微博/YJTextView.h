//
//  YJTextView.h
//  YJ-微博
//
//  Created by MACBOOK on 16/1/3.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//  带有placeholder提示文字

#import <UIKit/UIKit.h>

@interface YJTextView : UITextView

@property (nonatomic,copy) NSString *placeholder;
@property (nonatomic,strong) UIColor *placeholderColor;

//字体跟随textview字体
@end
