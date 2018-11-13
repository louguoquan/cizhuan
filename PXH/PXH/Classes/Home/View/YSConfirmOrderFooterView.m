//
//  YSConfirmOrderFooterView.m
//  PXH
//
//  Created by yu on 2017/8/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSConfirmOrderFooterView.h"
#import "YSButton.h"

@interface YSConfirmOrderFooterView ()

@property (nonatomic, strong) YSCellView    *couponsChooseCell;

@property (nonatomic, strong) YSCellView    *returnIntegralCell;

@property (nonatomic, strong) YSCellView    *serviceCell;

@property (nonatomic, strong) YSCellView    *priceCell;

@property (nonatomic, strong) YSCellView    *integralCell;

@property (nonatomic, strong) UIView *takeThireView;

@property (nonatomic, strong) YSCellView    *expressCell;

@property (nonatomic, strong) UIButton *takeBtn;

@property (nonatomic, assign) BOOL takeState;

@property (nonatomic,strong)UILabel *zitiTitle;

@end

@implementation YSConfirmOrderFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.takeState = NO;
    
    WS(weakSelf);
    _couponsChooseCell = [self createCellWithType:YSCellViewTypeLabel Title:@"优惠券" contentFontSize:14 contentColor:HEX_COLOR(@"#666666")];
    _couponsChooseCell.ys_accessoryType = YSCellAccessoryDisclosureIndicator;
    [_couponsChooseCell addBlockForControlEvents:UIControlEventTouchUpInside block:^(id   sender) {
        [weakSelf routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@(0)}];
    }];
    [self addSubview:_couponsChooseCell];
    
    _returnIntegralCell = [self createCellWithType:YSCellViewTypeLabel Title:@"购买可得积分" contentFontSize:14 contentColor:MAIN_COLOR];
    [self addSubview:_returnIntegralCell];
    
    //请选择服务点
    _serviceCell = [self createCellWithType:YSCellViewTypeLabel Title:@"选择就近配送点" contentFontSize:14 contentColor:MAIN_COLOR];
    _serviceCell.ys_contentLabel.text = @"未选择";
    [_serviceCell addBlockForControlEvents:UIControlEventTouchUpInside block:^(id   sender) {
        [weakSelf routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@(1)}];
    }];
    _serviceCell.ys_accessoryType = YSCellAccessoryDisclosureIndicator;
    [self addSubview:_serviceCell];
    
    _stationView = [UIView new];
    _stationView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_stationView];
    [_stationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
        [weakSelf routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@(1)}];
    }]];
    
    _takeThireView = [UIView new];
    _takeThireView.backgroundColor = [UIColor whiteColor];
    _takeThireView.userInteractionEnabled = YES;
    [self addSubview:_takeThireView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(takeAction)];
    [_takeThireView addGestureRecognizer:tap];
    
    _zitiTitle = [UILabel new];
    _zitiTitle.text = @"配送点自提";
    _zitiTitle.font = [UIFont systemFontOfSize:14];
    _zitiTitle.textColor = HEX_COLOR(@"#333333");
    [_takeThireView addSubview:_zitiTitle];
    
    self.takeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (_takeState == NO) {
        [_takeBtn setImage:[UIImage imageNamed:@"check-normal"] forState:UIControlStateNormal];
    } else {
        [_takeBtn setImage:[UIImage imageNamed:@"choose-pressed"] forState:0];
    }
    [_takeBtn addTarget:self action:@selector(takeAction) forControlEvents:UIControlEventTouchUpInside];
    [_takeThireView addSubview:_takeBtn];
    
    _remarkCell = [self createCellWithType:YSCellViewTypeTextField Title:@"留言" contentFontSize:14 contentColor:HEX_COLOR(@"#666666")];
    _remarkCell.ys_textFiled.placeholder = @"选填：对本次交易的说明";
    [self addSubview:_remarkCell];
    
    _priceCell = [self createCellWithType:YSCellViewTypeLabel Title:@"商品金额" contentFontSize:14 contentColor:MAIN_COLOR];
    [self addSubview:_priceCell];
    
    _integralCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeLabel];
    _integralCell.ys_accessoryImage = [UIImage imageNamed:@"choose-normal"];
    _integralCell.ys_contentFont = [UIFont systemFontOfSize:14];
    _integralCell.ys_contentTextColor = HEX_COLOR(@"#666666");
    _integralCell.backgroundColor = [UIColor whiteColor];
    [_integralCell addBlockForControlEvents:UIControlEventTouchUpInside block:^(YSCellView *sender) {
        sender.selected = !sender.selected;
        if (sender.selected) {
            sender.ys_accessoryImage = [UIImage imageNamed:@"choose-pressed"];
        }else {
            sender.ys_accessoryImage = [UIImage imageNamed:@"choose-normal"];
        }
        
        [weakSelf routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@(2)}];
    }];
    [self addSubview:_integralCell];
    
    [self.couponsChooseCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.returnIntegralCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(weakSelf.couponsChooseCell);
        make.top.equalTo(weakSelf.couponsChooseCell.mas_bottom);
    }];
    
    [self.serviceCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(weakSelf.returnIntegralCell);
        //        make.top.equalTo(weakSelf.returnIntegralCell.mas_bottom).offset(10);
        make.top.equalTo(weakSelf.returnIntegralCell.mas_bottom).offset(10);
    }];
    
    [self.stationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_serviceCell.mas_bottom);
        make.left.right.equalTo(_serviceCell);
        _stationHeight = make.height.mas_equalTo(0);
    }];
    
    [self.takeThireView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.height.equalTo(weakSelf.couponsChooseCell);
        make.top.equalTo(weakSelf.stationView.mas_bottom);;
    }];
    
    [_zitiTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.offset(0);
        make.left.offset(10);
    }];
    
    [_takeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-15);
        make.centerY.mas_equalTo(_zitiTitle);
        make.width.height.mas_equalTo(30);
    }];
    
    [self.remarkCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(weakSelf.couponsChooseCell);
        make.top.equalTo(weakSelf.takeThireView.mas_bottom);
    }];
    
    [self.priceCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(weakSelf.couponsChooseCell);
        make.top.equalTo(weakSelf.remarkCell.mas_bottom).offset(10);
    }];
    
    [self.integralCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(weakSelf.couponsChooseCell);
        make.top.equalTo(weakSelf.priceCell.mas_bottom).offset(10);
        make.bottom.offset(-10);
    }];
}

