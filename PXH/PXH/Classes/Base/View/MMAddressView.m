//
//  MMAddressView.m
//  QingTao
//
//  Created by yu on 16/4/22.
//  Copyright © 2016年 com.sunday-mobi. All rights reserved.
//

#import "MMAddressView.h"
#import "MMPopupDefine.h"
#import "MMPopupCategory.h"
#import "Masonry.h"

//#import "YSRegionReformer.h"

@interface MMAddressView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UIButton *btnConfirm;

@property (nonatomic, strong) UIPickerView      *addressPicker;
@property (nonatomic, strong) NSArray           *dataSource;

@end

@implementation MMAddressView

- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        self.type = MMPopupTypeSheet;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            make.height.mas_equalTo(216+50);
        }];
        
        self.btnCancel = [UIButton mm_buttonWithTarget:self action:@selector(actionHide:)];
        [self addSubview:self.btnCancel];
        [self.btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 50));
            make.left.top.equalTo(self);
        }];
        [self.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [self.btnCancel setTitleColor:MMHexColor(0xE76153FF) forState:UIControlStateNormal];
        
        
        self.btnConfirm = [UIButton mm_buttonWithTarget:self action:@selector(actionHide:)];
        [self addSubview:self.btnConfirm];
        self.btnConfirm.tag = 10;
        [self.btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 50));
            make.right.top.equalTo(self);
        }];
        [self.btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
        [self.btnConfirm setTitleColor:MMHexColor(0xE76153FF) forState:UIControlStateNormal];
        
        self.addressPicker = [UIPickerView new];
        self.addressPicker.delegate = self;
        self.addressPicker.dataSource = self;
        [self addSubview:self.addressPicker];
        [self.addressPicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(50, 0, 0, 0));
        }];
        
        _dataSource = [NSArray array];
        [self reloadRegion];
    }
    
    return self;
}

- (void)reloadRegion
{
    WS(weakSelf);
//    [[YSRegionReformer shareInstance] fetchRegionListSuccess:^(id responseObject) {
//        weakSelf.dataSource = responseObject;
//        [weakSelf.addressPicker reloadAllComponents];
//    } failure:^(SDError *error) {
//        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
//    }];
}

- (void)actionHide:(UIButton *)button
{
    if (button.tag == 10 && [_dataSource count] > 0) {
        if (_block) {
            NSInteger row1 = [_addressPicker selectedRowInComponent:0];
            YSRegion *provice = _dataSource[row1];
            NSInteger row2 = [_addressPicker selectedRowInComponent:1];
            if (provice.childreList.count <= 0) {
                _block(provice,nil,nil);
                [self hide];
                return;
            }
            YSRegion *city = provice.childreList[row2];
            NSInteger row3 = [_addressPicker selectedRowInComponent:2];
            if (city.childreList.count <= 0) {
                _block(provice,city,nil);
                [self hide];
                return;
            }
            YSRegion *district = city.childreList[row3];
            _block(provice,city,district);
        }
    }
    [self hide];
}

#pragma mark - picker dataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [_dataSource count];
    }else if (component == 1) {
        NSInteger row1 = [pickerView selectedRowInComponent:0];
        if ([_dataSource count] > row1) {
            YSRegion *provice = _dataSource[row1];
            return [provice.childreList count];
        }
    }else {
        NSInteger row1 = [pickerView selectedRowInComponent:0];
        if ([_dataSource count] > row1) {
            YSRegion *provice = _dataSource[row1];
            NSInteger row2 = [pickerView selectedRowInComponent:1];
            if ([provice.childreList count] > row2) {
                YSRegion *city = provice.childreList[row2];
                return [city.childreList count];
            }
        }
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }

    NSString *title = nil;
    if (component == 0) {
        YSRegion *region = _dataSource[row];
        title = region.name;
    }else if (component == 1) {
        NSInteger row1 = [pickerView selectedRowInComponent:0];
        YSRegion *provice = _dataSource[row1];
        YSRegion *city = provice.childreList[row];
        title = city.name;
    }else {
        NSInteger row1 = [pickerView selectedRowInComponent:0];
        YSRegion *provice = _dataSource[row1];
        NSInteger row2 = [pickerView selectedRowInComponent:1];
        YSRegion *city = provice.childreList[row2];
        YSRegion *district = city.childreList[row];
        title = district.name;
    }
    
    pickerLabel.text = title;
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component < 2) {
        [pickerView reloadComponent:component + 1];
        if (component == 0) {
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView reloadComponent:2];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
