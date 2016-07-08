//
//  userAccount.h
//  YJ-微博
//
//  Created by MACBOOK on 15/12/25.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userAccount : NSObject <NSCoding>
@property (nonatomic,copy) NSString *access_token;
@property (nonatomic,copy) NSString *expires_in;
@property (nonatomic,copy) NSString *uid;
@property (nonatomic,strong) NSDate *expires_time;
@property (nonatomic,copy) NSString *name;


+(instancetype)accountWithDict:(NSDictionary *)dict;

@end
