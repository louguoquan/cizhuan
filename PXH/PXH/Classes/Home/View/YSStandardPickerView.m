//
//  YSProductBuyView.m
//  PXH
//
//  Created by yu on 2017/8/17.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSStandardPickerView.h"
#import "YSTagListView.h"
#import "YSSteper.h"

#import "YSOrderService.h"

@interface YSStandardPickerView ()

@property (nonatomic, strong) UIImageView   *logo;

@property (nonatomic, strong) UILabel       *priceLabel;

@property (nonatomic, strong) UILabel       *descLabel;

@property (nonatomic, strong) YSSteper      *steper;

@property (nonatomic, strong) YSTagListView     *tagListView;

@property (nonatomic, strong) YSStandardDetail  *standardDetail;

@property (nonatomic, copy)   YSCompleteHandler block;

@end

@implementation YSStandardPickerView

- (instancetype)initWithProduct:(YSProductDetail *)product completion:(YSCompleteHandler)block {
    self = [super init];
    if (self) {
        _block = block;
        _productDetail = product;
        
        [self initSubviews];
        
        [self setupProductPrice];
    }
    return self;
}

- (void)initSubviews {
    
    WS(weakSelf);
    self.type = MMPopupTypeSheet;
    self.backgroundColor = [UIColor whiteColor];

    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth);
    }];
    
    _logo = [UIImageView new];
    _logo.backgroundColor = [UIColor whiteColor];
    _logo.contentMode = UIViewContentModeScaleAspectFill;
    _logo.layer.cornerRadius = 3;
    _logo.layer.borderColor = [UIColor whiteColor].CGColor;
    _logo.layer.borderWidth = 3.5;
    _logo.clipsToBounds = YES;
    [_logo sd_setImageWithURL:[NSURL URLWithString:_productDetail.image] placeholderImage:kPlaceholderImage];
    [self addSubview:_logo];
    [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(90);
        make.top.offset(-25);
        make.left.offset(10);
    }];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [closeButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        
        if ([weakSelf.steper.tf.text isEqualToString:@""]) {
            weakSelf.steper.tf.text = @"1";
        }
        [self hide];
    }];
    [self addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.offset(0);
        make.height.width.mas_equalTo(44);
    }];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:18];
    _priceLabel.textColor = MAIN_COLOR;
    [self addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.equalTo(_logo.mas_right).offset(10);
        make.right.equalTo(closeButton.mas_left).offset(-10);
    }];
    
    _descLabel = [UILabel new];
    _descLabel.textColor = HEX_COLOR(@"#555555");
    _descLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_descLabel];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_logo);
        make.left.equalTo(_logo.mas_right).offset(10);
        make.right.equalTo(closeButton.mas_left).offset(-10);
    }];
    
    _tagListView = [[YSTagListView alloc] initWithStandardArray:_productDetail.normals changeHandler:^(id result, id error) {
        [weakSelf fetchStandardDetail:result];
    }];
    [self addSubview:_tagListView];
    [_tagListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logo.mas_bottom).offset(30);
        make.left.offset(10);
        make.right.offset(-10);
    }];
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = HEX_COLOR(@"#555555");
    label.text = @"数量";
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tagListView.mas_bottom).offset(10);
        make.left.offset(10);
        make.height.mas_equalTo(30);
    }];
    
    _steper = [YSSteper new];
    _steper.defaultValue = 1;
    [self addSubview:_steper];
    [_steper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(label);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(120);
    }];

    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:18];
    confirmButton.backgroundColor = MAIN_COLOR;
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.height.mas_equalTo(44);
        make.top.equalTo(label.mas_bottom).offset(25);
    }];
}

- (void)confirm {
    
    if (USER_ID) {
        if (!_standardDetail) {
            
            [MBProgressHUD showInfoMessage:@"请选择规格" toContainer:nil];
            return;
        }
        
        if (_steper.value <= 0) {
            [MBProgressHUD showInfoMessage:@"请选择购买数量" toContainer:nil];
            return;
        }
        
        [MBProgressHUD showLoadingText:@"" toContainer:nil];
        if (_pickerType == YSStandardPickerTypePurchaseNow) {
            
            [YSOrderService commitOrderFromProduct:_productDetail.productId
                                          normalId:_standardDetail.ID
                                            number:_steper.value
                                        completion:^(id result, id error) {
                                            [MBProgressHUD dismissForContainer:nil];
                                            
                                            if (_block) {
                                                _block(result, nil);
                                            }
                                            [self hide];
                                        }];
            
        }else {
            [YSOrderService addProductToShoppingCart:_productDetail.productId
                                          standardId:_standardDetail.ID
                                              number:_steper.value completion:^(id result, id error) {
                                                  [self hide];
                                                  
                                                  [MBProgressHUD showSuccessMessage:@"添加成功" toContainer:nil];
                                                  [[NSNotificationCenter defaultCenter]postNotificationName:@"购物车添加成功" object:nil];
                                                   [[NSNotificationCenter defaultCenter]postNotificationName:@"购物车改变数量" object:nil];
                                              }];
            
        }
    } else {
        self.needLogin();
    }
}

- (void)setupProductPrice {
    
    if (_standardDetail) {
        _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", [_standardDetail.salePriceView floatValue]];
        if (_standardDetail.store == NULL) {
            _standardDetail.store = @"0";
        }
        if (_standardDetail.values == NULL) {
            _standardDetail.values = @"0";
        }
        _descLabel.text = [NSString stringWithFormat:@"库存%@   已选择:%@   %@", _standardDetail.store, _standardDetail.values, _productDetail.area];
    }else {
        _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", _productDetail.salePrice];
        _descLabel.text = [NSString stringWithFormat:@"库存%@   %@", _productDetail.store, _productDetail.area];
    }
}

- (void)fetchStandardDetail:(NSString *)specValueId {
    
    [YSProductService fetchStandardDetail:specValueId productId:_productDetail.productId completion:^(id result, id error) {
        _standardDetail = result;
        [self setupProductPrice];
    }];
}

@end
