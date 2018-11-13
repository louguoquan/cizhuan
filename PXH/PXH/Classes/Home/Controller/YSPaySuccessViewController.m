//
//  YSPaySuccessViewController.m
//  PXH
//
//  Created by yu on 2017/8/23.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSPaySuccessViewController.h"
#import "YSOrderPageViewController.h"

#import "YSOrderService.h"

@interface YSPaySuccessViewController ()

@property (nonatomic, strong) UILabel   *priceLabel;

@property (nonatomic, strong) UILabel   *nameLabel;

@property (nonatomic, strong) UILabel   *addressLabel;

@end

@implementation YSPaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"支付成功";
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    NSMutableArray *array = [NSMutableArray arrayWithArray:viewControllers];
    [array removeObjectAtIndex:array.count - 2];
    [self.navigationController setViewControllers:array animated:YES];

    [self setup];
    [self fetchOrderDetail];
}

- (void)setup {
    
    self.scrollView.backgroundColor = BACKGROUND_COLOR;
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"paySuccess_bg"];
    [self.containerView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(kScreenWidth * 240 / 750.0);
    }];
    
    UILabel *label = [UILabel new];
    label.text = @"订单支付成功";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18];
    [imageView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(40);
    }];
    
    UILabel *label1 = [UILabel new];
    label1.text = @"您的包裹整装待发~~";
    label1.textColor = [UIColor whiteColor];
    [imageView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.bottom.offset(-20);
    }];

    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:14];
    _priceLabel.textColor = HEX_COLOR(@"#666666");
    [self.containerView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
    }];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:14];
    _priceLabel.textColor = HEX_COLOR(@"#666666");
    [self.containerView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
    }];

    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = HEX_COLOR(@"#666666");
    [self.containerView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLabel.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
    }];

    _addressLabel = [UILabel new];
    _addressLabel.font = [UIFont systemFontOfSize:14];
    _addressLabel.textColor = HEX_COLOR(@"#666666");
    _addressLabel.numberOfLines = 0;
    [self.containerView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
    }];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button jm_setCornerRadius:1 withBorderColor:MAIN_COLOR borderWidth:1];
    [button setTitle:@"查看订单" forState:UIControlStateNormal];
    [button setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        YSOrderPageViewController *vc = [YSOrderPageViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.containerView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addressLabel.mas_bottom).offset(75);
        make.left.offset(15);
        make.right.offset(-15);
        make.bottom.offset(-20);
    }];
}

- (void)fetchOrderDetail {
    [YSOrderService fetchOrderDetail:_orderId completion:^(id result, id error) {
        
        YSOrder *order = result;
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"实付款:  "];
        [string appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.2f", order.amountFee] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:MAIN_COLOR}]];
        _priceLabel.attributedText = string;
        
        _nameLabel.text = [NSString stringWithFormat:@"收货人:  %@  %@", order.address.name, order.address.mobile];
        _addressLabel.text = [NSString stringWithFormat:@"收货地址:  %@", order.address.address];
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