//配送点是否自提
- (void)takeAction
{
    if (_takeState == NO) {
        _takeState = YES;
        [_takeBtn setImage:[UIImage imageNamed:@"check-pressed"] forState:0];
        self.checkStation();
    } else {
        _takeState = NO;
        [_takeBtn setImage:[UIImage imageNamed:@"check-normal"] forState:UIControlStateNormal];
        self.uncheckStation();
    }
}

#pragma mark - getter

- (NSString *)memo {
    return _remarkCell.ys_text;
}

- (BOOL)integralUsed {
    return _integralCell.selected;
}

#pragma mark - setter
- (void)setModel:(YSOrderSettleModel *)model {
    _model = model;
    
    
    _returnIntegralCell.ys_text = [NSString stringWithFormat:@"%@积分", _model.canGetScore];
    
    _priceCell.ys_text = [NSString stringWithFormat:@"￥%.2f", _model.totalFee];
    
    _takeState = NO;
    
    if (_takeState == NO) {
        [_takeBtn setImage:[UIImage imageNamed:@"check-normal"] forState:UIControlStateNormal];
    } else {
        [_takeBtn setImage:[UIImage imageNamed:@"choose-pressed"] forState:0];
    }
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"余%@积分可抵扣", _model.score]];
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f", _model.scoreAmount] attributes:@{NSForegroundColorAttributeName:MAIN_COLOR}]];
#warning - 积分抵扣暂时隐藏
    //    if (_model.score.integerValue > 0) {
    //        _integralCell.ys_attributedText = string;
    //    } else {
    _integralCell.hidden = YES;
    
    //    }
    
    
    if (!_model.servicePointDto) {
        
        _zitiTitle.text = @"快递运送";
        _takeState = YES;
        [_takeBtn setImage:[UIImage imageNamed:@"check-pressed"] forState:0];
        
    }else{
        _zitiTitle.text = @"配送点自提";
        
    }
    
    
    if (!_station && _expressCell) {
        _expressCell.ys_text = [NSString stringWithFormat:@"￥%.2f", _model.expressFee];
    }
}

