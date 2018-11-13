//
//  JJInvitationViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/24.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJInvitationViewController.h"
#import "JYUMShareManger.h"
#import "JJInvitationListViewController.h"
#import "JJShareQRCodeView.h"

@interface JJInvitationViewController ()<UIWebViewDelegate>


@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIView *countView;
@property (nonatomic,strong)UILabel *countLabel;
@property (nonatomic,strong)UILabel *peopleLabel;
@property (nonatomic,strong)UILabel *codeLabel;
@property (nonatomic,strong)UIWebView *web;
@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UIButton *shareBtn;

@property (nonatomic,strong)JJShareModel *model;

@property (nonatomic,strong)NSString *shareMessage;

@end

@implementation JJInvitationViewController

- (void)viewWillAppear:(BOOL)animated
{
        //    如果不想让其他页面的导航栏变为透明 需要重置
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:nil];
        self.navigationController.navigationBar.translucent = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
    [self setUpNav];
    [self setUI];
}

- (void)setUI{
    
    
    
    UILabel *label1 = [UILabel new];
    label1.textColor = HEX_COLOR(@"#ffffff");
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:16];
    label1.text = @"我的邀请码";
    [self.containerView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView).offset(10);
        make.left.right.equalTo(self.containerView);
        make.height.mas_equalTo(21);
    }];
    
    
    self.codeLabel = [UILabel new];
    self.codeLabel.textColor = [UIColor whiteColor];
    self.codeLabel.font = [UIFont systemFontOfSize:24];
    self.codeLabel.textAlignment = NSTextAlignmentCenter;
    self.codeLabel.text = @"";
    [self.containerView addSubview:self.codeLabel];
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(5);
        make.centerX.equalTo(self.containerView);
        make.height.mas_equalTo(40);
        make.left.right.equalTo(self.containerView);
    }];
    
    
    UILabel *label3 = [UILabel new];
    label3.textColor = GoldColor;
    label3.font = [UIFont systemFontOfSize:18];
    label3.layer.cornerRadius = 3.0f;
    label3.layer.masksToBounds = YES;
    label3.layer.borderColor = GoldColor.CGColor;
    label3.layer.borderWidth = 1.0f;
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = @"复制";
    
    [self.containerView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeLabel.mas_bottom).offset(5);
        make.width.mas_offset(60);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.containerView);
       
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(copyString)];
    label3.userInteractionEnabled = YES;
    [label3 addGestureRecognizer:tap];
    
    [self.containerView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(10);
        make.right.equalTo(self.containerView).offset(-10);
        make.top.equalTo(label3.mas_bottom).offset(20);
        make.bottom.equalTo(self.containerView).offset(-50);
    }];
    
    [self.bgView addSubview:self.peopleLabel];
    [self.peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView);
        make.top.equalTo(self.bgView).offset(20);
        make.height.mas_offset(20);
    }];
    
    
    [self.bgView addSubview:self.countView];
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView);
        make.top.equalTo(self.peopleLabel.mas_bottom).offset(10);
        make.width.mas_offset(160);
        make.height.mas_offset(60);
       
    }];
    
    UILabel *label4 = [[UILabel alloc]init];
    label4.text = [NSString stringWithFormat:@"累计获得%@",@"算力"];
    label4.font = [UIFont systemFontOfSize:15];
    label4.textAlignment = NSTextAlignmentCenter;
    [self.countView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.countView);
        make.top.equalTo(self.countView).offset(10);
        make.height.mas_offset(15);
    }];
    
    
    [self.countView addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.countView);
        make.top.equalTo(label4.mas_bottom).offset(10);
        make.height.mas_offset(15);
    }];

    
    self.web = [[UIWebView alloc] init];
    self.web.delegate = self;
    self.web.scrollView.scrollEnabled = NO;
    [self.bgView addSubview:self.web];
    [self.web mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countView.mas_bottom).offset(20);
        make.left.right.equalTo(self.bgView);
        make.height.mas_offset(200);
        make.bottom.equalTo(self.bgView);
    }];
//    NSString *htmlString = self.webUrl;
  
    
    
    [self.view addSubview:self.shareBtn];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_offset(50);
    }];
    
    
    
 
    
 
    [self query];
    
}

- (void)query{
    
    [JJMineService JJMobileMemberRecommendBeiTaCompletion:^(id result, id error) {
        
        JJShareModel *model = result;
        
        self.model = model;
        
        self.codeLabel.text = model.recCode;
        self.peopleLabel.text = [NSString stringWithFormat:@"邀请好友数:%@",model.invitationNumber];
        self.countLabel.text = model.reward;
        
        NSString *htmlString = model.invitationUrl;
        [self.web  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:htmlString]]];
        
        self.shareMessage = model.message;
        
    }];
    
    

}

- (void)copyString{
    
    
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    
    //  有些时候只想取UILabel的text中的一部分
    if (objc_getAssociatedObject(self, @"expectedText")) {
        pBoard.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        
        //  因为有时候 label 中设置的是attributedText
        //  而 UIPasteboard 的string只能接受 NSString 类型
        //  所以要做相应的判断
        pBoard.string = self.codeLabel.text;
        [MBProgressHUD showText:@"复制邀请码成功" toContainer:self.view];
        
    }
    
    
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"邀请好友";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    UIButton *selectBtn = [[UIButton alloc]init];
    selectBtn.frame = CGRectMake(0, 0, 80, 35);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:selectBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [selectBtn setTitleColor:HEX_COLOR(@"#ffffff") forState:UIControlStateNormal];
    [selectBtn setTitle:@"邀请记录" forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selctViewShow:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selctViewShow:(UIButton *)btn{
    
    JJInvitationListViewController *vc = [[JJInvitationListViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.web = nil;
    [self cleanCacheAndCookie];
    
    
}

- (void)share:(UIButton *)btn{
    
    NSString *webUrl = self.model.shareUrl;
    JJShareQRCodeView *bv = [[JJShareQRCodeView alloc]initWithProduct:webUrl limitID:webUrl];
    bv.JJShareQRCodeViewClick = ^(UIImage *image) {
            NSDictionary *data = @{@"title":@"机界注册邀请有奖",
                                   @"descr":self.shareMessage,
                                   @"original":image,
                                   @"weburl":webUrl,
                                   };
            [[JYUMShareManger sharedManger] customImageShareWithVC:self platformType:PlatformType_All imgUrlData:data];
    };
    [bv show];
}


/**清除缓存和cookie*/
- (void)cleanCacheAndCookie{
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}



- (void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat webViewHeight =[[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"]floatValue];
    [self.web mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(webViewHeight+10);
        make.bottom.equalTo(self.bgView).offset(-10);
    }];
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 4.0f;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UILabel *)peopleLabel
{
    if (!_peopleLabel) {
        _peopleLabel = [[UILabel alloc]init];
        _peopleLabel.font = [UIFont systemFontOfSize:18];
        _peopleLabel.textColor = HEX_COLOR(@"#333333");
        _peopleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _peopleLabel;
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.font = [UIFont systemFontOfSize:16];
        _countLabel.textColor = GoldColor;
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}

- (UIView *)countView
{
    if (!_countView) {
        _countView = [[UIView alloc]init];
        _countView.layer.borderWidth = 1.0f;
        _countView.layer.borderColor = GoldColor.CGColor;
    }
    return _countView;
}

- (UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc]init];
        _shareBtn.backgroundColor = GoldColor;
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_shareBtn setTitle:@"马上邀请好友加入" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:HEX_COLOR(@"#ffffff") forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _shareBtn;
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
