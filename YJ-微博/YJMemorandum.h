//
//  YJMemorandum.h
//  YJ-微博
//
//  Created by MACBOOK on 16/1/14.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJMemorandum : NSObject

//备忘录编号
@property (nonatomic,assign) int  noteID;

//备忘录内容
@property (nonatomic,copy) NSString *noteContent;

//备忘录时间
@property (nonatomic,copy) NSString  *noteTime;


+(instancetype)modelWith:(int)noteID content:(NSString *)noteContent time:(NSString *)noteTime;
@end
