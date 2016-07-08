//
//  YJEmotionTabBar.h
//  YJ-微博
//
//  Created by MACBOOK on 16/1/4.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    YJEmotionTabbarButtonTypeRecent,
    YJEmotionTabbarButtonTypeDefault,
    YJEmotionTabbarButtonTypeEmoji,
    YJEmotionTabbarButtonTypeLxh

} YJEmotionTabbarButtonType;


@class YJEmotionTabBar;

@protocol YJEmotionTabBarDelegate <NSObject>

@optional
-(void)emotionTabBar:(YJEmotionTabBar *)tabbar didSelectButton:(YJEmotionTabbarButtonType)buttonType;

@end


@interface YJEmotionTabBar : UIView

@property (nonatomic,weak) id<YJEmotionTabBarDelegate>  delegate;

@end
