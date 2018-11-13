
//
//  YSOrderSectionFooterView.m
//  PXH
//
//  Created by yu on 2017/8/10.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSOrderSectionFooterView.h"

@interface YSOrderActionView ()
{
    NSInteger _status;
}
@property (nonatomic, strong) UIButton  *button1;

@property (nonatomic, strong) UIButton  *button2;

@property (nonatomic, strong) UIButton  *button3;

@property (nonatomic, copy)  YSCompleteHandler block;

@end

@implementation YSOrderActionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.backgroundColor = [UIColor whiteColor];
    
    _button1 = [self createButton];
    [self addSubview:_button1];
    _button2 = [self createButton];
    [self addSubview:_button2];
    _button3 = [self createButton];
    [self addSubview:_button3];
    
    WS(weakSelf);
    [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(65);
        make.right.offset(-10);
    }];
    
    [_button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.width.equalTo(weakSelf.button1);
        make.right.equalTo(weakSelf.button1.mas_left).offset(-18);
    }];

    [_button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.width.equalTo(weakSelf.button1);
        make.right.equalTo(weakSelf.button2.mas_left).offset(-18);
    }];
    
}

- (UIButton *)createButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    button.layer.cornerRadius = 2;
    button.layer.borderWidth = 1;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
}

- (void)action:(UIButton *)button {
    if (_block) {
        _block(button.currentTitle, nil);
    }
}

