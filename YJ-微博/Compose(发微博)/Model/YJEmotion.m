//
//  YJEmotion.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/5.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJEmotion.h"

@interface YJEmotion() <NSCoding>

@end

@implementation YJEmotion



//从文件中解析对象时  调用此方法
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if(self=[super init]){
        self.chs=[aDecoder decodeObjectForKey:@"chs"];
         self.png=[aDecoder decodeObjectForKey:@"png"];
         self.code=[aDecoder decodeObjectForKey:@"code"];
        
    }
    return self;
}


//将对象写入文件时调用
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.chs forKey:@"chs"];
     [aCoder encodeObject:self.png forKey:@"png"];
     [aCoder encodeObject:self.code forKey:@"code"];
    
}

@end
