//
//  YJOAuthViewController.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/24.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "YJOAuthViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "userAccount.h"
#import "YJUserAccountTool.h"
@interface YJOAuthViewController() <UIWebViewDelegate>

@end


@implementation YJOAuthViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIWebView *web=[[UIWebView alloc] init];
    web.delegate=self;
    
    web.frame=self.view.bounds;
    
    NSURL *url=[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3606942418&response_type=code&redirect_uri=https://api.weibo.com/oauth2/default.html"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [web loadRequest:request];
    
    [self.view addSubview:web];
    
    
}


-(void)webViewDidStartLoad:(UIWebView *)webView{
    YJLog(@"webViewDidStartLoad");
    [MBProgressHUD showMessage:@"正在加载中..."];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    YJLog(@"webViewDidFinishLoad");
    [MBProgressHUD hideHUD];

}

//获取每次url请求的值(拦截请求)
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //YJLog(@"%@",request.URL.absoluteString);
    //允许授权后，会返回一个code，这里取出code
    NSString *strUrl=request.URL.absoluteString;
    
    NSRange range=[strUrl rangeOfString:@"code="];
    if (range.length!=0) {
        NSString *code=[strUrl substringFromIndex:(range.location+range.length)];
        
        [self accessTokenWithCode:code];
        
        //阻止页面加载
        return  NO;
    }
    
    
    return YES;
}

-(void)accessTokenWithCode:(NSString *)code{
    /**
     URL：https://api.weibo.com/oauth2/access_token
     
     请求参数：
     client_id：申请应用时分配的AppKey
     client_secret：申请应用时分配的AppSecret
     grant_type：使用authorization_code
     redirect_uri：授权成功后的回调地址
     code：授权成功后返回的code
     */
    
    //1.请求管理者
    AFHTTPRequestOperationManager *manage=[AFHTTPRequestOperationManager manager];
    //默认就是json接受，可以不写
    //manage.responseSerializer=[AFJSONResponseSerializer serializer];
    
    //2.拼接请求参数
    NSMutableDictionary *dictParams=[NSMutableDictionary dictionary];
    
    dictParams[@"client_id"]=@"3606942418";
    dictParams[@"client_secret"]=@"95684df1051a0fb4182375d827f55968";
    dictParams[@"grant_type"]=@"authorization_code";
    dictParams[@"redirect_uri"]=@"https://api.weibo.com/oauth2/default.html";
    dictParams[@"code"]=code;

    //3.发送请求
    [manage POST:@"https://api.weibo.com/oauth2/access_token" parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //隐藏加载框
        [MBProgressHUD hideHUD];
                
        //这里为了便捷，可以将字典转换模型再存入
        userAccount *account=[userAccount accountWithDict:responseObject];
        [YJUserAccountTool saveAccount:account];
        
        
        //判断新特性，如果有新版本，仍要显示新特性-------------
        //这里要根据版本判断是否显示新特性
        [UIWindow switchRootController];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        YJLog(@"error-----%@",error);
        
        [MBProgressHUD hideHUD];
        
    }];
    
    
    
}

@end
