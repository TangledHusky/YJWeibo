//
//  YJStatusToolbar.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/30.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "YJStatusToolbar.h"
#import "YJStatuses-WeiBo.h"

@interface YJStatusToolbar()
@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) NSMutableArray *dividers;

@property (nonatomic,weak) UIButton  *retweetBtn;
@property (nonatomic,weak) UIButton  *commentBtn;
@property (nonatomic,weak) UIButton  *attitudeBtn;

@end


@implementation YJStatusToolbar
-(NSMutableArray *)btns{
    if(_btns==nil){
        _btns=[NSMutableArray array];
    }
    return  _btns;
}

-(NSMutableArray *)dividers{
    if(_dividers==nil){
        _dividers=[NSMutableArray array];
    }
    return  _dividers;
}


+(instancetype)toolbar{
    
    return  [[self alloc] init];
}


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        //添加按钮
        [self setupToolbarBtnWithTitle:@"转发" image:@"timeline_icon_retweet"];
        [self setupToolbarBtnWithTitle:@"评论" image:@"timeline_icon_comment"];
        [self setupToolbarBtnWithTitle:@"赞" image:@"timeline_icon_unlike"];
        
        //添加分割线
        [self setupDivider];
        [self setupDivider];
    }
    return  self;
}


-(void)setupToolbarBtnWithTitle:(NSString *)titleName image:(NSString *)imageName{
    //设置三个按钮
    UIButton *btn=[[UIButton alloc] init];
    [btn setTitle:titleName forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:12];
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];

    [self addSubview:btn];
    [self.btns addObject:btn];
    
}

//添加分割线
-(void)setupDivider{
    
    UIImageView *imgV=[[UIImageView alloc] init];
    imgV.image=[UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:imgV];
    [self.dividers addObject:imgV];
    
}

//重新布局
-(void)layoutSubviews{
    
    //设置按钮
    int count=self.btns.count;
    CGFloat btnW=self.width/count;
    for (int i=0; i<count; i++) {
        UIButton *btn=self.btns[i];
        btn.x=i*btnW;
        btn.y=0;
        btn.width=btnW;
        btn.height=self.height;
    }
    
    //设置分割线
    int dividerCount=self.dividers.count;
    for (int i=0; i<dividerCount; i++) {
        UIImageView *divider=self.dividers[i];
        divider.width=1;
        divider.height=self.height;
        divider.x=(i+1)*btnW;
        divider.y=0;
    }
}


//重写set方法
-(void)setStatus:(YJStatuses_WeiBo *)status{
    _status=status;
 
    
    /**
     *  如果数量大于1w，保留一位小数显示
     *  如果小于1w，直接显示
     *  否则如果为0，显示文字
     */
  
    [self setBtnCount:self.retweetBtn title:@"转发" count:status.reposts_count];
        [self setBtnCount:self.commentBtn title:@"评论" count:status.comments_count];
        [self setBtnCount:self.attitudeBtn title:@"赞" count:status.attitudes_count];
}


-(void)setBtnCount:(UIButton *)btn title:(NSString *)title count:(int)count{
       if (count) {
        if (count>10000) {
            double wan=count/10000.0;
            title=[NSString stringWithFormat:@"%.1f万",wan];
                   }else {
           title=[NSString stringWithFormat:@"%d",count];
           
        }
       
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
    
}

@end
