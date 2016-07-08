//
//  testNSCoding-save.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/16.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "testNSCoding-save.h"

@implementation testNSCoding_save


//存储时，定义哪些是归档存储的属性
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:_ID forKey:@"ID"];
    [aCoder encodeObject:_name forKey:@"name"];
    
}


//解档时，即取出信息时调用，取出哪些属性
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        _ID=[aDecoder decodeIntForKey:@"ID"];
        _name=[aDecoder decodeObjectForKey:@"name"];
    }
    return  self;
}
@end
