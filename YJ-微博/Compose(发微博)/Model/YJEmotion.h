//
//  YJEmotion.h
//  YJ-微博
//
//  Created by MACBOOK on 16/1/5.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJEmotion : NSObject

/*   表情文字描述   */
@property (nonatomic,copy) NSString *chs;

/*   表情png图片名  */
@property (nonatomic,copy) NSString *png;

/*  emoji的编码   */
@property (nonatomic,copy) NSString *code;
@end
