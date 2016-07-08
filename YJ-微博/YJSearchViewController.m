//
//  YJSearchViewController.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/12.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJSearchViewController.h"

@interface YJSearchViewController ()    <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation YJSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupNav];
    
    [self loadContent:@"http://www.baidu.com"];
  
}

-(void)setupNav{
    
    //设置右边不可点击
    self.navigationItem.rightBarButtonItem=nil;
    self.hidesBottomBarWhenPushed=YES;

    self.navigationItem.title=@"百度搜索";

    
}

-(void)loadContent:(NSString *)urlStr{
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - webview代理

//网页加载完后，oc控制js，使网页按照自己需求显示
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //NSString *HTML=@"alert('这是百度');";
//    [webView stringByEvaluatingJavaScriptFromString:HTML];

    
    NSMutableString *HTML=[NSMutableString string];
    [HTML appendString:@"var body=document.body.innerHTML;"];
    
    
    NSString *str= [webView stringByEvaluatingJavaScriptFromString:HTML];
    YJLog(@"%@",str);
    
}


//拦截url，可以用来做js控制oc代码，比如网页上的拍照按钮，可以实现电机调用oc的拍照功能
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}
@end
