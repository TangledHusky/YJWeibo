//
//  testNSCoding-save.h
//  YJ-微博
//
//  Created by MACBOOK on 16/1/16.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface testNSCoding_save : NSObject <NSCoding>

@property (nonatomic,assign) int  ID;
@property (nonatomic,copy) NSString *name;

@end
