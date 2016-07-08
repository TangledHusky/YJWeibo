//
//  YJUserAccountTool.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/25.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "YJUserAccountTool.h"


#define YJAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation YJUserAccountTool


+(void)saveAccount:(userAccount *)account{
      
    //自定义对象的存储必须:NSKeyArchive
    [NSKeyedArchiver archiveRootObject:account toFile:YJAccountPath];

}


/**
获取账号信息，并且判断有效期，如果过期，返回nil
*/
+(userAccount *) getAccount{
    
   
    userAccount *dictAccount= [NSKeyedUnarchiver unarchiveObjectWithFile:YJAccountPath];
    
    //判断是否过期
    NSDate *now=[NSDate date];
    long long interval=[dictAccount.expires_in longLongValue];
    NSDate *expireDate=[dictAccount.expires_time dateByAddingTimeInterval: interval];
    
    //typedef NS_ENUM(NSInteger, NSComparisonResult) {NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending};
    NSComparisonResult result=[expireDate compare:now];
    if (result!=NSOrderedDescending) {
        //表示过期
        return  nil;
        
    }
    

    return dictAccount;
}
@end
