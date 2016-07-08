//
//  YJTextView.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/3.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJTextView.h"

@implementation YJTextView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //通知（自己可监听，别人也可，但代理只能自己）
        //当textevew文字发生改变，uitextview自己会发出一个UITextViewTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
    }
    return self;
}

#pragma mark - 重写属性
-(void)setPlaceholder:(NSString *)placeholder{
    //copy特殊
    _placeholder=[placeholder copy];
    
    [self setNeedsDisplay];
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor=placeholderColor;
    
    [self setNeedsDisplay];
}

-(void)setText:(NSString *)text{
    [super setText:text];
    
    [self setNeedsDisplay];
}

-(void)setAttributedText:(NSAttributedString *)attributedText{
    
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    
    [self setNeedsDisplay];
}


-(void)textDidChange{
    //YJLog(@"change");
    
    //系统自动刷新，重新调用drawrect方法
    [self setNeedsDisplay];
    
}

//每次调用，都回清空上次的绘画
-(void)drawRect:(CGRect)rect{
    
    //如果输入文字，就不显示提示
    if ([self hasText]) {
        return;
    }
    //文字属性
    NSMutableDictionary *attr=[NSMutableDictionary dictionary];
    attr[NSFontAttributeName]=self.font;
    attr[NSForegroundColorAttributeName]=self.placeholderColor;
    
    
//    //画文字,这种方式如果提示文字过长，不会换行
//    [self.placeholder drawAtPoint:CGPointMake(5, 8) withAttributes:attr];
    
    
    //这种会换行
    CGFloat x=5;
    CGFloat y=8;
    CGFloat w=rect.size.width-2*x;
    CGFloat h=rect.size.height-2*y;
    
    [self.placeholder drawInRect:CGRectMake(x, y, w,h) withAttributes:attr];
}




@end
