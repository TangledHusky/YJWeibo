//
//  YJStatuses-WeiBo.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/25.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "YJStatuses-WeiBo.h"
#import "MJExtension.h"
#import "YJPhotos.h"
#import "RegexKitLite.h"
#import "YJUser.h"

@implementation YJStatuses_WeiBo

//将数组转为对象
-(NSDictionary *)objectClassInArray{
    return @{@"pic_urls":[YJPhotos class]};
}


-(void)setSource:(NSString *)source{
    _source=source;
    //截取a标签的文字
    //<a href="http://app.weibo.com/t/feed/1tqBja" rel="nofollow">360安全浏览器</a>

    NSRange range;
    range.location=[source rangeOfString:@">"].location+1;
    range.length=[source rangeOfString:@"</"].location-range.location;
    
    //YJLog(@"%@  -  %d  -  %d",source,range.location,range.length);
//    _source=[NSString stringWithFormat:@"来自%@", [source substringWithRange:range]];
    _source=@"来自微博";
    
}


-(void)setText:(NSString *)text{
    _text=[text copy];
    
    //给属性文字赋值
    self.attributeText=[self attributedTextWithText:text];
    
}

//根据纯文字转换成属性文字
-(NSAttributedString *)attributedTextWithText:(NSString *)text{
//    NSString *pattern=@"";
//
//    NSRegularExpression *regex=[[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
//    [regex matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    
    NSMutableAttributedString *attributeText=[[NSMutableAttributedString alloc] initWithString:text];
    
    // 表情的规则([字母、数字、中文都行])
    NSString *emotionPattern = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    // @的规则
    NSString *atPattern =@"@[a-zA-Z0-9\\u4e00-\\u9fa5]+";
    // #话题#的规则
    NSString *topicPattern =@"#[a-zA-Z0-9\\u4e00-\\u9fa5]+#";
    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    
    //遍历text,这里导入三方文件:RegexKitLite，并且1、在build phases comlile source,根据rege关键字，添加-fno-objc-arc 2、在动态lib添加，根据libicuo关键字添加libicucore.tbd
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length==0) {
            return ;
        }
        [attributeText addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:*capturedRanges];
    }];
    
    
    return  attributeText;
    
}


//设置转发微博的属性文字
-(void)setRetweeted_status:(YJStatuses_WeiBo *)retweeted_status{
    _retweeted_status=retweeted_status;
    NSString *content=[NSString stringWithFormat:@"@%@: %@",retweeted_status.user.name,retweeted_status.text];
    self.retweetedAttributeText=[self attributedTextWithText:content];
    
}


//重写get方法，处理时间的格式
-(NSString *)created_at{
    /**
     *  今年
        1>今天
            * 一分钟内：刚刚
            * 1分钟~59分钟：几分钟之前
            * 大于60分钟：几小时前
        2>昨天
            * 昨天 HH:mm
        3>其他
            * MM:dd HH:mm
     *  非今年
     *      * yyyy-MM-dd HH:mm:ss
     */
    
    
    NSDateFormatter *fmt=[[NSDateFormatter alloc] init];
    fmt.dateFormat=@"EEE MM dd HH:mm:ss Z yyyy";
    NSDate *createDate=[fmt dateFromString:_created_at];
  
    return [self convertCreateDate:createDate];
}

-(NSString *)convertCreateDate:(NSDate *)createDate{
    
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSDate *now=[NSDate date];
    NSCalendarUnit unit=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *components=[calendar components:unit fromDate:createDate toDate:now options:0];
    //YJLog(@"%@",components);
    
    NSDateFormatter *fmt=[[NSDateFormatter alloc] init];

    if ([self isThisYear:createDate]) {
        if ([self isYestoday:createDate]) {
            //返回昨天
            fmt.dateFormat=@"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
            
        }else if ([self isToday:createDate]){
            //今天
            //大于1个小时
            if (components.hour>=1) {
                return [NSString stringWithFormat:@"%d小时前",components.hour];
                
            }else if(components.minute>1){
                //大于一分钟
                return [NSString stringWithFormat:@"%d分钟前",components.minute];
            }else{
                //一分钟内
                return @"刚刚";
            }

        }
        else{
            //今年其他时间
            fmt.dateFormat=@"MM:dd HH:mm";
            return  [fmt stringFromDate:createDate];
            
        }
    }else{
        //今年之前
        fmt.dateFormat=@"yyyy-MM-dd HH:mm:ss";
        return [fmt stringFromDate:createDate];
    }
    
    
    return [NSString stringWithFormat:@"%@",createDate];
    
}


//
-(BOOL)isThisYear:(NSDate *)date{
    NSCalendar *cld=[NSCalendar currentCalendar];
    NSDateComponents *cmpCreate=[cld components:NSCalendarUnitYear fromDate:date];
    NSDateComponents *cmpNow=[cld components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return  cmpCreate.year==cmpNow.year;
    
}

-(BOOL)isToday:(NSDate *)date{
    NSDateFormatter *fmt=[[NSDateFormatter alloc] init];
    NSDate *nowDate=[NSDate date];
    fmt.dateFormat=@"yyyy-MM-dd";
    NSString *create=[fmt stringFromDate:date];
    NSString *now=[fmt stringFromDate:nowDate];

    return [create isEqualToString:now];
}

-(BOOL)isYestoday:(NSDate *)date{
    //先把createdate和now分别去除时分秒，再去比较，去除的原因是排除如有时不是同一天，但比较的hours是0这种特殊情况
    NSDateFormatter *fmt=[[NSDateFormatter alloc] init];
    NSDate *nowDate=[NSDate date];
    fmt.dateFormat=@"yyyy-MM-dd";
    NSString *create=[fmt stringFromDate:date];
    NSString *now=[fmt stringFromDate:nowDate];
    
    //计算时间差：年、月、日
    NSCalendar *cld=[NSCalendar currentCalendar];
    NSCalendarUnit unit=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    
    NSDateComponents *cmp=[cld components:unit fromDate:[fmt dateFromString:create] toDate:[fmt dateFromString:now] options:0];
    
    return cmp.year==0&&cmp.month==0&&cmp.day==1;

    
}

@end
