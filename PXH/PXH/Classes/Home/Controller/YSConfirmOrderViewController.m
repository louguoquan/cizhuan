//
//  YSConfirmOrderViewController.m
//  PXH
//
//  Created by yu on 2017/8/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSConfirmOrderViewController.h"
#import "YSServiceStationPickerViewController.h"
#import "YSCouponsViewController.h"
#import "YSAddressViewController.h"
#import "YSPayViewController.h"
#import "YSAddAddressViewController.h"
#import "YSOrderProductTableViewCell.h"
#import "YSConfirmOrderHeaderView.h"
#import "YSConfirmOrderFooterView.h"

#import "YSServiceStation.h"
#import "YSCoupons.h"
#import "YSOrderService.h"
#import "YSPagingListService.h"
#import "YSProductDetailViewController.h"

@interface YSConfirmOrderViewController ()

@property (nonatomic, strong) YSConfirmOrderHeaderView  *headerView;

@property (nonatomic, strong) YSConfirmOrderFooterView  *footerView;

@property (nonatomic, strong) UILabel   *totalLabel;

@property (nonatomic, strong) UILabel   *countLabel;

@property (nonatomic, assign) BOOL      serviceChosen;

@property (nonatomic, strong) YSServiceStation  *serviceStation;

@property (nonatomic, strong) YSCoupons *coupons;

@property (nonatomic, strong) YSAddress *receiveAddress;


@property (nonatomic, strong) YSPagingListService   *service;

@property (nonatomic, assign) BOOL      isPointDoCount;

@end

@implementation YSConfirmOrderViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"确认订单";
    
    _receiveAddress = _model.receiveAddress;
    _service = [[YSPagingListService alloc] initWithTargetClass:[YSOrderService class] action:@selector(fetchServiceStationList:page:completion:)];
    [self fetchServiceStationWithLoadMore:NO];
    
    if (_model.servicePointDto) {
        _isPointDoCount = YES;
    }
    
    [self setup];
    [self createBottomView];
}

- (void)fetchServiceStationWithLoadMore:(BOOL)loadMore {
    
    [_service loadDataWithParameters:@{@"addressId" : _receiveAddress.ID} isLoadMore:loadMore completion:^(id result, id error) {
        
        NSArray *array  = (NSArray *)result;
        _isPointDoCount = array.count > 0 ? YES : NO;
        if (array.count>0) {
            _isPointDoCount = YES;
            _model.servicePointDto = [array firstObject];
            _serviceStation  = _model.servicePointDto;
            _serviceChosen = YES;
            _footerView.model = _model;
            [_footerView setStation:_model.servicePointDto];
            [_footerView recalculateHeight];
            self.tableView.tableFooterView = _footerView;
            
        }else{
            _isPointDoCount = NO;
            _model.servicePointDto = nil;
            _serviceChosen = YES;
            _serviceStation  = _model.servicePointDto;
            _footerView.model = _model;
            [_footerView setStation:_model.servicePointDto];
            [_footerView recalculateHeight];
        }
        
        [self recalculateTotalPrice];
        [self.tableView reloadData];
    }];
}




