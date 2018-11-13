//
//  YSProductDetailViewController.m
//  PXH
//
//  Created by yu on 2017/8/8.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSProductDetailViewController.h"
#import "YSProductDescViewController.h"
#import "YSProductH5ViewController.h"
#import "YSConfirmOrderViewController.h"
#import "YSMainTabBarViewController.h"
#import "YSWebViewController.h"

#import "YSButton.h"
#import "YSStandardPickerView.h"

#import "UIBarButtonItem+Sunday.h"
#import "UINavigationBar+YSLucency.h"
#import "AppDelegate.h"
#import "YSProductService.h"

#import "SDShareView.h"
#import "JJShopService.h"
#import "YSSteper.h"
#import "JJOrderSubmitViewController.h"

@interface YSProductDetailViewController ()
{
    BOOL state;
    UILabel *numlabel;
    NSString *num;
}
@property (nonatomic, strong) YSProductDetail   *productDetail;

@property (nonatomic, strong) JJShopModel   *productDetailJJ;

@property (nonatomic, strong) YSSteper      *steper;


@property (nonatomic, strong) YSProductDescViewController   *desc_vc;

@property (nonatomic, strong) YSProductH5ViewController     *h5_vc;

@property (nonatomic, strong) YSStandardPickerView  *pickerView;

@property (nonatomic, strong) SDShareView *share;



@end

@implementation YSProductDetailViewController



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.edgesForExtendedLayout = UIRectEdgeAll;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self setupNavigationBar];
    
    [self initSubviews];
//    [self fetchProductDetail];
//    [self fetchProductNum];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addSuccess:) name:@"购物车添加成功" object:nil];
    
    state = YES;
}

- (void)setupNavigationBar {
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"商品详情";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
//
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
//    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - 购物车添加成功
- (void)addSuccess:(NSNotification *)noti
{
    [self fetchProductNum];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"购物车改变数量" object:nil];
}

- (void)initSubviews {
 
    self.scrollView.scrollEnabled = YES;
    self.scrollView.pagingEnabled = NO;
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-100);
    }];
    
    UIView *footerView = [self createFooterView];
    [self.view addSubview:footerView];
    
    WS(weakSelf);
    _desc_vc = [YSProductDescViewController new];
    _desc_vc.superViewController = self;
    _desc_vc.titleShow = ^{
        weakSelf.navigationItem.title = @"商品详情";
    };
    _desc_vc.titleHidden = ^{
        weakSelf.title = nil;
    };
    [self addChildViewController:_desc_vc];
    [self.containerView addSubview:_desc_vc.view];
    
    _h5_vc = [YSProductH5ViewController new];
    _h5_vc.superViewController = self;
    [self addChildViewController:_h5_vc];
    [self.containerView addSubview:_h5_vc.view];
    
//    WS(weakSelf);
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.height.mas_equalTo(100);
    }];

    [_desc_vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(weakSelf.scrollView);
    }];
    
    [_h5_vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.height.mas_equalTo(weakSelf.scrollView);
        make.top.equalTo(_desc_vc.view.mas_bottom);
    }];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 分享
