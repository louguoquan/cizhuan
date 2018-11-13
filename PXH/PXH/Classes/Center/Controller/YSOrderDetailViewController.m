//
//  YSOrderDetailViewController.m
//  PXH
//
//  Created by yu on 2017/8/10.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSOrderDetailViewController.h"

#import "YSOrderProductTableViewCell.h"
#import "YSOrderHeaderView.h"
#import "YSOrderFooterView.h"

#import "YSOrderService.h"
//#import "SDLocationTransform.h"
#import <MapKit/MapKit.h>

#import "YSProductDetailViewController.h"


@interface YSOrderDetailViewController ()

@end

@implementation YSOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"订单详情";
    
    [self setup];
    
    [self fetchOrderDetail];
}

- (void)setup {
    self.tableView.rowHeight = 110.f;
    [self.tableView registerClass:[YSOrderProductTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self setupHeaderFooterView];
}

- (void)setupHeaderFooterView {
    
    YSOrderHeaderView *headerView = [[YSOrderHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 500)];
    headerView.order = _order;
    [headerView recalculateHeight];
    self.tableView.tableHeaderView = headerView;
    
    YSOrderFooterView *footerView = [[YSOrderFooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 500) type:_order.sendMethod];
    footerView.order = _order;
    [footerView recalculateHeight];
    self.tableView.tableFooterView = footerView;
    
    [self.tableView reloadData];
}

- (void)fetchOrderDetail {
    [YSOrderService fetchOrderDetail:_order.orderId completion:^(id result, id error) {
        _order = result;
        
        [self setupHeaderFooterView];
    }];
}

    //导航
- (void)iOSMapNavigation {
    
//    SDLocationTransform *transform = [[SDLocationTransform alloc] initWithLatitude:_order.service.lat andLongitude:_order.service.lng];
//    transform = [transform transformFromBDToGD];
//    
//    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
//    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(transform.latitude, transform.longitude) addressDictionary:nil]];
//    toLocation.name = @"目标位置";
//    [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
//                   launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
//                                   MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
}

#pragma mark - router Event

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:kButtonDidClickRouterEvent]) {
        NSInteger type = [userInfo[kButtonDidClickRouterEvent] integerValue];
        YSServiceStation *station = userInfo[@"model"];
        if (type == 10) {
            //打电话
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]]) {
                NSString *telString = [NSString stringWithFormat:@"tel:%@", station.mobile];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
            }
        }else {
            //导航
            [self iOSMapNavigation];
        }
    }
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_order.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSOrderProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.orderProduct = _order.items[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSOrderProduct *product = _order.items[indexPath.row];
    YSProductDetailViewController *VC = [YSProductDetailViewController new];
    VC.productId = product.productId;
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
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