- (void)setup {
    
    self.tableView.backgroundColor = HEX_COLOR(@"#f2f2f2");
    
    self.tableView.rowHeight = 110.f;
    [self.tableView registerClass:[YSOrderProductTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-50);
    }];
    
    [self.tableView layoutIfNeeded];
    
    WS(weakSelf);
    _headerView = [[YSConfirmOrderHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    _headerView.address = _receiveAddress;
    
    _headerView.block = ^(id result, id error) {
        [weakSelf chooseAddress];
    };
    _headerView.newAddress = ^(id result, id error) {
        [weakSelf addNewAdderss];
    };
    [_headerView recalculateHeight];
    self.tableView.tableHeaderView = _headerView;
    
    _footerView = [[YSConfirmOrderFooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 304.f)];
    _footerView.model = _model;
    _footerView.checkStation = ^{
        
        _serviceChosen = YES;
        _serviceStation.takeTheir = YES;
        _footerView.station = _serviceStation;
        [_footerView recalculateHeight];
        [self.tableView reloadData];
        
        [self recalculateTotalPrice];
    };
    
    _footerView.uncheckStation = ^{
        
        _serviceChosen = NO;
        _serviceStation.takeTheir = NO;
        _footerView.station = _serviceStation;
        [_footerView recalculateHeight];
        [self.tableView reloadData];
        
        
        [self recalculateTotalPrice];
    };
    if (_serviceChosen == NO && _model.servicePointDto) {
        _footerView.station = _model.servicePointDto;
        _serviceChosen = YES;
        _serviceStation  = _model.servicePointDto;
        
    }
    [_footerView recalculateHeight];
    self.tableView.tableFooterView = _footerView;
    
}

- (void)createBottomView {
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.height.mas_equalTo(50);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = MAIN_COLOR;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:@"提交订单" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(submitOrder) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(135);
        make.centerY.equalTo(bottomView);
        make.right.offset(-10);
    }];
    
    _totalLabel = [UILabel new];
    _totalLabel.font = [UIFont systemFontOfSize:13];
    _totalLabel.textColor = MAIN_COLOR;
    [bottomView addSubview:_totalLabel];
    [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(10);
        make.right.equalTo(button.mas_left).offset(-10);
    }];
    
    WS(weakSelf);
    NSString *count = [NSString stringWithFormat:@"共%@件商品", _model.totalNum];
    
    _countLabel = [UILabel new];
    _countLabel.font = [UIFont systemFontOfSize:12];
    _countLabel.textColor = HEX_COLOR(@"#666666");
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:count];
    [attrString addAttributes:@{NSForegroundColorAttributeName:HEX_COLOR(@"#ef0022")} range:NSMakeRange(1, _model.totalNum.length)];
    //    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"共件商品"];
    //    [attrString appendAttributedString:[[NSAttributedString alloc] initWithString:_model.totalNum attributes:@{NSForegroundColorAttributeName:MAIN_COLOR}]];
    _countLabel.attributedText = attrString;
    [bottomView addSubview:_countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.totalLabel.mas_bottom);
        make.bottom.offset(0);
        make.left.height.right.mas_equalTo(weakSelf.totalLabel);
    }];
    
    [self recalculateTotalPrice];
}

