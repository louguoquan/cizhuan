//
//  YSAddAddressViewController.m
//  PXH
//
//  Created by yu on 2017/8/8.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSAddAddressViewController.h"

#import "MMAddressView.h"
#import "YSStreetPickerView.h"

#import "YSAccountService.h"

@interface YSAddAddressViewController ()

@property (nonatomic, strong) YSCellView    *nameCell;

@property (nonatomic, strong) YSCellView    *mobileCell;

@property (nonatomic, strong) YSCellView    *regionCell;

@property (nonatomic, strong) YSCellView    *streetCell;

@property (nonatomic, strong) YSCellView    *addressCell;

@property (nonatomic, strong) YSCellView    *defaultCell;

@property (nonatomic, strong) YSRegion      *provice;

@property (nonatomic, strong) YSRegion      *city;

@property (nonatomic, strong) YSRegion      *district;

@property (nonatomic, strong) YSRegion      *street;

@end

@implementation YSAddAddressViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.navigationItem.title = @"添加新地址";
    
    [self initSubviews];
    
    self.type = 0;
}

- (void)setType:(NSInteger)type
{
    if (!_type) {
        _type = type;
    }
}

- (void)initSubviews {
 
    self.scrollView.backgroundColor = BACKGROUND_COLOR;
    
    WS(weakSelf);
    _nameCell = [self createCellViewForTitle:@"收货人" placeHolder:@"请输入收货人姓名"];
    [self.containerView addSubview:_nameCell];
    [_nameCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(45);
    }];
    
    _mobileCell = [self createCellViewForTitle:@"手机号" placeHolder:@"请输入收货人手机号"];
    [self.containerView addSubview:_mobileCell];
    [_mobileCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameCell.mas_bottom);
        make.left.right.offset(0);
        make.height.mas_equalTo(45);
    }];
    
    _regionCell = [self createCellViewForTitle:@"省市区" placeHolder:@"请选择收货地址"];
    _regionCell.ys_textFiled.userInteractionEnabled = NO;
    _regionCell.ys_accessoryType = YSCellAccessoryDisclosureIndicator;
    [_regionCell addTarget:self action:@selector(chooseRegion) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:_regionCell];
    [_regionCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mobileCell.mas_bottom);
        make.left.right.offset(0);
        make.height.mas_equalTo(45);
    }];

    _streetCell = [self createCellViewForTitle:@"街道" placeHolder:@"请选择街道"];
    _streetCell.ys_textFiled.userInteractionEnabled = NO;
    _streetCell.ys_accessoryType = YSCellAccessoryDisclosureIndicator;
    [_streetCell addTarget:self action:@selector(chooseStreet) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:_streetCell];
    [_streetCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.regionCell.mas_bottom);
        make.left.right.offset(0);
        make.height.mas_equalTo(45);
    }];

    _addressCell = [self createCellViewForTitle:@"详细地址" placeHolder:@"请输入详细地址"];
    [self.containerView addSubview:_addressCell];
    [_addressCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.streetCell.mas_bottom);
        make.left.right.offset(0);
        make.height.mas_equalTo(45);
    }];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button jm_setCornerRadius:1 withBackgroundColor:MAIN_COLOR];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addressCell.mas_bottom).offset(45);
        make.left.offset(15);
        make.right.offset(-15);
        make.height.mas_equalTo(45);
        make.bottom.offset(-20);
    }];

    if (_address) {
        _nameCell.ys_text = _address.name;
        _mobileCell.ys_text = _address.mobile;
        _addressCell.ys_text = _address.address;
        
        _provice = [[YSRegion alloc] initWithId:_address.provinceId name:_address.provinceName];
        _city = [[YSRegion alloc] initWithId:_address.cityId name:_address.cityName];
        _district = [[YSRegion alloc] initWithId:_address.districtId name:_address.districtName];
        _street = [[YSRegion alloc] initWithId:_address.streetId name:_address.streetName];
        
        _regionCell.ys_text = [NSString stringWithFormat:@"%@%@%@", _address.provinceName, _address.cityName, _address.districtName];
        
        _streetCell.ys_text = _address.streetName;
    }
}

- (void)chooseRegion {
    WS(weakSelf);
    MMAddressView *addressView = [MMAddressView new];
    addressView.block = ^(YSRegion *provice, YSRegion *city, YSRegion *district) {
        if (provice && city && district) {
            weakSelf.provice = provice;
            weakSelf.city = city;
            weakSelf.district = district;
            weakSelf.regionCell.ys_text = [NSString stringWithFormat:@"%@%@%@", provice.name, city.name, district.name];
            weakSelf.streetCell.ys_text = @"";
        }
    };
    [addressView show];
}

- (void)chooseStreet {
    
    if (!_district) {
        [MBProgressHUD showInfoMessage:@"请先选择省市区" toContainer:self.view];
        return;
    }
    
    YSStreetPickerView *pickerView = [[YSStreetPickerView alloc] initWithDistrictId:_district.ID];
    pickerView.block = ^(id result, id error) {
        _street = result;
        _streetCell.ys_text = _street.name;
    };
    
    [pickerView show];
}


- (void)save {
    
    [self.view endEditing:YES];
    if (_nameCell.ys_text.length <= 0 || _mobileCell.ys_text.length <= 0 || _regionCell.ys_text.length <= 0 || _streetCell.ys_text.length <= 0) {
        [MBProgressHUD showInfoMessage:@"请补全收货地址信息" toContainer:nil];
        return;
    }
    if (![YSAccountService isMobile:_mobileCell.ys_text]) {
        [MBProgressHUD showInfoMessage:@"请输入正确的手机号" toContainer:nil];
        return;
    }
    
    [MBProgressHUD showLoadingText:@"正在保存" toContainer:nil];
    
    [YSAddressService saveAddressWithProvinceId:_provice.ID
                                         cityId:_city.ID
                                     districtId:_district.ID
                                       streetId:_street.ID
                                        address:_addressCell.ys_text
                                           name:_nameCell.ys_text
                                         mobile:_mobileCell.ys_text
                                      addressId:_address.ID
                                     completion:^(id result, id error) {
                                         if (self.type != 0) {
                                             self.saveAddress(result);
                                         }
                                         
                                         [MBProgressHUD showSuccessMessage:@"保存成功" toContainer:nil];
                                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                             [self.navigationController popViewControllerAnimated:YES];
                                         });
                                     }];
    
}

- (YSCellView *)createCellViewForTitle:(NSString *)title placeHolder:(NSString *)placeHolder {
    YSCellView *cell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    cell.backgroundColor = [UIColor whiteColor];
    cell.ys_title = title;
    cell.ys_titleFont = [UIFont systemFontOfSize:15];
    cell.ys_titleColor = HEX_COLOR(@"#666666");
    cell.ys_contentFont = [UIFont systemFontOfSize:15];
    cell.ys_titleWidth = 15 * 5;
    cell.ys_contentPlaceHolder = placeHolder;
    cell.ys_bottomLineHidden = NO;
    cell.ys_contentFont = [UIFont systemFontOfSize:13];
    
    return cell;
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
