//
//  YJMemorandumTool.h
//  YJ-微博
//
//  Created by MACBOOK on 16/1/14.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YJMemorandum;

@interface YJMemorandumTool : NSObject

//插入模型
+(BOOL)insertModel:(YJMemorandum *)model;

//查询数据
+ (NSArray *)queryModel:(NSString *)querySql;

//删除数据
+(BOOL)deleteModel:(YJMemorandum *)model;

//修改数据
+(BOOL)modifyModel:(YJMemorandum *)model;



//其他方法
+(NSString *)getTodayDate;
@end
