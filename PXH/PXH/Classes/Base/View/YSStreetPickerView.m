//
//  YSStreetPickerView.m
//  PXH
//
//  Created by yu on 2017/8/20.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSStreetPickerView.h"

#import "MMPopupDefine.h"
#import "MMPopupCategory.h"
#import "Masonry.h"

//#import "YSRegionReformer.h"

@interface YSStreetPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UIButton *btnConfirm;

@property (nonatomic, strong) UIPickerView      *addressPicker;
@property (nonatomic, strong) NSArray           *dataSource;

@property (nonatomic, strong) NSString  *districtId;

@end

@implementation YSStreetPickerView

- (instancetype)initWithDistrictId:(NSString *)districtId
{
    self = [super init];
    
    if ( self )
    {
        _districtId = districtId;
        
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
//    [[YSRegionReformer shareInstance] fetchStreetListWithDistrictId:_districtId success:^(id responseObject) {
//        _dataSource = responseObject;
//        [_addressPicker reloadAllComponents];
//    } failure:^(SDError *error) {
//        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
//    }];

}

- (void)actionHide:(UIButton *)button
{
    if (button.tag == 10 && [_dataSource count] > 0) {
        if (_block) {
            NSInteger row1 = [_addressPicker selectedRowInComponent:0];
            YSRegion *street = _dataSource[row1];
            _block(street, nil);
        }
    }
    [self hide];
}

#pragma mark - picker dataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_dataSource count];
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
    
    YSRegion *region = _dataSource[row];
    pickerLabel.text = region.name;

    return pickerLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
