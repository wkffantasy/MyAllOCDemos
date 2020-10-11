//
//  WebViewController.m
//  WKFAllMyDemos
//
//  Created by 王孔飞 on 2017/7/11.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "WebViewController.h"

#import <WebKit/WebKit.h>

@interface WebViewController ()<WKNavigationDelegate,WKUIDelegate>

@property(nonatomic,weak) WKWebView * webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    [self setupWebView];
}

- (void)setupWebView {
    self.view.backgroundColor = [UIColor redColor];
    WKWebView * webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    _webView = webView;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    [self.view addSubview:webView];
   
   
}

#pragma WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"didStartProvisionalNavigation");
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"didCommitNavigation");
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"didFinishNavigation ");
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"didFailNavigation %@",error);
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"didReceiveServerRedirectForProvisionalNavigation");
}
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//    NSLog(@"decidePolicyForNavigationAction");
//}
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//    NSLog(@"decidePolicyForNavigationResponse");
//}



@end
