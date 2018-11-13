//
//  YSCouponDetailViewController.m
//  PXH
//
//  Created by yu on 2017/8/29.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCouponDetailViewController.h"
#import "YSProductCommentViewController.h"
#import "YSImagesViewController.h"
#import "YSCouponHeaderView.h"
#import "YSCommentTableViewCell.h"
#import <WebKit/WebKit.h>
#import <MediaPlayer/MediaPlayer.h>

#import "YSLifecircleService.h"

@interface YSCouponDetailViewController ()<WKNavigationDelegate>
{
    UIView *whiteView;
}
@property (nonatomic, strong) YSCouponHeaderView    *headerView;

@property (nonatomic, strong) YSProductDetail       *detail;

@property (nonatomic, strong) WKWebView     *webView;

@property (nonatomic, strong) UIView    *footerView;

@property (nonatomic, strong) UIButton *button;

@end

@implementation YSCouponDetailViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"点击图片展开" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"电子券详情";
    
    [self setup];
    [self fetchProductDetail];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jumpToImageController:) name:@"点击图片展开" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rechangeAction) name:@"兑换电子券" object:nil];
}

#pragma mark - 电子券兑换
- (void)rechangeAction
{
    [YSLifecircleService couponExchange:_coupon.ID completion:^(id result, id error) {
        if (!error) {
            [self judgeLoginActionWith:4];
            self.button.userInteractionEnabled = YES;
        }
    }];
}

#pragma mark - 跳转到大图页面
- (void)jumpToImageController:(NSNotification *)obj
{
    NSDictionary *dic = (NSDictionary *)obj.object;
    YSImagesViewController *vc = [[YSImagesViewController alloc]init];
    vc.dic = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setup {
    
    WS(weakSelf);
    self.tableView.estimatedRowHeight = 100.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[YSCommentTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _headerView = [[YSCouponHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 500)];
    [_headerView recalculateHeight];
    self.tableView.tableHeaderView = _headerView;
    
    _footerView = [self createFooterView];
    self.tableView.tableFooterView = _footerView;
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-50);
    }];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.height.mas_equalTo(50);
    }];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.layer.cornerRadius = 2;
    _button.clipsToBounds = YES;
    if (_coupon.isExchange) {
        _button.backgroundColor = [UIColor grayColor];
        [_button setTitle:@"已兑换" forState:UIControlStateNormal];
    }else {
        _button.backgroundColor = MAIN_COLOR;
        [_button setTitle:@"立即兑换" forState:UIControlStateNormal];
    }
    _button.titleLabel.font = [UIFont systemFontOfSize:14];
    [_button addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {

        if (_coupon.isExchange == 1) {
            return;
        }
        [weakSelf alertAction];
        weakSelf.button.userInteractionEnabled = NO;
        
    }];
    [bottomView addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(75);
        make.centerY.offset(0);
        make.right.offset(-5);
    }];
    
    UILabel *integral = [UILabel new];
    integral.font = [UIFont systemFontOfSize:18];
    integral.textColor = MAIN_COLOR;
    integral.text = [NSString stringWithFormat:@"%@积分", _coupon.score];
    [bottomView addSubview:integral];
    [integral mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(10);
    }];
    
    UILabel *expiredLabel = [UILabel new];
    expiredLabel.font = [UIFont systemFontOfSize:13];
    expiredLabel.textColor = HEX_COLOR(@"#999999");
    expiredLabel.text = [NSString stringWithFormat:@"有效期至 %@", _coupon.endTime];
    [bottomView addSubview:expiredLabel];
    [expiredLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.equalTo(integral.mas_right).offset(18);
    }];
}

- (void)alertAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确认兑换吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       self.button.userInteractionEnabled = YES;
        
    }];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self rechangeAction];
    }];
    [alert addAction:cancel];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}

- (void)viewAction:(UIButton *)button
{
    if (button.tag == 0) {
        [whiteView removeFromSuperview];
    } else {
        [whiteView removeFromSuperview];
        [YSLifecircleService couponExchange:_coupon.ID completion:^(id result, id error) {
            [self judgeLoginActionWith:4];
        }];
    }
}

- (UIView *)createFooterView {
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    self.tableView.tableFooterView = view;
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    view1.backgroundColor = BACKGROUND_COLOR;
    [view addSubview:view1];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39 / 2.0, kScreenWidth, 1)];
    lineView.backgroundColor = LINE_COLOR;
    [view1 addSubview:lineView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 80) / 2.0, 0, 80, 40)];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = HEX_COLOR(@"#666666");
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = BACKGROUND_COLOR;
    label.text = @"电子券详情";
    [view1 addSubview:label];
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, 0)];
    _webView.scrollView.scrollEnabled = NO;
    _webView.navigationDelegate = self;
    _webView.userInteractionEnabled = NO;
    [view addSubview:_webView];
    
    return view;
}
//查看所有评价
- (void)checkAllComment {
    YSProductCommentViewController *vc = [YSProductCommentViewController new];
    vc.productId = _detail.couponId;
    [self.navigationController pushViewController:vc animated:YES];
}

//获取优惠券详情
- (void)fetchProductDetail {
    
    [YSLifecircleService fetchCouponDetail:_coupon.ID completion:^(id result, id error) {
        _detail = result;
        
        _headerView.detail = _detail;
        [_headerView recalculateHeight];
        self.tableView.tableHeaderView = _headerView;
        
        [self.tableView reloadData];
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_detail.detailUrl]]];
    }];    
}

#pragma mark - router Event
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:kButtonDidClickRouterEvent]) {
        NSInteger type = [userInfo[kButtonDidClickRouterEvent] integerValue];
        
        if (type == 3) {
            YSProductImage *image = userInfo[@"model"];
            
            if (image.url && image.url.length > 0) {
                MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:image.url]];
                [self presentMoviePlayerViewControllerAnimated:player];
            }
        }
    }
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_detail.comments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YSCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.comment = _detail.comments[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"header"];
        headerView.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = HEX_COLOR(@"#333333");
        label.text = @"用户评价";
        [headerView.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(headerView.contentView);
            make.left.offset(10);
        }];
        
        UILabel *countLabel = [UILabel new];
        countLabel.font = [UIFont systemFontOfSize:15];
        countLabel.textColor = HEX_COLOR(@"#666666");
        countLabel.text = @"(0)";
        countLabel.tag = 10;
        [headerView.contentView addSubview:countLabel];
        [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(headerView.contentView);
            make.left.equalTo(label.mas_right);
        }];
    }
    
    UILabel *label = [headerView.contentView viewWithTag:10];
    label.text = [NSString stringWithFormat:@"(%zd)", _detail.commentCount];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
    if (!footerView) {
        footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"footer"];
        footerView.contentView.backgroundColor = [UIColor whiteColor];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button jm_setCornerRadius:1 withBorderColor:HEX_COLOR(@"#f46b10") borderWidth:1];
        [button setTitleColor:HEX_COLOR(@"#f46b10") forState:UIControlStateNormal];
        [button setTitle:@"查看更多评论" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(checkAllComment) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(footerView);
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(110);
        }];
    }
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50.f;
}

#pragma mark - web Delegate
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    WS(weakSelf);
    
    [webView evaluateJavaScript:@"Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight)"
              completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                  if (!error) {
                      NSNumber *height = result;
                      CGFloat maxHeight = [height doubleValue];
                      
                      weakSelf.webView.height = maxHeight;
                      weakSelf.footerView.height = maxHeight + 40;
                      weakSelf.tableView.tableFooterView = weakSelf.footerView;
                  }
              }];
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