- (void)setStation:(YSServiceStation *)station {
    _station = station;
    
    [_stationView removeAllSubviews];
    [_stationHeight deactivate];
    
    MASViewAttribute *topAttribute = nil;
    
    if (_station) {
        _serviceCell.ys_contentLabel.hidden = YES;
        
        UILabel *nameLabel = [UILabel new];
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.textColor = HEX_COLOR(@"#666666");
        nameLabel.text = [NSString stringWithFormat:@"%@  %@", _station.name, _station.mobile];
        [_stationView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(15);
            make.left.offset(10);
            make.right.offset(-10);
        }];
        
        UILabel *addressLabel = [UILabel new];
        addressLabel.font = [UIFont systemFontOfSize:14];
        addressLabel.textColor = HEX_COLOR(@"#666666");
        addressLabel.numberOfLines = 0;
        addressLabel.text = _station.address;
        [_stationView addSubview:addressLabel];
        [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLabel.mas_bottom).offset(13);
            make.left.offset(10);
            make.right.offset(-10);
        }];
        
        YSButton *button = [YSButton buttonWithImagePosition:YSButtonImagePositionLeft];
        button.userInteractionEnabled = NO;
        [button setImage:[UIImage imageNamed:@"address"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:HEX_COLOR(@"#666666") forState:UIControlStateNormal];
        button.space = 10;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitle:[NSString stringWithFormat:@"%.2fkm", _station.distance] forState:UIControlStateNormal];
        [_stationView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(addressLabel.mas_bottom).offset(13);
            make.left.offset(10);
            make.height.mas_equalTo(15);
        }];
        topAttribute = button.mas_bottom;
        
        if (_station.shortestDistance) {
            UILabel *tagLabel = [UILabel new];
            tagLabel.font = [UIFont systemFontOfSize:12];
            tagLabel.textColor = MAIN_COLOR;
            tagLabel.text = @"离我最近";
            [_stationView addSubview:tagLabel];
            [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(button);
                make.left.equalTo(button.mas_right).offset(10);
            }];
        }
        
        
    }else {
        UILabel *label = [UILabel new];
        label.text = @"该城市暂无入驻的服务点, 系统默认发货方式为快递！";
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = HEX_COLOR(@"#666666");
        [_stationView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(10);
            make.left.offset(10);
            make.right.offset(-10);
        }];
        topAttribute = label.mas_bottom;
    }
    
    YSCellView *deliverCell = [self createCellWithType:YSCellViewTypeLabel Title:@"发货方式" contentFontSize:14 contentColor:HEX_COLOR(@"#666666")];
    deliverCell.userInteractionEnabled = NO;
    [_stationView addSubview:deliverCell];
    [deliverCell mas_makeConstraints:^(MASConstraintMaker *make) {
        if (topAttribute) {
            make.top.equalTo(topAttribute).offset(10);
        }else {
            make.top.offset(0);
        }
        make.left.right.offset(0);
        make.height.mas_equalTo(44);
    }];
    
    _expressCell = [self createCellWithType:YSCellViewTypeLabel Title:@"配送费" contentFontSize:14 contentColor:HEX_COLOR(@"#666666")];
    _expressCell.userInteractionEnabled = NO;
    [_stationView addSubview:_expressCell];
    [_expressCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(deliverCell.mas_bottom);
        make.left.right.height.mas_equalTo(deliverCell);
        make.bottom.offset(0);
    }];
    
    if (_station) {
        if (_station.takeTheir) {
            deliverCell.ys_text = @"自提";
            _expressCell.ys_text = [NSString stringWithFormat:@"￥%.2f", _model.sinceFee];
            _expressCell.ys_title = @"服务费";
        }else {
            deliverCell.ys_text = @"品行专送";
            _expressCell.ys_text = [NSString stringWithFormat:@"￥%.2f", _model.serviceFee];
        }
    }else {
        deliverCell.ys_text = @"快递";
        //如果存在特殊运费，则为特殊产品
        if (_model.specialExpressFee > 0) {
            if (_model.isTotalFreePost == 0) {
                
                _expressCell.ys_text = [NSString stringWithFormat:@"￥%.2f", _model.specialExpressFee];
            } else {
                if (_model.productDetails.count > 1) {
                    if (_model.isFreePost == 1) {
                        _expressCell.ys_text = [NSString stringWithFormat:@"￥%.2f", _model.specialExpressFee];
                    } else {
                        CGFloat total = _model.expressFee + _model.specialExpressFee;
                        _expressCell.ys_text = [NSString stringWithFormat:@"￥%.2f", total];
                    }
                    
                } else {
                    _expressCell.ys_text = @"￥0.00";
                }
            }
        } else {
            //如果不存在特殊运费，则为普通产品
            //如果普通产品包邮
            if (_model.isFreePost == 1) {
                _expressCell.ys_text = @"￥0.00";
            } else {
                _expressCell.ys_text = [NSString stringWithFormat:@"￥%.2f", _model.expressFee];
            }
        }
    }
}

- (void)setCoupons:(YSCoupons *)coupons {
    _coupons = coupons;
    
    _couponsChooseCell.ys_text = [NSString stringWithFormat:@"满%.2f减%.2f", _coupons.conditonMoney, _coupons.money];
    
}

- (YSCellView *)createCellWithType:(YSCellViewType)type Title:(NSString *)title contentFontSize:(CGFloat)fontSize contentColor:(UIColor *)color {
    
    YSCellView *cell = [[YSCellView alloc] initWithStyle:type];
    cell.ys_contentFont = [UIFont systemFontOfSize:fontSize];
    cell.ys_contentTextColor = color;
    cell.ys_contentTextAlignment = NSTextAlignmentRight;
    cell.ys_titleFont = [UIFont systemFontOfSize:fontSize];
    cell.ys_titleColor = HEX_COLOR(@"#333333");
    cell.ys_title = title;
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
