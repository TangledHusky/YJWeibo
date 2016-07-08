//
//  YJSearchBar.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/22.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "YJSearchBar.h"

@implementation YJSearchBar


-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.background=[UIImage imageNamed:@"searchbar_textfield_background"];
        
        self.placeholder=@"请输入搜索条件";
        self.font=[UIFont systemFontOfSize:13];
        
        UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        image.width=30;
        image.height=30;
        //icon居中
        image.contentMode=UIViewContentModeCenter;
        self.leftView=image;
        self.leftViewMode=UITextFieldViewModeAlways;

    
    }
    return  self;
}


+(instancetype)searchBar{
    return [[self alloc] init];
    
}
@end
