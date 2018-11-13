//
//  YSOrderFooterView.m
//  PXH
//
//  Created by yu on 2017/8/10.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSOrderFooterView.h"
#import "YSAddressView.h"

@interface YSOrderFooterView ()

@property (nonatomic, strong) YSCellView    *freightCell;

@property (nonatomic, strong) YSCellView    *couponsCell;

@property (nonatomic, strong) YSCellView    *integralCell;

@property (nonatomic, strong) YSCellView    *deliveryCell;

@property (nonatomic, strong) YSCellView    *totalCell;

@property (nonatomic, strong) UILabel       *orderNoLabel;

@property (nonatomic, strong) UILabel       *createTimeLabel;

@property (nonatomic, strong) UILabel       *buyTimeLabel;

@property (nonatomic, strong) UILabel       *CourierLabel;

@property (nonatomic, strong) UILabel       *expressCompanyLabel;

@property (nonatomic, strong) UILabel       *expressNoLabel;

@property (nonatomic, strong) YSAddressView *addressView;

@property (nonatomic, assign) NSInteger     type;

@end

@implementation YSOrderFooterView

- (instancetype)initWithFrame:(CGRect)frame type:(NSInteger)type {
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.backgroundColor = BACKGROUND_COLOR;
    
    _freightCell = [self createCellWithContentColor:HEX_COLOR(@"#666666")];
    
    _couponsCell = [self createCellWithContentColor:HEX_COLOR(@"#666666")];
    _couponsCell.ys_title = @"优惠券抵扣";
    
//    _integralCell = [self createCellWithContentColor:HEX_COLOR(@"#666666")];
//    _integralCell.ys_title = @"积分抵扣";
    
    _deliveryCell = [self createCellWithContentColor:HEX_COLOR(@"#666666")];
    _deliveryCell.ys_title = @"配送方式";
    
    _totalCell = [self createCellWithContentColor:MAIN_COLOR];
    _totalCell.ys_title = @"合计";
    UIView *view = [self createTimeInfoView];
    
    [self addSubview:_freightCell];
    [self addSubview:_couponsCell];
//    [self addSubview:_integralCell];
    [self addSubview:_deliveryCell];
    [self addSubview:_totalCell];
    [self addSubview:view];
    
    WS(weakSelf);
    [_freightCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [_couponsCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.freightCell.mas_bottom);
        make.left.right.height.mas_equalTo(weakSelf.freightCell);
    }];
    
//    [_integralCell mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.couponsCell.mas_bottom);
//        make.left.right.height.mas_equalTo(weakSelf.freightCell);
//    }];

    [_deliveryCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.couponsCell.mas_bottom);
        make.left.right.height.mas_equalTo(weakSelf.freightCell);
    }];
    
    [_totalCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.deliveryCell.mas_bottom);
        make.left.right.height.mas_equalTo(weakSelf.freightCell);
    }];

    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.totalCell.mas_bottom).offset(10);
        make.left.right.offset(0);
        make.height.mas_equalTo(90);
    }];
    
    /*
     1平台配送  2自提  3快递
     */
    
    if (_type == 3) {
        
        _deliveryCell.ys_text = @"快递";
        //普通
        UIView *expressView = [self createExpressInfoView];
        [self addSubview:expressView];
        [expressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_bottom).offset(10);
            make.left.right.offset(0);
            make.height.mas_equalTo(80);
            make.bottom.offset(-10);
        }];
        
    }else if (_type == 2) {
        
        _deliveryCell.ys_text = @"自提";
        
        //自提
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(-10);
        }];
    }else {
        _deliveryCell.ys_text = @"品行专送";
        //送货上门
        _addressView = [YSAddressView new];
        [self addSubview:_addressView];
        [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_bottom).offset(10);
            make.left.right.offset(0);
            make.bottom.offset(0);
        }];
    }
}

