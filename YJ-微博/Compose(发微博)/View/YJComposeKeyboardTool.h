//
//  YJComposeKeyboardTool.h
//  YJ-微博
//
//  Created by MACBOOK on 16/1/3.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    YJKeyboardButtonTypeCamel,
     YJKeyboardButtonTypePhoto,
    YJKeyboardButtonTypeHt,
     YJKeyboardButtonTypeAT,
     YJKeyboardButtonTypeEmotion,
    
}YJKeyboardButtonType;

@class YJComposeKeyboardTool;

@protocol YJComposeKeyboardToolDelegate <NSObject>

@optional
-(void)KeyboardTool:(YJComposeKeyboardTool *)toolbar DidClcikButton:(YJKeyboardButtonType)btnType;

@end

@interface YJComposeKeyboardTool : UIView

@property (nonatomic,weak) id<YJComposeKeyboardToolDelegate>  delegate;

@property (nonatomic,assign) BOOL  showKeyboard;

@end
