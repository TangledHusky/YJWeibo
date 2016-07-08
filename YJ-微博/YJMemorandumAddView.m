//
//  YJMemorandumAddView.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/14.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJMemorandumAddView.h"
#import "YJTextView.h"
#import "YJMemorandum.h"
#import "YJMemorandumTool.h"
#define YJNoteID @"NoteIdentifier"


@interface YJMemorandumAddView() <UITextViewDelegate>
{
     NSInteger NoteIdentifier;
}

@property (nonatomic,strong) YJTextView  *textView;

@end

@implementation YJMemorandumAddView

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


-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self initView];
    
    self.hidesBottomBarWhenPushed=YES;
    self.textView.delegate=self;

}

-(void)initView{
    //导航条
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(complete)];
    
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.title=@"添加";

    //输入框
    self.textView.placeholder=@"请输入文字...";
    self.textView.placeholderColor=[UIColor lightGrayColor];

    self.navigationItem.rightBarButtonItem.enabled=NO;
    //添加监听，控制完成按钮是否可点击
    [YJNotification addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self.textView];
    
    
    [self.textView becomeFirstResponder];
    
    //备忘录主键
    NSNumber *defaultId=[[NSUserDefaults standardUserDefaults] valueForKey:YJNoteID];
    if (!defaultId) {
        defaultId=@1;
    }
  
    NoteIdentifier=[defaultId integerValue]+1;
    
    
    
}

-(void)textDidChange{
    self.navigationItem.rightBarButtonItem.enabled=[self.textView hasText];
    
}

-(void)complete{
    if (self.textView.text.length>0) {
        YJMemorandum *model=[YJMemorandum modelWith:NoteIdentifier content:self.textView.text time:[YJMemorandumTool getTodayDate]];
        
      
        
        
        BOOL success=[YJMemorandumTool insertModel:model];
        if (success) {
            NSNumber *newNotoIdentifier=[NSNumber numberWithInteger:NoteIdentifier];
            [[NSUserDefaults standardUserDefaults] setValue:newNotoIdentifier forKey:YJNoteID];
            
        }
        
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"请输入文字" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            YJLog(@"取消");
        }];
                                      
        UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            YJLog(@"确定");
        }];
        
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    
    }
    
    
    
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