- (void)shareAction {
    
    if (state == YES) {
        if (!_share) {
            WS(weakSelf);
            self.share = [[SDShareView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
            self.share.selectPlatForm = ^(NSInteger plat) {
                [weakSelf loadThird:plat];
            };
            self.share.cancel = ^{
                weakSelf.share.hidden = YES;
                state = YES;
            };
            [self.view addSubview:self.share];
            
        }
        state = NO;
        _share.hidden = NO;
    } else {
        _share.hidden = YES;
        state = YES;
    }
    
}

- (void)loadThird:(NSInteger)platFormType
{
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    
//    //设置文本
//    messageObject.text = _productDetail.productName;
//    
//    //创建图片内容对象
//    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
//    //如果有缩略图，则设置缩略图本地
////    shareObject.thumbImage = [UIImage imageNamed:@"wechat"];
//    
//    [shareObject setShareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_productDetail.image]]]];
//    
//    //分享消息对象设置分享内容对象
//    messageObject.shareObject = shareObject;
//    
//    [[UMSocialManager defaultManager] shareToPlatform:platFormType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        NSString *message= nil;
//        if (!error) {
//            message  = @"分享成功";
//            [MBProgressHUD showSuccessMessage:message toContainer:nil];
//        } else {
//            if ((NSInteger) error.code == 2010) {
//                message = @"用户取消分享";
//            } else {
//                message = @"分享失败";
//            }
//            [MBProgressHUD showErrorMessage:message toContainer:nil];
//        }
//    }];
}

- (void)buy:(UIButton *)button {
    
//    if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
//
//        if (_productDetail.type == 3 && _productDetail.status == 1) {
//            [MBProgressHUD showInfoMessage:@"数量有限，请准时来抢哦 ！" toContainer:nil];
//            return;
//        }
//
//        if (!_productDetail) {
//            [MBProgressHUD showErrorMessage:@"产品信息错误" toContainer:nil];
//            return;
//        }
//
//        if (_productDetail != _pickerView.productDetail) {
//            WS(weakSelf);
//            _pickerView = [[YSStandardPickerView alloc] initWithProduct:_productDetail completion:^(id result, id error) {
//                if (button.tag == 10086) {
//                    //添加成功
//                }else {
//                    YSConfirmOrderViewController *vc = [YSConfirmOrderViewController new];
//                    vc.model = result;
//                    vc.type = YSCreateOrderTypeBuyNow;
//                    [weakSelf.navigationController pushViewController:vc animated:YES];
//                }
//            }];
//        }
//
//        _pickerView.pickerType = button.tag == 10086 ? YSStandardPickerTypeAddToShoppingCart: YSStandardPickerTypePurchaseNow;
//        [_pickerView show];
//
//    } else {
//        [self judgeLoginActionWith:1];
//    }
    
    if (self.steper.value>0) {
        
        [JJShopService JJMobileCartConfirmOrder:self.productDetailJJ.ID num:self.steper.value Completion:^(id result, id error) {
            JJOrderSubmitViewController *vc = [[JJOrderSubmitViewController alloc]init];
            vc.model = result;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
       
        
    }
    
}

- (void)scrollToTop {
    [self.scrollView scrollToTop];
}

- (void)scrollToBottom {
    [self.scrollView scrollToBottom];
}

- (void)checkShoppingCart {
    
    if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
        
        Class aclass = NSClassFromString(@"YSShoppingCartViewController");
        UIViewController *vc = [[aclass alloc] init];
        vc.title = @"购物车";
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        [self judgeLoginActionWith:1];
    }

}

- (void)setProductId:(NSString *)productId
{
    _productId = productId;
    [self fetchProductDetailWith:productId];
}


#pragma mark - NetWork

- (void)fetchProductDetailWith:(NSString *)productId {
    
    [JJShopService JJMobileProductGetOneById:productId Completion:^(id result, id error) {
        _productDetailJJ = result;
        
        _desc_vc.detailJJ = _productDetailJJ;
        
        _h5_vc.detailJJ = _productDetailJJ;
    }];
     
}

#pragma mark - 选择规格
#pragma mark - router Event
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:kButtonDidClickRouterEvent]) {
        NSInteger type = [userInfo[kButtonDidClickRouterEvent] integerValue];
        if (type == 1) {
//            [self buy:nil];
            
            if (_productDetail != _pickerView.productDetail) {
                
                _pickerView = [[YSStandardPickerView alloc] initWithProduct:_productDetail completion:^(id result, id error) {

                    if (error) {
                        [MBProgressHUD showErrorMessage:[error errorMessage] toContainer:nil];
                    } else {
                        [MBProgressHUD showText:@"成功加入购物车" toContainer:nil];
                        
                    }
                    
                }];
                
            }
            _pickerView.pickerType =  YSStandardPickerTypePurchaseNow;
            [_pickerView show];
            _pickerView.needLogin = ^{
                [_pickerView hide];
                [self judgeLoginActionWith:1];
                
            };
        }
    }
}

#pragma mark - view

- (UIView *)createFooterView {
    UIView *footerView = [UIView new];
    
    
    _steper = [YSSteper new];
    _steper.defaultValue = 1;
//    _steper.backgroundColor = [UIColor redColor];
    [footerView addSubview:_steper];
    [_steper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(footerView).offset(-10);
        make.left.equalTo(footerView).offset(10);
        make.top.equalTo(footerView).offset(10);
        make.height.mas_equalTo(30);
        
    }];
 
    
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    buyButton.titleLabel.font = [UIFont systemFontOfSize:16];
    buyButton.backgroundColor = GoldColor;
    [buyButton addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:buyButton];
    [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_steper.mas_bottom).offset(10);
        make.bottom.equalTo(footerView).offset(-10);
        make.left.equalTo(footerView).offset(10);
        make.right.equalTo(footerView).offset(-10);
        make.height.mas_offset(50);
    }];
    
    
  

    
    return footerView;
}

#pragma mark - 获取购物车数量
- (void)fetchProductNum
{
    if (!USER_ID) {
        return;
    }
    [YSProductService fetchCartProductNum:^(id result, id error) {
        
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UITabBarController *tabBar = (UITabBarController *)delegate.window.rootViewController;
        UITabBarItem *item = [[[tabBar tabBar]items] objectAtIndex:3];
        num = [result description];
        if (num.integerValue != 0) {
            item.badgeValue = num;
            numlabel.hidden = NO;
            numlabel.text = num;
        } else {
            numlabel.hidden = YES;
            item.badgeValue = nil;
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
