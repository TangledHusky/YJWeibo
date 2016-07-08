//
//  UITextView+Extension.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/11.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

-(void)insertAttributeText:(NSAttributedString *)text{
    
    
    NSMutableAttributedString *attributeText=[[NSMutableAttributedString alloc] init];
    //拼接已有的文字或表情
    [attributeText appendAttributedString:self.attributedText];
    
    
    //selectRange  确定光标的位置
    int gblocation=self.selectedRange.location;
    [attributeText insertAttributedString:text atIndex:gblocation];
    //设置光标位置为插入的表情之后(回复光标)
    self.selectedRange=NSMakeRange(gblocation+1, 0);
    
    //设置字体
    
   
    self.attributedText=attributeText;

}


-(void)insertAttributeText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *))settingBlock{
    
    
    
    NSMutableAttributedString *attributeText=[[NSMutableAttributedString alloc] init];
    //拼接已有的文字或表情
    [attributeText appendAttributedString:self.attributedText];
    
    
    //selectRange  确定光标的位置
    int gblocation=self.selectedRange.location;
    //用replace，不用insert
    [attributeText replaceCharactersInRange:self.selectedRange withAttributedString:text];
    //设置光标位置为插入的表情之后(回复光标)
    self.selectedRange=NSMakeRange(gblocation+1, 0);
    
    //调用外面传进来的代码
    if (settingBlock) {     //不为nil
        settingBlock(attributeText);
    }
    
    self.attributedText=attributeText;

}
@end