- (void)setButtonWith:(NSInteger)status sendMethod:(NSInteger)sendMethod expressStatus:(NSInteger)expressStatus
{
    _button1.hidden = YES;
    _button2.hidden = YES;
    _button3.hidden = YES;
    
//    _status = status;
    switch (status) {
        case 0:     //待付款  立即支付 取消订单
        {
            _button1.hidden = NO;
            _button1.layer.borderColor = MAIN_COLOR.CGColor;
            [_button1 setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            [_button1 setTitle:@"立即付款" forState:UIControlStateNormal];
            
            _button2.hidden = NO;
            _button2.layer.borderColor = HEX_COLOR(@"999999").CGColor;
            [_button2 setTitleColor:HEX_COLOR(@"999999") forState:UIControlStateNormal];
            [_button2 setTitle:@"取消订单" forState:UIControlStateNormal];
            
        }
            break;
        case 1:     //待发货 申请退款
        {
            _button1.hidden = NO;
            _button1.layer.borderColor = MAIN_COLOR.CGColor;
            [_button1 setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            [_button1 setTitle:@"申请退款" forState:UIControlStateNormal];
            
        }
            break;
        case 2:     //待收货  确认收货 查看物流  申请退货
        {
            if (expressStatus != 3) {
                if (sendMethod == 3) {
                    [self canTakeGoods];
                } else {
                    [self noTakeGoods];
                }
            } else {
                [self canTakeGoods];
            }
//             [self canTakeGoods];
        }
            break;
        case 3:     //待评价  评价
        {
            _button1.hidden = NO;
            _button1.layer.borderColor = MAIN_COLOR.CGColor;
            [_button1 setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            [_button1 setTitle:@"评价" forState:UIControlStateNormal];
            
            _button2.hidden = NO;
            _button2.layer.borderColor = HEX_COLOR(@"999999").CGColor;
            [_button2 setTitleColor:HEX_COLOR(@"999999") forState:UIControlStateNormal];
            [_button2 setTitle:@"查看物流" forState:UIControlStateNormal];
            
        }
            break;
        case 5: //退款中
        case 8: //退货中  退款详情
        {
            _button1.hidden = NO;
            _button1.layer.borderColor = MAIN_COLOR.CGColor;
            [_button1 setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            [_button1 setTitle:@"退款详情" forState:UIControlStateNormal];
            
        }
            break;
        case 11: //待自提  确认收货  申请退货
        {
//            if (expressStatus != 3) {
//                if (sendMethod == 3) {
//                    [self canTakeGoods];
//                } else {
//                    [self noTakeGoods];
//                }
//            } else {
                [self canTakeGoods];
//            }
        }
            break;
        case 4:
        {
            _button1.hidden = NO;
            _button1.layer.borderColor = MAIN_COLOR.CGColor;
            [_button1 setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            [_button1 setTitle:@"删除订单" forState:UIControlStateNormal];
        }
            break;
        case 10:
        {
            _button1.hidden = NO;
            _button1.layer.borderColor = MAIN_COLOR.CGColor;
            [_button1 setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            [_button1 setTitle:@"已完成" forState:UIControlStateNormal];
        }
            break;
        default:
        {
            _button1.hidden = NO;
            _button1.layer.borderColor = MAIN_COLOR.CGColor;
            [_button1 setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            [_button1 setTitle:@"删除订单" forState:UIControlStateNormal];
            
            _button2.hidden = NO;
            _button2.layer.borderColor = MAIN_COLOR.CGColor;
            [_button2 setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            [_button2 setTitle:@"已完成" forState:UIControlStateNormal];
        }
            break;
    }
}
#pragma mark - 可以收货
- (void)canTakeGoods
{
    _button1.hidden = NO;
    _button1.layer.borderColor = MAIN_COLOR.CGColor;
    [_button1 setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [_button1 setTitle:@"确认收货" forState:UIControlStateNormal];
    
    _button2.hidden = NO;
    _button2.layer.borderColor = HEX_COLOR(@"999999").CGColor;
    [_button2 setTitleColor:HEX_COLOR(@"999999") forState:UIControlStateNormal];
    [_button2 setTitle:@"申请退货" forState:UIControlStateNormal];
    
    _button3.hidden = NO;
    _button3.layer.borderColor = HEX_COLOR(@"999999").CGColor;
    [_button3 setTitleColor:HEX_COLOR(@"999999") forState:UIControlStateNormal];
    [_button3 setTitle:@"查看物流" forState:UIControlStateNormal];
}

#pragma mark - 不能收货
- (void)noTakeGoods
{
    _button1.hidden = NO;
    _button1.layer.borderColor = HEX_COLOR(@"999999").CGColor;
    [_button1 setTitleColor:HEX_COLOR(@"999999") forState:UIControlStateNormal];
    [_button1 setTitle:@"申请退货" forState:UIControlStateNormal];
    
    _button2.hidden = NO;
    _button2.layer.borderColor = HEX_COLOR(@"999999").CGColor;
    [_button2 setTitleColor:HEX_COLOR(@"999999") forState:UIControlStateNormal];
    [_button2 setTitle:@"查看物流" forState:UIControlStateNormal];
}


@end

@interface YSOrderSectionFooterView ()

@property (nonatomic, strong) UILabel   *countLabel;

@property (nonatomic, strong) UILabel   *priceLabel;

@property (nonatomic, strong) YSOrderActionView  *actionView;

@end

@implementation YSOrderSectionFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.contentView.backgroundColor = BACKGROUND_COLOR;
    
    UIView *view = [self createTotalView];
    [self.contentView addSubview:view];
    
    [self.contentView addSubview:self.actionView];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(35);
    }];
    
    [self.actionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom);
        make.left.right.offset(0);
        make.height.mas_equalTo(50);
        make.bottom.offset(-10);
    }];
    
}

- (void)setOrder:(YSOrder *)order {
    _order = order;
    
    NSMutableAttributedString *countAttr = [[NSMutableAttributedString alloc] initWithString:@"共计商品:"];
    [countAttr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@件", _order.num] attributes:@{NSForegroundColorAttributeName:MAIN_COLOR}]];
    _countLabel.attributedText = countAttr;
    
    NSMutableAttributedString *priceAttr = [[NSMutableAttributedString alloc] initWithString:@"应付款:"];
    [priceAttr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.2f", _order.amountFee] attributes:@{NSForegroundColorAttributeName:MAIN_COLOR}]];
    [priceAttr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"(运费:￥%.2f)", _order.expressFee]]];
    _priceLabel.attributedText = priceAttr;
    [_actionView setButtonWith:_order.status sendMethod:_order.sendMethod expressStatus:_order.expressStatus];
//    [_actionView setStatus:_order.status];
//    [_actionView setSendMethod:_order.sendMethod];
}

#pragma mark - view

- (YSOrderActionView *)actionView {
    if (!_actionView) {
        WS(weakSelf);
        _actionView = [[YSOrderActionView alloc] init];
        _actionView.block = ^(id result, id error) {
            [weakSelf routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@"1", @"type":result, @"model":weakSelf.order}];
        };
    }
    return _actionView;
}

- (UIView *)createTotalView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    WS(weakSelf);
    _countLabel = [UILabel new];
    _countLabel.font = [UIFont systemFontOfSize:12];
    _countLabel.textColor = HEX_COLOR(@"#333333");
    [view addSubview:_countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.offset(10);
    }];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:12];
    _priceLabel.textColor = HEX_COLOR(@"#333333");
    [view addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.offset(-10);
        make.left.greaterThanOrEqualTo(weakSelf.countLabel.mas_right).offset(10);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LINE_COLOR;
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(view);
        make.height.mas_equalTo(1);
        make.left.offset(10);
    }];
    
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
