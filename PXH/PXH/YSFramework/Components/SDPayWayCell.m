//
//  SDPayWayView.m
//  QingTao
//
//  Created by yu on 16/5/26.
//  Copyright © 2016年 com.sunday-mobi. All rights reserved.
//

#import "SDPayWayCell.h"

@interface SDPayWayCell ()

@property (nonatomic, strong) UIButton *checkButton;

@end

@implementation SDPayWayCell

- (instancetype)initWithPayWay:(SDPayWay)payWay tapBlock:(TapHandel)block
{
    self = [super init];
    if (self) {
        _block = block;
        _payWay = payWay;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    WS(weakSelf);
    
    UIImageView *logo = [UIImageView new];
    [self addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(weakSelf);
    }];
    
    _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_checkButton setImage:[UIImage imageNamed:@"choose-normal"] forState:UIControlStateNormal];
    [_checkButton setImage:[UIImage imageNamed:@"choose-pressed"] forState:UIControlStateSelected];
    [_checkButton addTarget:self action:@selector(changeState) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_checkButton];
    [_checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.height.equalTo(weakSelf);
        make.width.equalTo(weakSelf.mas_height);
    }];
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = HEX_COLOR(@"#333333");
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(logo.mas_right).offset(10);
    }];
    
    
    switch (_payWay) {
        case SDPayWayAliPay:
        {
            nameLabel.text = @"支付宝";
            logo.image = [UIImage imageNamed:@"alipay"];
        }
            break;
        case SDPayWayWechatPay:
        {
            nameLabel.text = @"微信";
            logo.image = [UIImage imageNamed:@"wechat"];
        }
            break;
        case SDPayWayBalancePay:
        {
            nameLabel.text = @"余额";
            logo.image = [UIImage imageNamed:@"icon-ping"];
        }
            break;
        case SDPayWayCashPay:
        {
            nameLabel.text = @"现金支付";
            logo.image = [UIImage imageNamed:@"cash"];
        }
            break;
        default:
            break;
    }
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
}

- (void)tap
{
    if (_block) {
        _block(self.payWay);
    }
}

- (void)changeState
{
    if (_block) {
        _block(self.payWay);
    }
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    
    _checkButton.selected = _selected;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
