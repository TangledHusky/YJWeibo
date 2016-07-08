//
//  YJEmotionTextView.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/11.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJEmotionTextView.h"
#import "YJEmotion.h"
#import "NSString+Emoji.h"
#import "YJEmotionAttachment.h"

@implementation YJEmotionTextView

-(void)insertEmotion:(YJEmotion *)emotion{
    //判断是普通表情还是emoji
    if (emotion.code) {     //是emoji
        
        //insetText：将文字插入到光标处
        [self insertText:emotion.code.emoji];
    }else if(emotion.png){
        
        //加载图片
       
        YJEmotionAttachment *attachment=[[YJEmotionAttachment alloc] init];
        //传递模型
        attachment.emotion=emotion;
       
        //设置图片的尺寸
        CGFloat attachWH=self.font.lineHeight;
        attachment.bounds=CGRectMake(0,-4, attachWH, attachWH);

        
        NSAttributedString *imageAttr=[NSAttributedString attributedStringWithAttachment:attachment];
        
        //插入属性文字到光标位置
      [self insertAttributeText:imageAttr settingBlock:^(NSMutableAttributedString *attributeText) {
          //设置字体
          //[attributeText addAttribute:NSFontAttributeName value:self range:NSMakeRange(0, attributeText.length)];
          
      }];
        
//
    }
    
}


//返回含表情的文字
-(NSString *)fullText{
    //遍历所有属性
    NSMutableString *fulltext=[NSMutableString string];
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
       
        //如果是图片表情
        YJEmotionAttachment *attach=attrs[@"NSAttachment"];
        if (attach) {
            //返回表情对应的文字
            [fulltext appendString:attach.emotion.chs];
        }else{      //emoji或普通文本
            NSAttributedString *str=[self.attributedText attributedSubstringFromRange:range];
            [fulltext appendString:str.string];
            
            
        }
    }];
    
    return fulltext;
}


@end
