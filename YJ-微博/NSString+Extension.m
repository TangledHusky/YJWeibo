//
//  NSString+Extension.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/30.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

-(CGSize)sizeWithFont:(UIFont *)font{
  
    return [self sizeWithFont:font maxW:MAXFLOAT];
            
}

-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW{
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[NSFontAttributeName]=font;
    CGSize maxWH=CGSizeMake(maxW, MAXFLOAT);
    
    return  [self boundingRectWithSize:maxWH options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    
}

@end
