//
//  YSProductH5ViewController.m
//  PXH
//
//  Created by yu on 2017/8/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSProductH5ViewController.h"
#import "YSProductCollectionViewCell.h"
#import "YSProductDetailViewController.h"

#import <WebKit/WebKit.h>

//@interface YSCollectionHeaderView : UICollectionReusableView
//
//@property (nonatomic, assign) NSInteger isGroup;
//
//@end
//
//@implementation YSCollectionHeaderView
//
//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self initSubviews];
//    }
//    return self;
//}
//
//- (void)initSubviews {
//    self.backgroundColor = BACKGROUND_COLOR;
//
//    UIView *lineView = [UIView new];
//    lineView.backgroundColor = LINE_COLOR;
//    [self addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.offset(0);
//        make.left.right.offset(0);
//        make.height.mas_equalTo(1);
//    }];
//
//    UILabel *label = [UILabel new];
//    label.font = [UIFont systemFontOfSize:15];
//    label.textColor = HEX_COLOR(@"#666666");
//    label.textAlignment = NSTextAlignmentCenter;
//    label.backgroundColor = BACKGROUND_COLOR;
//    if (self.isGroup == 1) {
//        label.text = @"组合产品";
//    } else {
//        label.text = @"推荐产品";
//    }
//    [self addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
//        make.width.mas_equalTo(80);
//    }];
//}
//
//@end

@interface YSProductH5ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, WKNavigationDelegate>

@property (nonatomic, strong) UICollectionView  *collectionView;

@property (nonatomic, strong) WKWebView     *webView;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation YSProductH5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initSubviews];
    
}

- (void)initSubviews {
    
//    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.webView];
    
//    [self.collectionView registerClass:[YSCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    WS(weakSelf);
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.scrollView.mj_header endRefreshing];
        [weakSelf.superViewController scrollToTop];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉,返回宝贝详情" forState:MJRefreshStateIdle];
    [header setTitle:@"下拉,返回宝贝详情" forState:MJRefreshStatePulling];
    [header setTitle:@"释放,返回宝贝详情" forState:MJRefreshStateRefreshing];
    self.scrollView.mj_header = header;
}

- (void)setDetail:(YSProductDetail *)detail {
    
    _detail = detail;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_detail.detailUrl]]];
//    [self.collectionView reloadData];
}


- (void)setDetailJJ:(JJShopModel *)detailJJ
{
    
    _detailJJ = detailJJ;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_detailJJ.url]]];
    
    
}

#pragma mark - collectionView

//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return [_detail.products count];
//}
//
//- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    YSProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//
//    cell.product = _detail.products[indexPath.row];
//
//    return cell;
//}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        YSCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
//        headerView.isGroup = _detail.isGroup;
//        return headerView;
//    }
//    return nil;
//}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    YSProduct *product = _detail.products[indexPath.row];
//
//    YSProductDetailViewController *vc = [YSProductDetailViewController new];
//    vc.productId = product.productId;
//    [self.navigationController pushViewController:vc animated:YES];
//}

#pragma mark - web Delegate
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    WS(weakSelf);

    [webView evaluateJavaScript:@"Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight)"
              completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                  if (!error) {
                      NSNumber *height = result;
                      CGFloat maxHeight = [height doubleValue];
//
//                      // do with the height
////                      weakSelf.collectionView.contentInset = UIEdgeInsetsMake(maxHeight, 0, 0, 0);
//                      weakSelf.webView.frame = CGRectMake(0, -maxHeight, kScreenWidth, maxHeight);
                      weakSelf.scrollView.contentSize = CGSizeMake(0, maxHeight);
                      weakSelf.webView.frame = CGRectMake(0, 0, ScreenWidth, maxHeight);
                      [weakSelf.scrollView scrollToTop];
//                      weakSelf.collectionView.mj_header.ignoredScrollViewContentInsetTop = maxHeight;
                  }
    }];
}

#pragma void - view

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        
    }
    return _scrollView;
}

//- (UICollectionView *)collectionView {
//
//    if (!_collectionView) {
//        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
//        layout.minimumLineSpacing = 0;
//        layout.minimumInteritemSpacing = 0;
//        layout.headerReferenceSize = CGSizeMake(kScreenWidth, 40);
//        CGFloat itemWidth = (kScreenWidth - 5) / 2.0;
//        layout.itemSize = CGSizeMake(itemWidth, itemWidth + 73);
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//        _collectionView.delegate = self;
//        _collectionView.dataSource = self;
//        _collectionView.backgroundColor = BACKGROUND_COLOR;
//
//        [_collectionView registerClass:[YSProductCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
//    }
//    return _collectionView;
//}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        _webView.scrollView.scrollEnabled = NO;
        _webView.navigationDelegate = self;
        _webView.userInteractionEnabled = NO;
    }
    return _webView;
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
