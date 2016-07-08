//
//  testObject.h
//  YJ-微博
//
//  Created by MACBOOK on 16/1/16.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//  用于表示tableview分组的三种内容：标题、内容、描述

#import <Foundation/Foundation.h>

@interface testObject : NSObject


@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,strong) NSArray  *contentArray;

@end
