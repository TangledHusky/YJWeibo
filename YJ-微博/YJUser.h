//
//  YJUser.h
//  YJ-微博
//
//  Created by MACBOOK on 15/12/25.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    YJUserVerifiedTypeNone=-1,  //没有认证

    YJUserVerifiedTypePersonal=0,       //个人认证

    YJUserVerifiedTypeEnterprice=2,      //企业官方：scdn、网易客户端等

    YJUserVerifiedTypeMedia=3,      //媒体官方：杂志等

    YJUserVerifiedTypeWebsite=5,      //网站官方

    YJUserVerifiedTypeDaren=220      //微博达人
    
} YJUserVerifiedType;

@interface YJUser : NSObject
/**"id": 字符串型的用户UIDUID */
@property (nonatomic,copy) NSString *idStr;

/**"name": "友好显示名称"*/
@property (nonatomic,copy) NSString *name;

/**"description":用户个人描述 */
@property (nonatomic,copy) NSString *desc;

/**"profile_image_url": 用户头像地址（中图），50×50像素,*/
@property (nonatomic,copy) NSString *profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;

/** 会员等级 */
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign,getter=isVip) BOOL vip;

/** 用户认证等级 */
@property (nonatomic,assign) YJUserVerifiedType verified_type;

//+(instancetype)userWithDict:(NSDictionary *)dict;

@end
