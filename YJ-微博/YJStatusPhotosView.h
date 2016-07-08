//
//  YJStatusPhotosView.h
//  YJ-微博
//
//  Created by MACBOOK on 15/12/31.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//  cell上面的配图相册，（里面会显示1~9张图片）

#import <UIKit/UIKit.h>

@interface YJStatusPhotosView : UIView

@property (nonatomic,strong) NSArray  *photos;

+(CGSize)SizeWithCount:(int)count;

@end
