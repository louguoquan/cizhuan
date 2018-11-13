//
//  YSIndexViewController.m
//  PXH
//
//  Created by yu on 2017/7/31.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSIndexViewController.h"
#import "YSIndexTableViewController.h"
#import "YSIndexCateTableViewController.h"
#import "YSProductSearchViewController.h"
//#import <AMapLocationKit/AMapLocationKit.h>
//#import <AMapSearchKit/AMapSearchKit.h>
#import "YSProductService.h"
//#import "YSCityViewController.h"
#import "YSProvinceViewController.h"
#import "YSSteper.h"
#import "YSButton.h"
#import "YSMessageViewController.h"
#import "YSCateService.h"
//#import "YSLocationService.h"
#import "YSNavTitleView.h"
#import "YSLoginGuidingViewController.h"
#import "YSProductService.h"


#import "YSNewIndexController.h"
@interface YSIndexViewController ()<UITextFieldDelegate>

//@property (nonatomic ,strong) AMapLocationManager *locationManager;
//@property (strong ,nonatomic) AMapSearchAPI *searchAPI;


@property (nonatomic, strong) YSSteper  *steper;

@property (nonatomic, copy)   NSArray   *categoryArray;

@property (nonatomic, strong) YSButton  *apartmentButton;

@property (nonatomic, strong) UIButton  *messageButton;

//@property (nonatomic, strong) YSLocationService     *service;

@property (nonatomic, strong) YSNavTitleView *titleView;


@end

@implementation YSIndexViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self fetchCategory];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"选择城市" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"更改地址" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"会员中心购物" object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self renderUI];
    [self setupNavTitleView];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showCity:) name:@"选择城市" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showCity:) name:@"更改地址" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(viewChange:) name:@"会员中心购物" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeController:) name:@"切换视图" object:nil];
//    _locationManager = [[AMapLocationManager alloc] init];
//    _locationManager.delegate = self;
//
//    _searchAPI = [[AMapSearchAPI alloc] init];
//    _searchAPI.delegate = self;
//
//    [_locationManager startUpdatingLocation];
}




