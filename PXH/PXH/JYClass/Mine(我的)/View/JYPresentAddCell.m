//
//  JYPresentAddCell.m
//  PXH
//
//  Created by LX on 2018/6/14.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYPresentAddCell.h"

@interface JYPresentAddCell ()

@property (nonatomic, strong) UIImageView       *iconImgView;
@property (nonatomic, strong) UILabel           *coinNameLab;
@property (nonatomic, strong) UILabel           *addressLab;

@end


@implementation JYPresentAddCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONBG);
        
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI
{
    WS(weakSelf)
    
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
        make.width.height.mas_equalTo(25);
    }];
    
    [self.coinNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.iconImgView);
        make.left.equalTo(weakSelf.iconImgView.mas_right).offset(15.f);
        make.right.mas_equalTo(-15);
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.coinNameLab.mas_bottom).offset(10.f);
        make.left.right.equalTo(weakSelf.coinNameLab);
        make.bottom.mas_equalTo(-15);
    }];
}

-(void)setAddModel:(JYPresentAddModel *)addModel
{
    _addModel = addModel;
    
    self.coinNameLab.text = [NSString stringWithFormat:@"%@(%@)", addModel.coinCode, addModel.coinName];
    
    self.addressLab.text = addModel.address;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UIImageView *)iconImgView
{
    if (!_iconImgView) {
        UIImageView *imgView = [UIImageView new];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.image = [UIImage imageNamed:@"icon_Address"];
        [self.contentView addSubview:imgView];
        
        _iconImgView = imgView;
    }
    return _iconImgView;
}

-(UILabel *)coinNameLab
{
    if (!_coinNameLab) {
        UILabel *lab = [UILabel new];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:15.f];
        lab.dk_textColorPicker = DKColorPickerWithKey(LABELTEXT);
        [self.contentView addSubview:lab];
        
        _coinNameLab = lab;
    }
    return _coinNameLab;
}

-(UILabel *)addressLab
{
    if (!_addressLab) {
        UILabel *lab = [UILabel new];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:15.f];
//        lab.dk_textColorPicker = DKColorPickerWithKey(LABELTEXT);
        [self.contentView addSubview:lab];
        
        _addressLab = lab;
    }
    return _addressLab;
}

@end
