//
//  JYWebController.m
//  PXH
//
//  Created by LX on 2018/6/1.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYWebController.h"

#import <WebKit/WebKit.h>

#define ScreenH [UIScreen mainScreen].bounds.size.height

static CGFloat const progressViewHeight = 2;

@interface JYWebController () <WKNavigationDelegate, WKUIDelegate>

/// navTitleLab
@property (nonatomic, strong) UILabel   *navLabel;

/// WKWebView
@property (nonatomic, strong) WKWebView *wkWebView;
/// 进度条
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation JYWebController

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kStatusBarHeight-kNavigationBarHeight)];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        // KVO
        [self.wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:nil];
        [self.view addSubview:_wkWebView];
    }
    return _wkWebView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.trackTintColor = [UIColor clearColor];
        // 高度默认有导航栏且有穿透效果
//        _progressView.frame = CGRectMake(0, ((ScreenH == 812)?88.f:64.f), self.view.frame.size.width, progressViewHeight);
        _progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width, progressViewHeight);
        // 设置进度条颜色
        _progressView.tintColor = [UIColor greenColor];
//        _progressView.dk_tintColorPicker = DKColorPickerWithKey();
        
        [self.view addSubview:_progressView];
    }
    return _progressView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    if (@available(iOS 11.0, *)) {
//        self.wkWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }else{
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    [self setUpNav];
    
    [self loadRequest:self.urlString];
    
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    _navLabel = navigationLabel;
}

- (void)loadRequest:(NSString *)urlStr
{
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}


/// KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        self.progressView.alpha = 1.0;
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        if(self.wkWebView.estimatedProgress >= 0.97) {
            [UIView animateWithDuration:0.1 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.progressView.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0 animated:NO];
            }];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark
#pragma mark ----- <WKNavigationDelegate> -----
/// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
   
}

/// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
}

/// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.navLabel.text = (webView.title && webView.title.length) ? webView.title:self.navTitle;
    
    self.progressView.alpha = 0.0;
}

/// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    self.progressView.alpha = 0.0;
}


/// dealloc
- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

-(void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
}

-(void)setNavTitle:(NSString *)navTitle
{
    _navTitle = navTitle;
}

@end
