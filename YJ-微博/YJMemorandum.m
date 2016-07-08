//
//  YJMemorandum.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/14.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJMemorandum.h"

@implementation YJMemorandum

+(instancetype)modelWith:(int)noteID content:(NSString *)noteContent time:(NSString *)noteTime{
    YJMemorandum *model=[[YJMemorandum alloc] init];
    model.noteID=noteID;
    model.noteContent=noteContent;
    model.noteTime=noteTime;
    
    return  model;
}

@end
