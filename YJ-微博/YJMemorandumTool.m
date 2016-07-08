//
//  YJMemorandumTool.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/14.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//  操作备忘录的工具类，增删改查

#import "YJMemorandumTool.h"
#import "YJMemorandum.h"
#import "FMDB.h"


#define BQLSQLITE_NAME @"modals.sqlite"

@implementation YJMemorandumTool


static FMDatabase *_fmdb;

//初始化
+(void)initialize{
    //执行打开数据库和创建表
    
    //数据库路径
    NSString *filePath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:BQLSQLITE_NAME];
    
    _fmdb=[FMDatabase databaseWithPath:filePath];
    
    [_fmdb open];
    
    //必须打开数据库，才能执行创建操作
    [_fmdb executeUpdate:@"CREATE TABLE IF NOT EXISTS t_modals(id INTEGER PRIMARY KEY,noteID INTEGER NOT NULL,noteContent TEXT NOT NULL,noteTime TEXT NOT NULL)"];
    
}


//插入模型
+(BOOL)insertModel:(YJMemorandum *)model{
    
    return [_fmdb executeUpdate:@"INSERT INTO t_modals(noteID,noteContent,noteTime) VALUES(?,?,?)",[NSString stringWithFormat:@"%d",model.noteID],[NSString stringWithFormat:@"%@",model.noteContent],[NSString stringWithFormat:@"%@",model.noteTime]];
}


//查询
+(NSArray *)queryModel:(NSString *)querySql{
    if (querySql==nil) {
        querySql=@"SELECT * FROM t_modals;";
    }
    
    NSMutableArray *arry=[NSMutableArray array];
    FMResultSet *set=[_fmdb executeQuery:querySql];
    
    //转换成对象数组
    while ([set next]) {
        NSString *noteID=[set stringForColumn:@"noteID"];
         NSString *noteContent=[set stringForColumn:@"noteContent"];
         NSString *noteTime=[set stringForColumn:@"noteTime"];
        
        YJMemorandum *model=[YJMemorandum modelWith:noteID.intValue content:noteContent time:noteTime];
        [arry addObject:model];
    }
    
    return  arry;
    
}


//删除
+(BOOL)deleteModel:(YJMemorandum *)model{
    
    return [_fmdb executeUpdate:@"DELETE FROM t_modals where noteID=?",[NSString stringWithFormat:@"%d",model.noteID]];
}

//修改
+(BOOL)modifyModel:(YJMemorandum *)model{
    
    return [_fmdb executeUpdate:@"UPDATE t_modals SET noteContent=?,noteTime=? where noteID=?",[NSString stringWithFormat:@"%@",model.noteContent],[NSString stringWithFormat:@"%@",model.noteTime],[NSString stringWithFormat:@"%d",model.noteID]];
}

+(NSString *)getTodayDate
{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY/MM/dd HH:mm:ss";
    NSString *nowStr = [dateFormatter stringFromDate:now];
    return nowStr;
}

@end
