//
//  YJMemorandumEditView.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/14.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJMemorandumEditView.h"
#import "YJMemorandum.h"
#import "YJMemorandumTool.h"
#import "YJTextView.h"

@interface YJMemorandumEditView()   <UITextViewDelegate>
{
   
}
@property (nonatomic,strong) YJTextView  *textView;


@end

@implementation YJMemorandumEditView

-(YJTextView *)textView{
    if(_textView==nil){
        YJTextView *textView=[[YJTextView alloc] init];
        textView.alwaysBounceVertical=YES;
        textView.frame=[UIScreen mainScreen].bounds;
        self.textView=textView;
       
        [self.view addSubview:textView];
    }
    return  _textView;
}

-(void)setModel:(YJMemorandum *)model{
    _model=model;
    
    if (model) {
        self.textView.text=model.noteContent;
    }
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    self.textView.delegate=self;
    self.hidesBottomBarWhenPushed=YES;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self initView];

    
}

-(void)initView{
    //导航条
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(complete)];
    
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.title=@"编辑";
    
    //输入框
    self.textView.placeholder=@"请输入文字...";
    self.textView.placeholderColor=[UIColor lightGrayColor];
    
    [self.textView becomeFirstResponder];
    
      //添加监听，控制完成按钮是否可点击
    [YJNotification addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self.textView];
    

    
}

-(void)textDidChange{
    self.navigationItem.rightBarButtonItem.enabled=[self.textView hasText];
    
}

-(void)complete{
    YJMemorandum *model=self.model;
    model.noteContent=self.textView.text;
    model.noteTime=[YJMemorandumTool getTodayDate];
    [YJMemorandumTool modifyModel:model];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)cancel{
    [self.textView endEditing:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 滑动隐藏键盘
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.textView endEditing:YES];
}
@end
