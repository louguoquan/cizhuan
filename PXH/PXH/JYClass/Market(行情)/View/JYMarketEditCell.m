//
//  JYMarketEditCell.m
//  PXH
//
//  Created by louguoquan on 2018/5/22.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYMarketEditCell.h"

@interface JYMarketEditCell ()

@property (nonatomic, strong) UIImageView   *iconImageView;

@property (nonatomic, strong) UIImageView   *fileImageView;

@property (nonatomic, strong) UIButton   *delBtn;

@property (nonatomic, strong) UILabel  *nameLabel;

@end


@implementation JYMarketEditCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.delBtn];
    [self.contentView addSubview:self.fileImageView];
    
    
    [self.delBtn addTarget:self action:@selector(delCell) forControlEvents:UIControlEventTouchUpInside];
    
    WS(weakSelf);
    
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(21);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.width.height.mas_equalTo(27);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(self.delBtn.mas_right).offset(14);
        make.height.width.mas_equalTo(34);
        make.top.equalTo(weakSelf.contentView).offset(12);
        make.bottom.equalTo(weakSelf.contentView).offset(-12);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.iconImageView.mas_right).offset(10);
        make.height.offset(16);
        make.centerY.equalTo(weakSelf.iconImageView.mas_centerY);
    }];
    
    [self.fileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).offset(-21);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(13);
    }];
    
}

- (void)delCell{
    
    if (self.MarketEditDelectCell) {
        self.MarketEditDelectCell();
    }
    
}



- (void)setProduct:(JYMarketModel *)product
{
    
    _product = product;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:product.image] placeholderImage:[UIImage imageNamed:@"默认图"]];
    NSString * bName = product.code;
    NSString * allName;
    
    if (product.type.integerValue == 0) {
        allName  = [NSString stringWithFormat:@"/%@",@"USDT"];
    }else{
        allName  = [NSString stringWithFormat:@"/%@",@"BTC"];
    }
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@%@",bName,allName];

    
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.layer.cornerRadius = 17.0f;
        _iconImageView.layer.masksToBounds = YES;
        
    }
    return _iconImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        //        _nameLabel.font = [UIFont  fontWithName:@"Helvetica-Bold" size:15];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = HEX_COLOR(@"#000000");
    }
    return _nameLabel;
}

- (UIButton *)delBtn{
    
    if (!_delBtn) {
        
        _delBtn = [UIButton new];
        [_delBtn setImage:[UIImage imageNamed:@"JY_del"] forState:UIControlStateNormal];
        _delBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    
    return _delBtn;
}

- (UIImageView *)fileImageView
{
    if (!_fileImageView) {
        _fileImageView = [UIImageView new];
        _fileImageView.contentMode = UIViewContentModeScaleAspectFill;
        _fileImageView.clipsToBounds = YES;
        _fileImageView.image = [UIImage imageNamed:@"File"];
    }
    return _fileImageView;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
