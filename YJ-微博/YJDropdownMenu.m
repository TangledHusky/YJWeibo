//
//  YJDropdownMenu.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/23.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "YJDropdownMenu.h"

@interface YJDropdownMenu()

@property (nonatomic,strong) UIImageView *containerView;


@end


@implementation YJDropdownMenu

- (UIImageView *)containerView
{
    if (!_containerView) {
        // 添加一个灰色图片控件
        UIImageView *containerView = [[UIImageView alloc] init];
        //containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.backgroundColor=[UIColor lightGrayColor];
        containerView.width = 217;
        containerView.height = 217;
        containerView.userInteractionEnabled = YES; // 开启交互
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 清除颜色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


+ (instancetype)menu
{
    return [[self alloc] init];
}

- (void)setContent:(UIView *)content
{
    _content=content;
  
    content.x=10;
    content.y=15;
    
    //调整内容的宽度
    //content.width=self.containerView.width-20;
    self.containerView.width=content.width+20;
    
    //设置灰色的尺寸
    self.containerView.height=CGRectGetMaxY(content.frame)+10;
    
    //设置灰色的位置
    self.containerView.y=20;
    
    [self.containerView addSubview:content];
}

-(void)setContentController:(UIViewController *)contentController{
    _contentController=contentController;
    self.content=contentController.view;
    
}


/**
 *  显示
 */
- (void)showFrom:(UIView *)from
{
    // 1.获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    // 2.添加自己到窗口上
    [window addSubview:self];
    
    // 3.设置尺寸
    self.frame = window.bounds;
    
    //4.设置位置
    
    CGRect rect= [from convertRect:from.bounds toView:window];
    self.containerView.centerX=CGRectGetMidX(rect);

    self.containerView.y=CGRectGetMaxY(rect);
    
    //5.显示时设置箭头向上
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }
    
  }

/**
 *  销毁
 */
- (void)dismiss
{
    [self removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}
@end
