//
//  YJUser.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/25.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "YJUser.h"

@implementation YJUser

//+(instancetype)userWithDict:(NSDictionary *)dict{
//    YJUser *user=[[YJUser alloc] init];
//    user.idStr=dict[@"idStr"];
//    user.name=dict[@"name"];
//    user.profile_image_url=dict[@"profile_image_url"];
//    user.desc=dict[@"description"];
//    
//    return  user;
//    
//}
-(void)setMbtype:(int)mbtype{
    _mbtype=mbtype;
    self.vip=mbtype>2;
    
}


-(BOOL)isVip{
    return  self.mbrank>2;
    
}
@end
