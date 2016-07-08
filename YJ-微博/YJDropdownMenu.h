//
//  YJDropdownMenu.h
//  YJ-微博
//
//  Created by MACBOOK on 15/12/23.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJDropdownMenu;

@protocol YJDropdownMenuDelegate <NSObject>

@optional
-(void)dropdownMenuDidDismiss:(YJDropdownMenu *)menu;
-(void)dropdownMenuDidShow:(YJDropdownMenu *)show;
@end


@interface YJDropdownMenu : UIView

@property (nonatomic,weak) id<YJDropdownMenuDelegate> delegate;

+ (instancetype)menu;

/**
 *  显示
 */
- (void)showFrom:(UIView *)from;
/**
 *  销毁
 */
- (void)dismiss;

/**
 *  内容
 */
@property (nonatomic, strong) UIView *content;

@property (nonatomic, strong) UIViewController *contentController;

@end