//添加新地址
- (void)addNewAdderss
{
    YSAddAddressViewController *vc = [YSAddAddressViewController new];
    vc.type = 1;
    vc.saveAddress = ^(id result) {
        self.receiveAddress = result;
        
        _headerView.address = self.receiveAddress;
        [_headerView recalculateHeight];
        [_footerView recalculateHeight];
        self.tableView.tableHeaderView = _headerView;
        
        [self fetchSettleData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)chooseAddress {
    
    YSAddressViewController *vc = [YSAddressViewController new];
    vc.block = ^(id object) {
        self.receiveAddress = object;
        
        [_footerView.stationView removeAllSubviews];
        [_footerView.stationHeight deactivate];
        
        _headerView.address = self.receiveAddress;
        [_headerView recalculateHeight];
        [_footerView recalculateHeight];
        self.tableView.tableHeaderView = _headerView;
        [self.tableView reloadData];
        [self fetchSettleData];
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}

//计算总价
- (void)recalculateTotalPrice {
    
    CGFloat totalFee = _model.totalFee;
    if (_footerView.coupons) {
        totalFee -= _footerView.coupons.money;
    }
    
    
    if (_model.servicePointDto) {
        
        if(_serviceChosen) {
            
            if (_serviceStation.takeTheir) {
                totalFee += _model.sinceFee;
            } else {
                if (_serviceStation) {
                    totalFee += _model.serviceFee;
                } else {
                    /*
                     特殊产品不包邮，运费 为特殊运费
                     */
                    //                if (_model.isTotalFreePost == 0) {
                    //                    totalFee += _model.specialExpressFee;
                    //                } else {
                    //                    totalFee += _model.expressFee;
                    //                }
                    
                    if (_model.specialExpressFee > 0) {
                        if (_model.isTotalFreePost == 0) {
                            
                            if (_model.servicePointDto) {
                                
                                totalFee += _model.serviceFee;
                            }else{
                                totalFee += _model.specialExpressFee;
                            }
#warning
                            
                        } else {
                            if (_model.isFreePost == 1) {
                                totalFee += _model.specialExpressFee;
                            } else {
                                totalFee += _model.specialExpressFee;
                                totalFee += _model.expressFee;
                            }
                        }
                    } else {
                        if (_model.isFreePost == 0) {
                            totalFee += _model.expressFee;
                        }
                    }
                }
            }
        }else{
            
            
            totalFee += _model.serviceFee;
            
        }
        
    }else{
        
        if (_model.specialExpressFee>0) {
            
            if (_model.isTotalFreePost == 0) {
                totalFee += _model.specialExpressFee;
            } else {
                totalFee += _model.expressFee;
            }
            
            //            totalFee += _model.specialExpressFee;
        } else {
            if (_model.isFreePost == 1) {
                totalFee += _model.specialExpressFee;
            } else {
                totalFee += _model.specialExpressFee;
                totalFee += _model.expressFee;
            }
        }
//        else{
//            totalFee += _model.serviceFee;
//        }
    }
    
    
    
    
    
    if (_footerView.integralUsed) {
        totalFee -= _model.scoreAmount;
        
    }
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总金额:￥"]];
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f", totalFee] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}]];
    _totalLabel.attributedText = string;
}

//修改地址  重新获取邮费
- (void)fetchSettleData {
    
    void(^refreshBlock)() = ^(YSOrderSettleModel *model){
        _model = model;
        [self.footerView setModel:_model];
        _serviceChosen = NO;
        [self fetchServiceStationWithLoadMore:NO];
        
    };
    
    if (_type == YSCreateOrderTypeBuyNow) {
        YSSettleProduct *product = [_model.productDetails firstObject];
        [YSOrderService commitOrderFromProduct:product.productId
                                      normalId:product.normalId
                                        number:product.num
                                    completion:^(id result, id error) {
                                        refreshBlock(result);
                                    }];
    }else {
        [YSOrderService commitOrderFromCart:_cartIds completion:^(id result, id error) {
            refreshBlock(result);
        }];
    }
}

//提交订单
- (void)submitOrder {
    
    if (!_receiveAddress) {
        [MBProgressHUD showInfoMessage:@"请在上方选择收货地址" toContainer:nil];
        return;
    }
    
    if (_model.servicePointDto) {
        
        
        
    }else{
        
        if (!_serviceChosen) {
            [MBProgressHUD showInfoMessage:@"请在下方选择配送方式" toContainer:nil];
            return;
        }
    }
    
    [MBProgressHUD showLoadingText:@"正在结算" toContainer:nil];
    if (_type == YSCreateOrderTypeBuyNow) {
        YSSettleProduct *product = [_model.productDetails firstObject];
        [YSOrderService buyNowCreateOrderWithProductId:product.productId
                                                   num:product.num
                                             serviceId:_serviceStation.ID
                                               isSince:_serviceStation.takeTheir
                                              normalId:product.normalId
                                             addressId:_receiveAddress.ID
                                          pledgeMethod:_footerView.integralUsed
                                              couponId:_coupons.ID
                                                  memo:_footerView.memo
                                            completion:^(id result, id error) {
                                                [self toPay:result];
                                            }];
    }else {
        [YSOrderService shoppingCartCreateOrderWithCarIds:_cartIds
                                                serviceId:_serviceStation.ID
                                                  isSince:_serviceStation.takeTheir
                                                addressId:_receiveAddress.ID
                                             pledgeMethod:_footerView.integralUsed
                                                 couponId:_coupons.ID
                                                     memo:_footerView.memo
                                               completion:^(id result, id error) {
                                                   [self toPay:result];
                                               }];
        
    }
}

//跳转支付
- (void)toPay:(NSDictionary *)result {
    
    [MBProgressHUD dismissForContainer:nil];
    
    NSString *orderId = result[@"orderId"];
    CGFloat totalFee = [result[@"totalFee"] doubleValue];
    YSPayViewController *vc = [YSPayViewController new];
    vc.orderId = orderId;
    vc.totalPrice = totalFee;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - router Event

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:kButtonDidClickRouterEvent]) {
        NSInteger type = [userInfo[kButtonDidClickRouterEvent] integerValue];
        switch (type) {
                // 选择优惠券
            case 0:
            {
                YSCouponsViewController *vc = [YSCouponsViewController new];
                vc.totalPrice = _model.totalFee;
                vc.block = ^(id object) {
                    _coupons = object;
                    _footerView.coupons = object;
                    
                    [self recalculateTotalPrice];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                //选择服务点
            case 1:
            {
                if (!_receiveAddress) {
                    [MBProgressHUD showInfoMessage:@"请先选择收货地址" toContainer:nil];
                    return;
                }
                
                YSServiceStationPickerViewController *vc = [YSServiceStationPickerViewController new];
                vc.addressId = _receiveAddress.ID;
                vc.block = ^(YSServiceStation *station) {
                    
                    _serviceChosen = YES;
                    _serviceStation = station;
                    
                    _footerView.model = _model;
                    [_footerView setStation:station];
                    [_footerView recalculateHeight];
                    self.tableView.tableFooterView = _footerView;
                    
                    [self recalculateTotalPrice];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                //积分抵扣
            case 2:
            {
                [self recalculateTotalPrice];
            }
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_model.productDetails count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSOrderProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.product = _model.productDetails[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YSSettleProduct *model = _model.productDetails[indexPath.row];
    YSProductDetailViewController *vc = [YSProductDetailViewController new];
    vc.productId = model.productId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.f;
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
