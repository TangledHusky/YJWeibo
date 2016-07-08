//
//  YJUserAccountTool.h
//  YJ-微博
//
//  Created by MACBOOK on 15/12/25.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "userAccount.h"

@interface YJUserAccountTool : NSObject


+(void)saveAccount:(userAccount *)account;


+(userAccount *)getAccount;

@end
