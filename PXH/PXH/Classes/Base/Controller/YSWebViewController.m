//
//  YSWebViewController.m
//  PXH
//
//  Created by yu on 2017/8/22.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSWebViewController.h"

#import <WebKit/WebKit.h>

@interface YSWebViewController ()

@property (nonatomic, strong) WKWebView     *webView;

@end

@implementation YSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [WKWebView new];
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