- (void)setOrder:(YSOrder *)order {
    _order = order;
    
    if (_order.sendMethod == 3) {   //普通
        _freightCell.ys_title = @"运费";
        
        _expressCompanyLabel.text = _order.express;
        _expressNoLabel.text = _order.expressNo;
        
    }else if (_order.sendMethod == 2) { //自提
        _freightCell.ys_title = @"配送费";
    }else {
        _freightCell.ys_title = @"配送费";
        _addressView.titleLabel.text = @"服务点信息";
        [_addressView setStation:_order.service];
    }
    
    _freightCell.ys_text = [NSString stringWithFormat:@"￥%.2f", _order.expressFee];
    _couponsCell.ys_text = [NSString stringWithFormat:@"-￥%.2f", _order.coupon];
    _totalCell.ys_text = [NSString stringWithFormat:@"￥%.2f", _order.amountFee];
    _integralCell.ys_text = [NSString stringWithFormat:@"-￥%.2f", _order.score / 100.0];
    
    _orderNoLabel.text = _order.orderNo;
    _createTimeLabel.text = _order.createTime;
    _buyTimeLabel.text = _order.payTime;
}

#pragma mark - view

- (UIView *)createExpressInfoView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = HEX_COLOR(@"#333333");
    label.text = @"快递信息";
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.offset(10);
        make.top.offset(0);
    }];

    UIView *lineView = [UIView new];
    lineView.backgroundColor = LINE_COLOR;
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(label.mas_bottom);
        make.left.right.offset(0);
        make.height.mas_equalTo(1);
    }];

    _expressCompanyLabel = [UILabel new];
    _expressCompanyLabel.font = [UIFont systemFontOfSize:12];
    _expressCompanyLabel.textColor = HEX_COLOR(@"#666666");
    [view addSubview:_expressCompanyLabel];
    [_expressCompanyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.offset(10);
        make.height.mas_equalTo(40);
    }];
    
    WS(weakSelf);
    _expressNoLabel = [UILabel new];
    _expressNoLabel.font = [UIFont systemFontOfSize:12];
    _expressNoLabel.textColor = HEX_COLOR(@"#666666");
    _expressNoLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:_expressNoLabel];
    [_expressNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.right.offset(-10);
        make.height.mas_equalTo(40);
        make.left.greaterThanOrEqualTo(weakSelf.expressCompanyLabel.mas_right).offset(10);
    }];
    
    return view;
}

- (UIView *)createTimeInfoView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    NSArray *array = @[@"订单编号", @"下单时间", @"支付时间"];
    for (NSInteger i = 0; i < 3; i ++) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = HEX_COLOR(@"#666666");
        label.text = array[i];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.offset(30 * i);
            make.height.mas_equalTo(30);
        }];
        
        UILabel *label1 = [UILabel new];
        label1.font = [UIFont systemFontOfSize:12];
        label1.textColor = HEX_COLOR(@"#666666");
        label1.textAlignment = NSTextAlignmentRight;
        [view addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(label);
            make.right.offset(-10);
            make.left.greaterThanOrEqualTo(label.mas_right).offset(10);
        }];
        
        switch (i) {
            case 0:
                _orderNoLabel = label1;
                break;
            case 1:
                _createTimeLabel = label1;
                break;
            case 2:
                _buyTimeLabel = label1;
                break;
                
            default:
                break;
        }
    }
    
    return view;
}

- (YSCellView *)createCellWithContentColor:(UIColor *)color {
    
    YSCellView *cell = [[YSCellView alloc] initWithStyle:YSCellViewTypeLabel];
    cell.ys_contentFont = [UIFont systemFontOfSize:14];
    cell.ys_contentTextColor = color;
    cell.ys_contentTextAlignment = NSTextAlignmentRight;
    cell.ys_titleFont = [UIFont systemFontOfSize:15];
    cell.ys_titleColor = HEX_COLOR(@"#333333");
    cell.backgroundColor = [UIColor whiteColor];
    cell.ys_bottomLineHidden = NO;
    
    return cell;
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
