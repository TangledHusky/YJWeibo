//
//  YJStatuses-WeiBo.h
//  YJ-微博
//
//  Created by MACBOOK on 15/12/25.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YJUser;
@class YJStatuses_WeiBo;


@interface YJStatuses_WeiBo : NSObject


/** 	字符串型的微博ID   */
@property (nonatomic,copy) NSString *idstr;
/** 	微博信息内容  */
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSAttributedString *attributeText;


/** 	微博来源    */
@property (nonatomic,copy) NSString *source;
/** 	微博作者的用户信息字段 */
@property (nonatomic,strong) YJUser *user;
/**		微博创建时间*/
@property (nonatomic, copy) NSString *created_at;
/**		微博配图*/
@property (nonatomic, strong) NSArray *pic_urls;


/**		转发微博*/
@property (nonatomic, strong) YJStatuses_WeiBo *retweeted_status;
@property (nonatomic,copy) NSAttributedString *retweetedAttributeText;

/** 转发数   */
@property (nonatomic,assign) int  reposts_count;
/** 评论数   */
@property (nonatomic,assign) int  comments_count;
/** 赞数   */
@property (nonatomic,assign) int  attitudes_count;


//+(instancetype)statusesWithDict:(NSDictionary *)dict;

@end
