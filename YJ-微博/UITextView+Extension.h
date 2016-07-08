//
//  UITextView+Extension.h
//  YJ-微博
//
//  Created by MACBOOK on 16/1/11.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)

-(void)insertAttributeText:(NSAttributedString *)text;

-(void)insertAttributeText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *attributeText))settingBlock;
@end
