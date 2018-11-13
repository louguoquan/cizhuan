//
//  YSLifeCircleDetailViewController.m
//  PXH
//
//  Created by yu on 2017/8/14.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSMerchantsDetailViewController.h"
#import "YSCouponDetailViewController.h"

#import "YSTicketTableViewCell.h"
#import "YSMerchantHeaderView.h"
#import "YSMerchantFooterView.h"

#import "YSLifecircleService.h"

//#import "SDLocationTransform.h"
#import <MapKit/MapKit.h>


@interface YSMerchantsDetailViewController ()
{
    YSLifeCoupons *clickCoupon;
    NSInteger selectRow;
}
@property (nonatomic, strong) YSMerchantHeaderView  *headerView;

@property (nonatomic, strong) YSMerchantFooterView  *footerView;

@property (nonatomic, strong) YSMerchantDetail  *detail;

@property (nonatomic, strong) NSMutableArray *stateArray;

@end

@implementation YSMerchantsDetailViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"拨打电话" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"导航" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"兑换电子券" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"商家详情";
    self.stateArray = [NSMutableArray array];
    [self setup];
    [self fetchMerchantDetail];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rechangeAction) name:@"兑换电子券" object:nil];
}

#pragma mark - 兑换成功
- (void)rechangeAction
{
    [YSLifecircleService couponExchange:clickCoupon.ID completion:^(id result, id error) {
        
        if (!error) {
            [self judgeLoginActionWith:4];
            [_stateArray replaceObjectAtIndex:selectRow withObject:@"1"];
            [self.tableView reloadData];
        }
    }];
}

- (void)setup {
    
    self.tableView.rowHeight = 95.f;
    [self.tableView registerClass:[YSTicketTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _headerView = [[YSMerchantHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 500)];
    [_headerView recalculateHeight];
    self.tableView.tableHeaderView = _headerView;
    
    _footerView = [[YSMerchantFooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 500)];
    [_footerView recalculateHeight];
    self.tableView.tableFooterView = _footerView;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(callPhone:) name:@"拨打电话" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(iOSNav:) name:@"导航" object:nil];
}

- (void)callPhone:(NSNotification *)noti
{
//    NSString *phone = [noti.object objectForKey:@"mobile"];
    NSString *phone = noti.object;
    //打电话
    if (phone != nil) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]]) {
            NSString *telString = [NSString stringWithFormat:@"tel:%@", phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
        }
    } else {
        [MBProgressHUD showErrorMessage:@"该商家未提供电话" toContainer:nil];
    }
}

//去这里
- (void)iOSNav:(NSNotification *)noti
{
    [self iOSMapNavigationWith:noti.object];
}

- (void)iOSMapNavigationWith:(NSDictionary *)dic
{
//    SDLocationTransform *transform = [[SDLocationTransform alloc] initWithLatitude:[dic[@"lat"] doubleValue] andLongitude:[dic[@"lng"] doubleValue]];
//    transform = [transform transformFromBDToGD];
//    
//    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
//    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(transform.latitude, transform.longitude) addressDictionary:nil]];
//    toLocation.name = @"目标位置";
//    [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
//                   launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
//                                   MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];

}

- (void)fetchMerchantDetail {
    
    [YSLifecircleService fetchShopDetail:_merchants.ID completion:^(id result, id error) {
        _detail = result;
        
        _headerView.shop = _detail.shop;
        [_headerView recalculateHeight];
        self.tableView.tableHeaderView = _headerView;
        
        _footerView.shopDic = _detail.shop;
        _footerView.rulesLabel.text = _detail.html;

        [_footerView recalculateHeight];
        self.tableView.tableFooterView = _footerView;
        
        for (int i = 0; i < _detail.coupons.count; i++) {
            [self.stateArray addObject: @"1"];
        }
        
        [self.tableView reloadData];
    }];
}

#pragma mark - router Event
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:kButtonDidClickRouterEvent]) {
        
        clickCoupon = userInfo[kButtonDidClickRouterEvent];
        
        [self judgeLoginActionWith:5];
        
    }
}

- (void)alertAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确认兑换吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [_stateArray replaceObjectAtIndex:selectRow withObject:@"1"];

    }];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self rechangeAction];
    }];
    [alert addAction:cancel];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    [self.tableView reloadData];
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_detail.coupons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSTicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.state = [_stateArray[indexPath.row] integerValue];
    cell.tag = indexPath.row;
    cell.coupon = _detail.coupons[indexPath.row];
    cell.couponClick = ^(NSInteger row, YSLifeCoupons *coupon) {
        clickCoupon = coupon;
        selectRow = row;
        [self alertAction];
        [_stateArray replaceObjectAtIndex:row withObject:@"0"];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YSCouponDetailViewController *vc = [YSCouponDetailViewController new];
    vc.coupon = _detail.coupons[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
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
