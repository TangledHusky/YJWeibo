//
//  userAccount.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/25.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "userAccount.h"

@implementation userAccount


+(instancetype)accountWithDict:(NSDictionary *)dict{
    userAccount *account=[[userAccount alloc] init];
    account.access_token=dict[@"access_token"];
    account.expires_in=dict[@"expires_in"];
    account.uid=dict[@"uid"];
    
    //保存前，添加保持时间，为了下次读取对比是否过期
    NSDate *saveTime=[NSDate date];
    account.expires_time=saveTime;

    
    return  account;
    
}


/**
 当一个对象要归档进沙盒时，就回调用此方法
 */
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
     [aCoder encodeObject:self.expires_time forKey:@"expires_time"];
     [aCoder encodeObject:self.name forKey:@"name"];
}

/**
 解档时调用
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init])
    {
        self.access_token=[aDecoder decodeObjectForKey:@"access_token"];
          self.expires_in=[aDecoder decodeObjectForKey:@"expires_in"];
          self.uid=[aDecoder decodeObjectForKey:@"uid"];
         self.expires_time=[aDecoder decodeObjectForKey:@"expires_time"];
          self.name=[aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}



@end