- (void)setupNavTitleView {
    
    WS(weakSelf);
    self.titleView = [[YSNavTitleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    self.titleView.changeCityBlock = ^{
        [weakSelf changeCity];
    };
    self.titleView.messageBlock = ^{
        
        YSMessageViewController *vc = [YSMessageViewController new];
        vc.clearValue = ^{
            
            weakSelf.titleView.numlabel.hidden = YES;
            weakSelf.titleView.numlabel.text = @"0";
            
        };
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    self.titleView.searchProductBlock = ^{
        
        if (USER_ID) {
            YSProductSearchViewController *vc =[YSProductSearchViewController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        } else {
            YSLoginGuidingViewController *login = [YSLoginGuidingViewController new];
            login.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:login animated:YES];
        }
    };
    self.navigationItem.titleView = _titleView;
    [self getMessageCount];
    
#if 0
    //    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    //    self.navigationItem.titleView = titleView;
    //    _apartmentButton = [YSButton buttonWithImagePosition:YSButtonImagePositionRight];
    //    _apartmentButton.space = 3;
    //    [_apartmentButton setImage:[UIImage imageNamed:@"pull-down"] forState:UIControlStateNormal];
    //    _apartmentButton.titleLabel.font = [UIFont systemFontOfSize:15];
    //    [_apartmentButton setTitleColor:HEX_COLOR(@"#666666") forState:UIControlStateNormal];
    //    [_apartmentButton addTarget:self action:@selector(changeCity) forControlEvents:UIControlEventTouchUpInside];
    //    [titleView addSubview:_apartmentButton];
    //    [_apartmentButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.offset(0);
    //        make.centerY.equalTo(titleView);
    //        make.height.equalTo(titleView);
    //        make.width.mas_equalTo(80);
    //    }];
    //
    //    _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [_messageButton setImage:[UIImage imageNamed:@"index_news"] forState:UIControlStateNormal];
    //    [_messageButton addTarget:self action:@selector(checkMessage) forControlEvents:UIControlEventTouchUpInside];
    //    [titleView addSubview:_messageButton];
    //    [_messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.right.offset(0);
    //        make.height.mas_equalTo(44);
    //        make.centerY.equalTo(titleView);
    //        make.width.mas_equalTo(35);
    //    }];
    //
    //    UITextField *tf = [UITextField new];
    //    tf.backgroundColor = HEX_COLOR(@"#f0f0f0");
    //
    //    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
    //    imageView.contentMode = UIViewContentModeCenter;
    //    imageView.size = CGSizeMake(30, 30);
    //    tf.leftView = imageView;
    //    tf.leftViewMode = UITextFieldViewModeAlways;
    //    tf.delegate = self;
    //    tf.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"惠" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:MAIN_COLOR}];
    //    [titleView addSubview:tf];
    //    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(_apartmentButton.mas_right).offset(10);
    //        make.right.equalTo(_messageButton.mas_left).offset(-10);
    //        make.centerY.equalTo(titleView);
    //        make.height.equalTo(@30);
    //    }];
    //
#endif
}

//- (void)updateLocation {
//    [[YSLocationService sharedService] getCity:^(id result, id error) {
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        NSString *city = [user objectForKey:@"city"];
//        if (![city isEqualToString:[result description]]) {
//            [self.titleView.apartmentButton setTitle:result forState:UIControlStateNormal];
//            [user setObject:[result description] forKey:@"city"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        } else {
//            [self.titleView.apartmentButton setTitle:city forState:UIControlStateNormal];
//        }
//
//    }];
//}

//选择城市页面
- (void)changeCity {
    
    YSProvinceViewController *vc = [YSProvinceViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)showCity:(NSNotification *)noti
{
    [self.titleView.apartmentButton setTitle:noti.object forState:0];
}

- (void)changeController:(NSNotification *)noti
{
    NSInteger select = [noti.object integerValue];
    [self setSelectedIndex:select animated:YES];
}

#pragma mark - 会员中心点击购物实现
- (void)viewChange:(NSNotification *)noti
{
    [self setSelectedIndex:0 animated:NO];
}

- (void)fetchCategory {
    
    if (_categoryArray.count > 0) {
        return;
    }
    [YSCateService fetchFirstCate:^(id result, id error) {
        _categoryArray = result;
        [self reloadChildVcs];
    }];
}


#pragma mark - delegate
- (YSSegmentStyle *)segmentStyleForPageViewController {
    YSSegmentStyle *style = [YSSegmentStyle new];
    
    style.canScrollTitle = YES;
    
    style.itemMargin = 30;
    
    return style;
}

- (NSArray *)titlesForPageViewController {
    
    NSMutableArray *array = [NSMutableArray arrayWithObject:@"今日特卖"];
    NSArray *titleArray = [_categoryArray valueForKey:@"name"];
    if (titleArray.count > 0) {
        [array addObjectsFromArray:titleArray];
    }
    return array;
}

- (Class)childViewControllersForPageViewControllerAtIndex:(NSInteger)index {
    
    return index == 0 ? [YSNewIndexController class] : [YSIndexCateTableViewController class];
    //    return index == 0 ? [YSIndexTableViewController class] : [YSIndexCateTableViewController class];
}

- (NSDictionary *)extensionForChildViewControllerAtIndex:(NSInteger)index {
    if (index != 0) {
        YSCategory *category = _categoryArray[index - 1];
        return @{@"cate" : category};
    }
    return nil;
}

- (void)getMessageCount
{
    if (!USER_ID) {
        return;
    }
    [YSProductService fetchMessageNum:^(id result, id error) {
        NSString *num = [result description];
        if (num.integerValue != 0) {
            
            self.titleView.num = num;
            
        } else {
            
        }
    }];
}

//- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error; {
//
//    [_locationManager stopUpdatingLocation];
//
//#if DEBUG
//    NSLog(@"定位失败 : %@",error);
//#endif
//}
//
//- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode; {
//    if (location) {
//        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
//        AMapGeoPoint *_location = [[AMapGeoPoint alloc] init];
//        _location.latitude = location.coordinate.latitude;
//        _location.longitude = location.coordinate.longitude;
//        request.location = _location;
//        [_searchAPI AMapReGoecodeSearch:request];
//        [manager stopUpdatingLocation];
//    }
//}

/**
 * @brief 逆地理编码查询回调函数
 * @param request  发起的请求，具体字段参考 AMapReGeocodeSearchRequest 。
 * @param response 响应结果，具体字段参考 AMapReGeocodeSearchResponse 。
 */
//- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response; {
//    NSString *district = response.regeocode.addressComponent.city;
//    [self.titleView.apartmentButton setTitle:district forState:UIControlStateNormal];
//    
//    //    [self locationCityCode:response.regeocode.addressComponent.adcode];
//}

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
